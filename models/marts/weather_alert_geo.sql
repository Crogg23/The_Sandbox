select 
geo.geo_id_state,
geo.geo_id_county,
geo.geoname_county,
geo.geoname_state,
-- removed: geo.geoname_censustract
geo.wkt_coordinates,
geo.json_coordinates,
count(case when event_severity = 'Moderate' then nws_alert_id end) as moderate_events,
count(case when event_severity = 'Severe' then nws_alert_id end) as severe_events,
count(case when event_severity = 'Extreme' then nws_alert_id end) as extreme_events
from {{ ref('int_geography') }} as geo 
    inner join {{ ref('int_weatheralerts') }} as wa on 
        geo.geo_id_county = wa.county_geo_id
where alert_status <> 'Test'
group by 
geo.geo_id_state,
geo.geo_id_county,
geo.geoname_county,
geo.geoname_state,
geo.wkt_coordinates,
geo.json_coordinates