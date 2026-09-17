let
    Source = #"Sample Raw Refreshes",
    Sorted = Table.Sort(Source, {{"RunTimestampUTC", Order.Descending}, {"RefreshId", Order.Descending}}),
    Buffered = Table.Buffer(Sorted),
    LatestObservation = Table.Distinct(Buffered, {"WorkspaceId", "SemanticModelId", "RefreshId"}),
    WithKey = Table.AddColumn(LatestObservation, "ModelKey", each [WorkspaceId] & "|" & [SemanticModelId], type text),
    WithDate = Table.AddColumn(WithKey, "RefreshDate", each Date.From([StartTimeUTC]), type date)
in
    WithDate