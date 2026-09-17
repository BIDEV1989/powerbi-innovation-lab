# PowerShell metadata collector

`Get-PowerBIControlCenterMetadata.ps1` is a sanitized reference collector for the sample project.

It collects accessible Power BI workspaces, reports, semantic models and refresh history using the Power BI REST APIs / MicrosoftPowerBIMgmt module. It derives a simple current health state and can append current-state snapshots for historical analysis.

The script intentionally contains no tenant-specific configuration or secrets. Access is limited to what the signed-in identity is permitted to see.

Typical outputs:

- `PBI_ControlCenter_Workspaces.csv`
- `PBI_ControlCenter_Reports.csv`
- `PBI_ControlCenter_SemanticModels.csv`
- `PBI_ControlCenter_RefreshHistory.csv`
- `PBI_ControlCenter_Current.csv`
- `PBI_ControlCenter_Errors.csv`
- `PBI_ControlCenter_SnapshotHistory.csv` when `-AppendSnapshotHistory` is used

This is a community/reference implementation, not an official Microsoft administration product.
