select 
geo.geo_id_state,
geo.geo_id_county,
geo.geoname_county,
geo.geoname_state,
geo.geoname_censustract,
geo.wkt_coordinates,
geo.json_coordinates,
count(case when event_severity = 'Moderate' then nws_alert_id end) as Moderate_Events,
count(case when event_severity = 'Severe' then nws_alert_id end) as Severe_Events,
count(case when event_severity = 'Extreme' then nws_alert_id end) as Extreme_Events
from {{ ref('int_geography') }} as geo 
    inner join {{ ref('int_weatheralerts') }} as WA on 
        geo.geo_id_county = WA.COUNTY_GEO_ID

where alert_status <> 'Test'
group by 
geo.geo_id_state,
geo.geo_id_county,
geo.geoname_county,
geo.geoname_state,
geo.geoname_censustract,
geo.wkt_coordinates,
geo.json_coordinates