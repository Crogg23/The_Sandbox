{{ config(materialized='table') }}

with alerts as (

    select
        wa.county_geo_id,
        wa.nws_alert_id,
        wa.nws_reporter,
        wa.alert_status,
        wa.alert_type,
        wa.alert_title,
        wa.alert_description,
        wa.alert_instruction,
        wa.event_type,
        wa.event_category,
        wa.event_certainty,
        wa.event_severity,
        wa.event_urgency,
        wa.sent_timestamp,
        wa.expiration_timestamp,
        wa.effective_timestamp,
        wa.onset_timestamp,
        wa.end_timestamp,

        -- date dimensions for downstream aggregation
        date_trunc('month', wa.sent_timestamp)::date  as sent_month,
        date_trunc('year', wa.sent_timestamp)::date   as sent_year,
        extract(year from wa.sent_timestamp)           as sent_year_num,
        extract(month from wa.sent_timestamp)          as sent_month_num

    from {{ ref('stg_nws_weather_alert_events') }} as wa

    where wa.sent_timestamp >= '{{ var("min_alert_date", "2020-01-01") }}'

),

parent_flags as (

    select distinct nws_alert_id
    from {{ ref('stg_nws_weather_alert_relationships') }}
    where relationship_type = 'Parent Alert'

)

select
    alerts.*,
    case
        when parent_flags.nws_alert_id is not null then 'Parent Alert'
        else 'Child Alert'
    end as alert_hierarchy
from alerts
left join parent_flags
    on alerts.nws_alert_id = parent_flags.nws_alert_id
