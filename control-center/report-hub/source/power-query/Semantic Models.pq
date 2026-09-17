let
    Source = #table(type table [#"WorkspaceId" = text, #"SemanticModelId" = text, #"SemanticModelName" = text, #"SemanticModelOwner" = text, #"IsRefreshable" = logical, #"StorageMode" = text, #"RunTimestampUTC" = datetime], {
        {"548cf0e0-454d-5ad9-9dd6-733f48e562a4", "dbe3fb0b-e5ae-5ca3-aa98-42df1a87030b", "Commercial Analytics - Core", "owner01@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"548cf0e0-454d-5ad9-9dd6-733f48e562a4", "b2e0a1e7-cc92-5761-bfd4-aca212b0320b", "Commercial Analytics - Planning", "owner02@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"548cf0e0-454d-5ad9-9dd6-733f48e562a4", "5b91b2f7-42b8-5b77-996c-645f26ca742d", "Commercial Analytics - Detail", "owner03@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"72af45ab-47a8-5b5c-a73e-f376e5cfa4c9", "9aacdf66-e2c2-5ea0-bca8-053ef19398f0", "Operations - Core", "owner04@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"72af45ab-47a8-5b5c-a73e-f376e5cfa4c9", "ee3332e7-458a-5953-b9e3-028a9f71c488", "Operations - Planning", "owner05@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"72af45ab-47a8-5b5c-a73e-f376e5cfa4c9", "d8af86a8-670b-5324-ba88-dc35cf761deb", "Operations - Detail", "owner06@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"ec69cb8d-2f63-5925-836e-310f33014929", "b632e64b-5c32-5ab5-980b-500f5d0cf70f", "Quality - Core", "owner07@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"ec69cb8d-2f63-5925-836e-310f33014929", "a0cd07bb-6249-537d-bdee-fb3770174da9", "Quality - Planning", "owner08@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"ec69cb8d-2f63-5925-836e-310f33014929", "e6d54184-125e-5884-a8b0-8b20f93e285c", "Quality - Detail", "owner09@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"7fd6d6af-391f-56e1-baf2-1791194b493a", "d57e694e-8500-541f-b74d-a1ecc232cb08", "Supply Planning - Core", "owner10@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"7fd6d6af-391f-56e1-baf2-1791194b493a", "1b299595-66f2-5935-8708-c11cb07e3196", "Supply Planning - Planning", "owner11@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"7fd6d6af-391f-56e1-baf2-1791194b493a", "29f38210-7917-52dd-a9e7-f07c5b03b222", "Supply Planning - Detail", "owner12@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"0da27c99-e0b3-5be5-94b9-4b871dbe7f50", "5b1d441b-8620-50a4-9636-ca31cd3fb2b9", "Product Insights - Core", "owner13@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"0da27c99-e0b3-5be5-94b9-4b871dbe7f50", "3bd0eb12-6ad2-53dd-9e24-11b73e89d959", "Product Insights - Planning", "owner14@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"0da27c99-e0b3-5be5-94b9-4b871dbe7f50", "f6db0003-1517-5fb0-8962-409c25108cbe", "Product Insights - Detail", "owner15@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"f15f8786-f6ce-550a-a351-870b50a85adb", "e2b38bce-7e57-5ebb-8e20-89c256cc6c00", "Finance - Core", "owner16@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"f15f8786-f6ce-550a-a351-870b50a85adb", "059fe7a4-df31-541c-871f-822c9b4b7983", "Finance - Planning", "owner17@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"f15f8786-f6ce-550a-a351-870b50a85adb", "65582633-28c4-5cd5-ad4a-8b9843ee5de9", "Finance - Detail", "owner18@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"573efda1-a917-547a-8e8d-0e372635bebf", "4b29d0b0-e136-559c-ba31-529ab9050979", "Research - Core", "owner19@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"573efda1-a917-547a-8e8d-0e372635bebf", "8119de37-0c3e-5bb0-95fa-8abce5bd2c84", "Research - Planning", "owner20@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"573efda1-a917-547a-8e8d-0e372635bebf", "c0890614-b5fa-5644-bd8b-fb6de4fb43f9", "Research - Detail", "owner21@example.com", false, "DirectQuery", #datetime(2026, 9, 12, 12, 0, 0)},
        {"9324b505-a143-5aaa-8049-27dd51e55af7", "3afaac19-f77b-5908-b6ae-33e13a16aff1", "Shared Services - Core", "owner22@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"9324b505-a143-5aaa-8049-27dd51e55af7", "19e53278-1045-58e3-830f-ecc6befcb452", "Shared Services - Planning", "owner23@example.com", true, "Import", #datetime(2026, 9, 12, 12, 0, 0)},
        {"9324b505-a143-5aaa-8049-27dd51e55af7", "21bd7058-3701-558e-89c8-7c2c60657d65", "Shared Services - Detail", "owner24@example.com", false, "DirectQuery", #datetime(2026, 9, 12, 12, 0, 0)}
    }),
    WithKey = Table.AddColumn(Source, "ModelKey", each [WorkspaceId] & "|" & [SemanticModelId], type text),
    Joined = Table.NestedJoin(WithKey, {"ModelKey"}, #"PBI Refresh History", {"ModelKey"}, "Executions", JoinKind.LeftOuter),
    WithLatest = Table.AddColumn(Joined, "Latest", each
        if Table.IsEmpty([Executions]) then
            [StartTimeUTC=null, EndTimeUTC=null, RefreshStatus=null, DurationSeconds=null]
        else Table.First(Table.Sort([Executions], {{"StartTimeUTC", Order.Descending}, {"RefreshId", Order.Descending}})), type record),
    Expanded = Table.ExpandRecordColumn(WithLatest, "Latest",
        {"StartTimeUTC", "EndTimeUTC", "RefreshStatus", "DurationSeconds"},
        {"LastRefreshUTC", "LastRefreshEndUTC", "LastRefreshStatus", "LastRefreshDurationSeconds"}),
    WithHealth = Table.AddColumn(Expanded, "HealthStatus", each
        if not [IsRefreshable] then "NOT REFRESHABLE"
        else if [LastRefreshUTC] = null then "NO REFRESH HISTORY"
        else if [LastRefreshStatus] = "Completed" then "HEALTHY"
        else if [LastRefreshStatus] = "Failed" then "REFRESH FAILED"
        else if [LastRefreshEndUTC] = null then "IN PROGRESS"
        else "UNKNOWN", type text),
    Clean = Table.RemoveColumns(WithHealth, {"Executions"}),
    Typed = Table.TransformColumnTypes(Clean, {{"LastRefreshUTC", type datetime}, {"LastRefreshEndUTC", type datetime}, {"LastRefreshStatus", type text}, {"LastRefreshDurationSeconds", Int64.Type}})
in
    Typed