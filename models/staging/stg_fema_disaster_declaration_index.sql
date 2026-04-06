select *
from {{ source('snowflake_public_data', 'fema_disaster_declaration_index') }}
where date >= '{{ var("min_timeseries_date", "2010-01-01") }}'
