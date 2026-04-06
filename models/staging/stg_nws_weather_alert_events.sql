with source as (
    select * from {{ source('snowflake_public_data', 'nws_weather_alert_events') }}
),

renamed as (
    select
        county_geo_id,
        nws_alert_id,
        nws_reporter,
        alert_status,
        alert_type,
        alert_title,
        alert_description,
        alert_instruction,
        event_type,
        event_category,
        event_certainty,
        event_severity,
        event_urgency,
        cast(sent_timestamp as timestamp_ntz)        as sent_timestamp,
        cast(expiration_timestamp as timestamp_ntz)  as expiration_timestamp,
        cast(effective_timestamp as timestamp_ntz)    as effective_timestamp,
        cast(onset_timestamp as timestamp_ntz)        as onset_timestamp,
        cast(end_timestamp as timestamp_ntz)          as end_timestamp
    from source
)

select * from renamed
where sent_timestamp >= '{{ var("min_alert_date", "2015-01-01") }}'
