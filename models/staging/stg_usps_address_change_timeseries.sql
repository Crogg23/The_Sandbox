select * from {{ source('snowflake_public_data', 'usps_address_change_timeseries') }}
