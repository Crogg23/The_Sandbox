
    select * from {{ source('snowflake_public_data', 'nrc_reactor_timeseries') }} 
    where date >= '{{ var("min_timeseries_date", "2015-01-01") }}'
