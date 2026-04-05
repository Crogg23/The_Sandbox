
{{ config(materialized='table') }}

select
    geo.geo_id_state,
    geo.geo_id_county,
    geo.geoname_state,
    geo.geoname_county,
    geo.wkt_coordinates,
    geo.json_coordinates,

    -- date grain: monthly rollup
    wa.sent_year_num                                                              as alert_year,
    wa.sent_month_num                                                             as alert_month,
    wa.sent_month                                                                 as alert_month_start,

    -- severity breakdowns
    count(distinct wa.nws_alert_id)                                               as total_events,
    count(distinct case when wa.event_severity = 'Minor'    then wa.nws_alert_id end) as minor_events,
    count(distinct case when wa.event_severity = 'Moderate' then wa.nws_alert_id end) as moderate_events,
    count(distinct case when wa.event_severity = 'Severe'   then wa.nws_alert_id end) as severe_events,
    count(distinct case when wa.event_severity = 'Extreme'  then wa.nws_alert_id end) as extreme_events,
    count(distinct case when wa.event_severity not in ('Minor', 'Moderate', 'Severe', 'Extreme')
                         then wa.nws_alert_id end)                                as other_severity_events,

    -- category breakdowns
    count(distinct case when wa.event_category = 'Met'  then wa.nws_alert_id end) as meteorological_events,
    count(distinct case when wa.event_category = 'Geo'  then wa.nws_alert_id end) as geological_events,
    count(distinct case when wa.event_category = 'Fire' then wa.nws_alert_id end) as fire_events,

    -- urgency breakdowns
    count(distinct case when wa.event_urgency = 'Immediate' then wa.nws_alert_id end) as immediate_urgency_events,
    count(distinct case when wa.event_urgency = 'Expected'  then wa.nws_alert_id end) as expected_urgency_events,

    -- hierarchy
    count(distinct case when wa.alert_hierarchy = 'Parent Alert' then wa.nws_alert_id end) as parent_alerts,
    count(distinct case when wa.alert_hierarchy = 'Child Alert'  then wa.nws_alert_id end) as child_alerts

from {{ ref('int_geography_county') }} as geo

inner join {{ ref('int_weatheralerts') }} as wa
    on geo.geo_id_county = wa.county_geo_id

where wa.alert_status <> 'Test'

group by
    geo.geo_id_state,
    geo.geo_id_county,
    geo.geoname_state,
    geo.geoname_county,
    geo.wkt_coordinates,
    geo.json_coordinates,
    wa.sent_year_num,
    wa.sent_month_num,
    wa.sent_month
