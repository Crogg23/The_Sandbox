select *
from {{ source('snowflake_public_data', 'fema_national_flood_insurance_program_claim_index') }}
where date >= '{{ var("min_timeseries_date", "2010-01-01") }}'
