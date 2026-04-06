select *
from {{ source('snowflake_public_data', 'fema_national_flood_insurance_program_policy_index') }}
where ORIGINAL_FLOOD_POLICY_DATE >= '{{ var("min_timeseries_date", "2010-01-01") }}'
