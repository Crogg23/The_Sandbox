with source as (
    select * from {{ source('snowflake_public_data', 'nws_weather_timeseries') }}
)

select
    nws_weather_station_id,
    Variable,
    Variable_Name,
    Timestamp,
    Value,
    Unit,
    Quality_Flag
from source
where Timestamp >= '{{ var("min_timeseries_date", "2015-01-01") }}'
