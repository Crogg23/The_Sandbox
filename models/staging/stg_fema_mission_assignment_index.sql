select *
from {{ source('snowflake_public_data', 'fema_mission_assignment_index') }}
where REQUIRED_DATE >= '{{ var("min_timeseries_date", "2010-01-01") }}'
