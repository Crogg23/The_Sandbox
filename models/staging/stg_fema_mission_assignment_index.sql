select *
from {{ source('snowflake_public_data', 'fema_mission_assignment_index') }}
where date >= '{{ var("min_timeseries_date", "2010-01-01") }}'
