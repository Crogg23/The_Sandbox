-- NOTE: Column names inferred from OpenFEMA schema.
-- Run `DESCRIBE TABLE SNOWFLAKE_PUBLIC_DATA_PAID.PUBLIC_DATA.FEMA_DISASTER_DECLARATION_INDEX`
-- in Snowflake to verify, then adjust as needed.

with source as (
    select * from {{ source('snowflake_public_data', 'fema_disaster_declaration_index') }}
),

renamed as (
    select
        geo_id,
        variable_name,
        date,
        value
    from source
)

select * from renamed
