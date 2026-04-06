with source as (
    select * from {{ source('snowflake_public_data', 'fhfa_house_price_timeseries') }}
)

select
    geo_id,
    variable_name,
    date,
    value
from source
where date >= '{{ var("min_timeseries_date", "2015-01-01") }}'
