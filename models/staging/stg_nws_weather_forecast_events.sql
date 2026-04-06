select *
from {{ source('snowflake_public_data', 'nws_weather_forecast_events') }}
where GENERATED_TIMESTAMP >= '{{ var("min_timeseries_date", "2010-01-01") }}'
