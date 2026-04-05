
SELECT 
Weather_Alert_Events.County_GEO_ID,
Weather_Alert_Events.NWS_ALERT_ID,
Weather_Alert_Events.NWS_REPORTER,
Weather_Alert_Events.Alert_Status,
Weather_Alert_Events.Alert_Type,
Weather_Alert_Events.ALERT_TITLE,
Weather_Alert_Events.ALERT_DESCRIPTION,
Weather_Alert_Events.ALERT_INSTRUCTION,
Weather_Alert_Events.EVENT_TYPE,
Weather_Alert_Events.EVENT_CATEGORY,
Weather_Alert_Events.EVENT_CERTAINTY,
Weather_Alert_Events.EVENT_SEVERITY,
Weather_Alert_Events.EVENT_URGENCY,
Weather_Alert_Events.SENT_TIMESTAMP,
Weather_Alert_Events.EXPIRATION_TIMESTAMP,
Weather_Alert_Events.EFFECTIVE_TIMESTAMP,
Weather_Alert_Events.ONSET_TIMESTAMP,
Weather_Alert_Events.END_TIMESTAMP,
case when NWS_Bridge.NWS_ALERT_ID is not null then 'Parent Alert' else 'Child Alert' end as Was_Parent_Alert_YN
from {{ ref('stg_nws_weather_alert_events') }} as Weather_Alert_Events 
    left join {{ ref('stg_nws_weather_alert_relationships') }} as NWS_Bridge on 
        Weather_Alert_Events.NWS_ALERT_ID = NWS_Bridge.NWS_ALERT_ID
        and NWS_Bridge.RELATIONSHIP_TYPE = 'Parent Alert'
    
where Weather_Alert_Events.sent_timestamp >= '2020-01-01'


