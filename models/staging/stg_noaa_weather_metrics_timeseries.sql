select * from {{ source('snowflake_public_data', 'noaa_weather_metrics_timeseries') }}
