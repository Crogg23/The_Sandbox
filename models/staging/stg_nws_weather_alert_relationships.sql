select * from {{ source('snowflake_public_data', 'nws_weather_alert_relationships') }}
