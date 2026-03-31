select * from {{ source('snowflake_public_data', 'fdic_summary_of_deposits_timeseries') }}
