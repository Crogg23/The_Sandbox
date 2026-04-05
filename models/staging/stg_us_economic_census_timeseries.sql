select * from {{ source('snowflake_public_data', 'us_economic_census_timeseries') }}
