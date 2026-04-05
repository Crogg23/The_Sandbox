with source as (
    select * from {{ source('snowflake_public_data', 'geography_relationships') }}
),

renamed as (
    select
        geo_id,
        related_geo_id,
        level
    from source
)

select * from renamed
