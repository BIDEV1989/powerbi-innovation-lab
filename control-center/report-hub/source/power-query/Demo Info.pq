let
    Source = #table(type table [#"AsOfUTC" = datetime, #"SampleLabel" = text], {
        {#datetime(2026, 9, 12, 12, 0, 0), "SYNTHETIC SAMPLE - not connected to a tenant"}
    })
in
    Source