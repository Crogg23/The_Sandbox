-- METAR observations — likely has DATE or OBSERVATION_DATE column.
-- Verify with: dbt run-operation describe_source --args '{"table_name": "awc_metar_timeseries"}'

with source as (
    select * from {{ source('snowflake_public_data', 'awc_metar_timeseries') }}
)

select *
from source
where date >= '{{ var("min_timeseries_date", "2015-01-01") }}'
