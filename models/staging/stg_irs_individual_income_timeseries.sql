select * from {{ source('snowflake_public_data', 'irs_individual_income_timeseries') }}
