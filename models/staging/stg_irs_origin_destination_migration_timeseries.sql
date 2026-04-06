select *
from {{ source('snowflake_public_data', 'irs_origin_destination_migration_timeseries') }}
where date >= '{{ var("min_timeseries_date", "2010-01-01") }}'
