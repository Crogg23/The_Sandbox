select * from {{ source('snowflake_public_data', 'bureau_of_labor_statistics_employment_timeseries') }}
