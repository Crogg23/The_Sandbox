select *
from {{ source('snowflake_public_data', 'financial_cfpb_complaint') }}
where DATE_RECEIVED >= '{{ var("min_timeseries_date", "2010-01-01") }}'
