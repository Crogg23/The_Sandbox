{{ config(materialized='table') }}

with source as (
    select * from {{ source('snowflake_public_data', 'geography_index') }}
),

renamed as (
    select
        geo_id,
        geo_name,
        level
    from source
)

select * from renamed
