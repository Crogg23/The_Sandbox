select * from {{ source('snowflake_public_data', 'fhfa_mortgage_performance_timeseries') }}
