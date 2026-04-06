-- NWS forecast events — likely has DATE column.
-- Verify with: dbt run-operation describe_source --args '{"table_name": "nws_weather_forecast_events"}'

with source as (
    select * from {{ source('snowflake_public_data', 'nws_weather_forecast_events') }}
)

select *
from source
where date >= '{{ var("min_timeseries_date", "2015-01-01") }}'
