let
    Source = #table(type table [#"WorkspaceId" = text, #"WorkspaceName" = text, #"Environment" = text, #"WorkspaceOrder" = Int64.Type, #"RunTimestampUTC" = datetime], {
        {"548cf0e0-454d-5ad9-9dd6-733f48e562a4", "Commercial Analytics", "SAMPLE", 1, #datetime(2026, 9, 12, 12, 0, 0)},
        {"72af45ab-47a8-5b5c-a73e-f376e5cfa4c9", "Operations", "SAMPLE", 2, #datetime(2026, 9, 12, 12, 0, 0)},
        {"ec69cb8d-2f63-5925-836e-310f33014929", "Quality", "SAMPLE", 3, #datetime(2026, 9, 12, 12, 0, 0)},
        {"7fd6d6af-391f-56e1-baf2-1791194b493a", "Supply Planning", "SAMPLE", 4, #datetime(2026, 9, 12, 12, 0, 0)},
        {"0da27c99-e0b3-5be5-94b9-4b871dbe7f50", "Product Insights", "SAMPLE", 5, #datetime(2026, 9, 12, 12, 0, 0)},
        {"f15f8786-f6ce-550a-a351-870b50a85adb", "Finance", "SAMPLE", 6, #datetime(2026, 9, 12, 12, 0, 0)},
        {"573efda1-a917-547a-8e8d-0e372635bebf", "Research", "SAMPLE", 7, #datetime(2026, 9, 12, 12, 0, 0)},
        {"9324b505-a143-5aaa-8049-27dd51e55af7", "Shared Services", "SAMPLE", 8, #datetime(2026, 9, 12, 12, 0, 0)}
    })
in
    Source