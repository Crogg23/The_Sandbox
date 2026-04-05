select * from {{ source('snowflake_public_data', 'nrc_reactor_timeseries') }}
