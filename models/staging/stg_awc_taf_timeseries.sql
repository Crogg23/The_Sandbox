select * from {{ source('snowflake_public_data', 'awc_taf_timeseries') }}
