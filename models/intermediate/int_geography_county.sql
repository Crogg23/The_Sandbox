{{ config(materialized='table') }}

select
    continent.geo_id          as geo_id_continent,
    country_rel.geo_id        as geo_id_country,
    state_rel.geo_id          as geo_id_state,
    county_rel.geo_id         as geo_id_county,
    continent.geo_name        as geoname_continent,
    country_idx.geo_name      as geoname_country,
    state_idx.geo_name        as geoname_state,
    county_idx.geo_name       as geoname_county,
    max(case when gc.relationship_type = 'coordinates_wkt' then gc.value end)     as wkt_coordinates,
    max(case when gc.relationship_type = 'coordinates_geojson' then gc.value end) as json_coordinates

from {{ ref('stg_geography_index') }} as continent

inner join {{ ref('stg_geography_relationships') }} as country_rel
    on continent.geo_id = country_rel.related_geo_id
    and country_rel.level = 'Country'

inner join {{ ref('stg_geography_index') }} as country_idx
    on country_rel.geo_id = country_idx.geo_id

inner join {{ ref('stg_geography_relationships') }} as state_rel
    on country_rel.geo_id = state_rel.related_geo_id
    and state_rel.level = 'State'

inner join {{ ref('stg_geography_index') }} as state_idx
    on state_rel.geo_id = state_idx.geo_id

inner join {{ ref('stg_geography_relationships') }} as county_rel
    on state_rel.geo_id = county_rel.related_geo_id
    and county_rel.level = 'County'

inner join {{ ref('stg_geography_index') }} as county_idx
    on county_rel.geo_id = county_idx.geo_id

inner join {{ ref('stg_geography_characteristics') }} as gc
    on county_rel.geo_id = gc.geo_id

where continent.level = 'Continent'

group by
    continent.geo_id,
    country_rel.geo_id,
    state_rel.geo_id,
    county_rel.geo_id,
    continent.geo_name,
    country_idx.geo_name,
    state_idx.geo_name,
    county_idx.geo_name
