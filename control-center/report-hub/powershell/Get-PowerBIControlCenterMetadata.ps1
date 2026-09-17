<#
.SYNOPSIS
  Collects Power BI workspace, report, semantic-model and refresh metadata into CSV files.

.DESCRIPTION
  Public/sanitized reference implementation for the Power BI Control Center sample.
  Uses interactive Power BI authentication. No tenant IDs, credentials, secrets, employer
  domains, or internal URLs are embedded in this script.

.PREREQUISITES
  Install-Module MicrosoftPowerBIMgmt -Scope CurrentUser

.EXAMPLE
  .\Get-PowerBIControlCenterMetadata.ps1 -OutputFolder "C:\PBI-ControlCenter\Metadata"
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$OutputFolder,

    [ValidateRange(1, 100)]
    [int]$RefreshHistoryTop = 60,

    [switch]$AppendSnapshotHistory
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Ensure-Folder {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

function Invoke-PbiJson {
    param([Parameter(Mandatory = $true)][string]$Url)
    $raw = Invoke-PowerBIRestMethod -Url $Url -Method Get
    if ([string]::IsNullOrWhiteSpace($raw)) { return $null }
    return $raw | ConvertFrom-Json
}

function Export-Rows {
    param($Rows, [string]$Path)
    @($Rows) | Export-Csv -Path $Path -NoTypeInformation -Encoding UTF8
}

Ensure-Folder $OutputFolder
Import-Module MicrosoftPowerBIMgmt -ErrorAction Stop
Connect-PowerBIServiceAccount | Out-Null

$runUtc = (Get-Date).ToUniversalTime()
$runTimestamp = $runUtc.ToString('o')

$workspaceRows = [System.Collections.Generic.List[object]]::new()
$reportRows = [System.Collections.Generic.List[object]]::new()
$modelRows = [System.Collections.Generic.List[object]]::new()
$refreshRows = [System.Collections.Generic.List[object]]::new()
$currentRows = [System.Collections.Generic.List[object]]::new()
$errorRows = [System.Collections.Generic.List[object]]::new()

$workspaces = @(Get-PowerBIWorkspace -All)

foreach ($ws in $workspaces) {
    $workspaceRows.Add([pscustomobject]@{
        RunTimestampUTC = $runTimestamp
        WorkspaceId     = [string]$ws.Id
        WorkspaceName   = $ws.Name
        WorkspaceType   = [string]$ws.Type
        WorkspaceState  = [string]$ws.State
    })

    try {
        $reportsPayload = Invoke-PbiJson "groups/$($ws.Id)/reports"
        $reports = @($reportsPayload.value)
    }
    catch {
        $reports = @()
        $errorRows.Add([pscustomobject]@{ RunTimestampUTC=$runTimestamp; WorkspaceId=[string]$ws.Id; WorkspaceName=$ws.Name; Area='Reports'; Error=$_.Exception.Message })
    }

    try {
        $modelsPayload = Invoke-PbiJson "groups/$($ws.Id)/datasets"
        $models = @($modelsPayload.value)
    }
    catch {
        $models = @()
        $errorRows.Add([pscustomobject]@{ RunTimestampUTC=$runTimestamp; WorkspaceId=[string]$ws.Id; WorkspaceName=$ws.Name; Area='SemanticModels'; Error=$_.Exception.Message })
    }

    $modelLookup = @{}
    foreach ($model in $models) {
        $modelLookup[[string]$model.id] = $model
        $latest = $null

        try {
            $refreshPayload = Invoke-PbiJson "groups/$($ws.Id)/datasets/$($model.id)/refreshes?`$top=$RefreshHistoryTop"
            $refreshes = @($refreshPayload.value)
            foreach ($refresh in $refreshes) {
                $duration = $null
                if ($refresh.startTime -and $refresh.endTime) {
                    try {
                        $duration = [math]::Round(((Get-Date $refresh.endTime) - (Get-Date $refresh.startTime)).TotalSeconds, 0)
                    } catch {}
                }
                $refreshRows.Add([pscustomobject]@{
                    RunTimestampUTC = $runTimestamp
                    WorkspaceId = [string]$ws.Id
                    WorkspaceName = $ws.Name
                    SemanticModelId = [string]$model.id
                    SemanticModelName = $model.name
                    RefreshId = [string]$refresh.requestId
                    RefreshType = [string]$refresh.refreshType
                    RefreshStatus = [string]$refresh.status
                    StartTimeUTC = [string]$refresh.startTime
                    EndTimeUTC = [string]$refresh.endTime
                    DurationSeconds = $duration
                })
            }
            $latest = $refreshes | Sort-Object { if ($_.endTime) { $_.endTime } else { $_.startTime } } -Descending | Select-Object -First 1
        }
        catch {
            $errorRows.Add([pscustomobject]@{ RunTimestampUTC=$runTimestamp; WorkspaceId=[string]$ws.Id; WorkspaceName=$ws.Name; Area="RefreshHistory:$($model.name)"; Error=$_.Exception.Message })
        }

        $lastDuration = $null
        if ($latest -and $latest.startTime -and $latest.endTime) {
            try { $lastDuration = [math]::Round(((Get-Date $latest.endTime) - (Get-Date $latest.startTime)).TotalSeconds, 0) } catch {}
        }

        $modelRows.Add([pscustomobject]@{
            RunTimestampUTC = $runTimestamp
            WorkspaceId = [string]$ws.Id
            WorkspaceName = $ws.Name
            SemanticModelId = [string]$model.id
            SemanticModelName = $model.name
            OwnerConfiguredBy = $model.configuredBy
            IsRefreshable = $model.isRefreshable
            IsOnPremisesGatewayEnabled = $model.isOnPremisesGatewayEnabled
            TargetStorageMode = $model.targetStorageMode
            LastRefreshUTC = if ($latest) { $latest.endTime } else { $null }
            LastRefreshStatus = if ($latest) { $latest.status } else { $null }
            LastRefreshType = if ($latest) { $latest.refreshType } else { $null }
            LastRefreshDurationSeconds = $lastDuration
        })
    }

    foreach ($report in $reports) {
        $modelId = [string]$report.datasetId
        $model = if ($modelId -and $modelLookup.ContainsKey($modelId)) { $modelLookup[$modelId] } else { $null }
        $latestForReport = $refreshRows | Where-Object { $_.WorkspaceId -eq [string]$ws.Id -and $_.SemanticModelId -eq $modelId } | Sort-Object EndTimeUTC -Descending | Select-Object -First 1

        $health = 'UNKNOWN'
        if ([string]::IsNullOrWhiteSpace($modelId)) { $health = 'NO SEMANTIC MODEL' }
        elseif (-not $model) { $health = 'MODEL OUTSIDE ACCESS' }
        elseif ($model.isRefreshable -ne $true) { $health = 'NOT REFRESHABLE' }
        elseif ($latestForReport) {
            switch -Regex ([string]$latestForReport.RefreshStatus) {
                '^Completed$' { $health = 'HEALTHY'; break }
                '^Failed$'    { $health = 'REFRESH FAILED'; break }
                '^Unknown$'   { $health = 'REFRESH UNKNOWN'; break }
                default       { $health = ([string]$latestForReport.RefreshStatus).ToUpperInvariant() }
            }
        }
        else { $health = 'NO REFRESH HISTORY' }

        $reportRows.Add([pscustomobject]@{
            RunTimestampUTC = $runTimestamp
            WorkspaceId = [string]$ws.Id
            WorkspaceName = $ws.Name
            ReportId = [string]$report.id
            ReportName = $report.name
            ReportType = $report.reportType
            ReportUrl = $report.webUrl
            SemanticModelId = $modelId
        })

        $currentRows.Add([pscustomobject]@{
            RunTimestampUTC = $runTimestamp
            WorkspaceName = $ws.Name
            WorkspaceId = [string]$ws.Id
            ReportName = $report.name
            ReportId = [string]$report.id
            ReportType = $report.reportType
            ReportUrl = $report.webUrl
            SemanticModelName = if ($model) { $model.name } else { $null }
            SemanticModelId = $modelId
            SemanticModelWorkspace = if ($model) { $ws.Name } else { $null }
            SemanticModelOwner = if ($model) { $model.configuredBy } else { $null }
            IsRefreshable = if ($model) { $model.isRefreshable } else { $null }
            LastRefreshUTC = if ($latestForReport) { $latestForReport.EndTimeUTC } else { $null }
            LastRefreshStatus = if ($latestForReport) { $latestForReport.RefreshStatus } else { $null }
            LastRefreshType = if ($latestForReport) { $latestForReport.RefreshType } else { $null }
            LastRefreshDurationSeconds = if ($latestForReport) { $latestForReport.DurationSeconds } else { $null }
            HealthStatus = $health
        })
    }
}

$paths = @{
    Workspaces = Join-Path $OutputFolder 'PBI_ControlCenter_Workspaces.csv'
    Reports = Join-Path $OutputFolder 'PBI_ControlCenter_Reports.csv'
    SemanticModels = Join-Path $OutputFolder 'PBI_ControlCenter_SemanticModels.csv'
    RefreshHistory = Join-Path $OutputFolder 'PBI_ControlCenter_RefreshHistory.csv'
    Current = Join-Path $OutputFolder 'PBI_ControlCenter_Current.csv'
    Errors = Join-Path $OutputFolder 'PBI_ControlCenter_Errors.csv'
    SnapshotHistory = Join-Path $OutputFolder 'PBI_ControlCenter_SnapshotHistory.csv'
}

Export-Rows $workspaceRows $paths.Workspaces
Export-Rows $reportRows $paths.Reports
Export-Rows $modelRows $paths.SemanticModels
Export-Rows $refreshRows $paths.RefreshHistory
Export-Rows $currentRows $paths.Current
Export-Rows $errorRows $paths.Errors

if ($AppendSnapshotHistory -and $currentRows.Count -gt 0) {
    if (Test-Path $paths.SnapshotHistory) {
        $currentRows | Export-Csv -Path $paths.SnapshotHistory -NoTypeInformation -Encoding UTF8 -Append
    } else {
        $currentRows | Export-Csv -Path $paths.SnapshotHistory -NoTypeInformation -Encoding UTF8
    }
}

Write-Host "Power BI Control Center extraction complete." -ForegroundColor Green
Write-Host "Workspaces:      $($workspaceRows.Count)"
Write-Host "Reports:         $($reportRows.Count)"
Write-Host "Semantic models: $($modelRows.Count)"
Write-Host "Refresh records: $($refreshRows.Count)"
Write-Host "Errors captured: $($errorRows.Count)"
Write-Host "Output:          $OutputFolder"
