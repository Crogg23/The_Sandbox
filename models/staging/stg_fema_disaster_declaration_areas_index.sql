select *
from {{ source('snowflake_public_data', 'fema_disaster_declaration_areas_index') }}
where DESIGNATED_DATE >= '{{ var("min_timeseries_date", "2010-01-01") }}'
