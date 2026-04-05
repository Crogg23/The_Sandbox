select * from {{ source('snowflake_public_data', 'awc_metar_timeseries') }}
