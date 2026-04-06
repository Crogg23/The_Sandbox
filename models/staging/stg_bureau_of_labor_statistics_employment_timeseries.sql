with source as (
    select * from {{ source('snowflake_public_data', 'bureau_of_labor_statistics_employment_timeseries') }}
)

select
    geo_id,
    variable_name,
    date,
    value
from source
where date >= '{{ var("min_timeseries_date", "2015-01-01") }}'
