-- NOTE: Run DESCRIBE TABLE on the source to verify column names, then
-- replace the select * with explicit columns.

with source as (
    select * from {{ source('snowflake_public_data', 'fema_disaster_declaration_areas_index') }}
)

select * from source
