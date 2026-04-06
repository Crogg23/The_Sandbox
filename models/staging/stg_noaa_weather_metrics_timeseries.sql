
select * from {{ source('snowflake_public_data', 'noaa_weather_metrics_timeseries') }}
where DATETIME >= '{{ var("min_timeseries_date", "2015-01-01") }}'
