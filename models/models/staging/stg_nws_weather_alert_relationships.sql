with source as (
    select * from {{ source('snowflake_public_data', 'nws_weather_alert_relationships') }}
),

renamed as (
    select
        nws_alert_id,
        relationship_type
    from source
)

select * from renamed
