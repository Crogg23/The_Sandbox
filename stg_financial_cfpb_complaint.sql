-- CFPB complaints — not standard EAV. Likely has DATE_RECEIVED or similar.
-- Verify with: dbt run-operation describe_source --args '{"table_name": "financial_cfpb_complaint"}'
-- If the date column is different, update the WHERE clause.

with source as (
    select * from {{ source('snowflake_public_data', 'financial_cfpb_complaint') }}
)

select *
from source
where date >= '{{ var("min_timeseries_date", "2015-01-01") }}'
