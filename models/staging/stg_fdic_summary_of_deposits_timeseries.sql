
    select * from {{ source('snowflake_public_data', 'fdic_summary_of_deposits_timeseries') }}
where date >= '{{ var("min_timeseries_date", "2015-01-01") }}'
