select *
from {{ source('snowflake_public_data', 'awc_metar_timeseries') }}
where date >= '{{ var("min_timeseries_date", "2010-01-01") }}'
