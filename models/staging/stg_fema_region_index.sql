select * from {{ source('snowflake_public_data', 'fema_region_index') }}
