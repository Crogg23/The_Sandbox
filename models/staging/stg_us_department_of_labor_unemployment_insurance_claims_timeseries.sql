select * from {{ source('snowflake_public_data', 'us_department_of_labor_unemployment_insurance_claims_timeseries') }}
