{{ config(materialized='table') }}

select 
    weather_alert_events.county_geo_id,
    weather_alert_events.nws_alert_id,
    weather_alert_events.nws_reporter,
    weather_alert_events.alert_status,
    weather_alert_events.alert_type,
    weather_alert_events.alert_title,
    weather_alert_events.alert_description,
    weather_alert_events.alert_instruction,
    weather_alert_events.event_type,
    weather_alert_events.event_category,
    weather_alert_events.event_certainty,
    weather_alert_events.event_severity,
    weather_alert_events.event_urgency,
    weather_alert_events.sent_timestamp,
    weather_alert_events.expiration_timestamp,
    weather_alert_events.effective_timestamp,
    weather_alert_events.onset_timestamp,
    weather_alert_events.end_timestamp,
    case when exists (
        select 1 
        from {{ ref('stg_nws_weather_alert_relationships') }} as nws_bridge
        where weather_alert_events.nws_alert_id = nws_bridge.nws_alert_id
          and nws_bridge.relationship_type = 'Parent Alert'
    ) then 'Parent Alert' else 'Child Alert' end as was_parent_alert_yn
from {{ ref('stg_nws_weather_alert_events') }} as weather_alert_events
where weather_alert_events.sent_timestamp >= '2020-01-01'