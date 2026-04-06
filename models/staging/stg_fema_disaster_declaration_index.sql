select *
from {{ source('snowflake_public_data', 'fema_disaster_declaration_index') }}
where DISASTER_BEGIN_DATE >= '{{ var("min_timeseries_date", "2010-01-01") }}'
