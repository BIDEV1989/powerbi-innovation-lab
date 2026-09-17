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

The downloadable ZIP (`PowerBI_Control_Center_Public_Sample.zip`) contains:

- PBIP sample project
- synthetic sample data
- sanitized PowerShell metadata collector
- DAX
- HTML/CSS
- Power Query
- screenshots
- architecture documentation
- setup instructions

## Important notices

- All sample data is synthetic.
- No company-specific data or credentials are included.
- This is a community/reference implementation.
- It is not an official Microsoft product.
- Users should review API permissions and scripts before using them in their own environment.
