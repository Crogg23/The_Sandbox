with source as (
    select * from {{ source('snowflake_public_data', 'geography_characteristics') }}
),

renamed as (
    select
        geo_id,
        relationship_type,
        value
    from source
)

select * from renamed
