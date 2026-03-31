select * from {{ source('snowflake_public_data', 'freddie_mac_housing_timeseries') }}
