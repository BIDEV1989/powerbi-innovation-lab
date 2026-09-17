# Power BI Control Center / Report Hub

A sanitized sample implementation of a centralized Power BI workspace, report, semantic model, and refresh monitoring solution.

## Architecture

Power BI Service
→ Power BI REST APIs
→ PowerShell
→ CSV snapshots / SharePoint
→ Power BI semantic model
→ DAX + HTML/CSS

This Control Center / Report Hub sample is isolated under `control-center/report-hub/`. Other Power BI innovation projects may be added elsewhere in this repository later.

## Downloadable ZIP

**[`PowerBI_Control_Center_Public_Sample.zip`](PowerBI_Control_Center_Public_Sample.zip) is the complete downloadable sample.** Download that ZIP to open the PBIP project, synthetic sample data, and setup instructions in Power BI Desktop.

The folders below are extracted from that same ZIP so you can inspect the implementation on GitHub without unzipping first. They are not a second sample.

The ZIP contains:

- PBIP sample project
- synthetic sample data
- sanitized PowerShell metadata collector
- DAX
- HTML/CSS
- Power Query
- screenshots
- architecture documentation
- setup instructions

## Explore the implementation

Inspect these files on GitHub. They all come from the sanitized ZIP.

| What to explore | Path |
|---|---|
| Architecture | [`architecture/Architecture_Case_Study.pdf`](architecture/Architecture_Case_Study.pdf) |
| PowerShell metadata collector | [`powershell/Get-PowerBIControlCenterMetadata.ps1`](powershell/Get-PowerBIControlCenterMetadata.ps1) |
| DAX | [`source/dax/`](source/dax/) |
| HTML/CSS | [`source/css/`](source/css/) |
| Power Query | [`source/power-query/`](source/power-query/) |
| Screenshots | [`screenshots/`](screenshots/) |
| Complete ZIP download | [`PowerBI_Control_Center_Public_Sample.zip`](PowerBI_Control_Center_Public_Sample.zip) |

- **Architecture** — case-study PDF from the ZIP (`Documentation/Architecture_Case_Study.pdf`). The ZIP does not include a file named `PowerBI_Control_Center_Architecture.pdf`.
- **PowerShell metadata collector** — sanitized reference script. See also [`powershell/README.md`](powershell/README.md).
- **DAX** — numeric and HTML measures used by Report Hub and Refresh History.
- **HTML/CSS** — stylesheets for workspace cards, report cards, and refresh history.
- **Power Query** — inline synthetic sources and transformation logic.
- **Screenshots** — sanitized Report Hub and Refresh History images.

## Important notices

- All sample data is synthetic.
- No company-specific data or credentials are included.
- This is a community/reference implementation.
- It is not an official Microsoft product.
- Users should review API permissions and scripts before using them in their own environment.
