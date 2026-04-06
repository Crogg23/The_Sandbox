-- NOTE: This table likely has origin_geo_id + destination_geo_id instead of just geo_id.
-- Verify with: dbt run-operation describe_source --args '{"table_name": "irs_origin_destination_migration_timeseries"}'
-- Adjust columns below if needed.

with source as (
    select * from {{ source('snowflake_public_data', 'irs_origin_destination_migration_timeseries') }}
)

select
    geo_id,
    variable_name,
    date,
    value
from source
where date >= '{{ var("min_timeseries_date", "2015-01-01") }}'
