{{ config(materialized='table') }}

select
    continent.geo_id     as geo_id_continent,
    country.geo_id       as geo_id_country,
    state.geo_id         as geo_id_state,
    county.geo_id        as geo_id_county,
    continent.geo_name   as geoname_continent,
    country.geo_name     as geoname_country,
    state.geo_name       as geoname_state,
    county.geo_name      as geoname_county,
    max(case when gc.relationship_type = 'coordinates_wkt' then gc.value end)     as wkt_coordinates,
    max(case when gc.relationship_type = 'coordinates_geojson' then gc.value end) as json_coordinates

from {{ ref('stg_geography_index') }} as continent

inner join {{ ref('stg_geography_relationships') }} as country
    on continent.geo_id = country.related_geo_id
    and country.level = 'Country'

inner join {{ ref('stg_geography_relationships') }} as state
    on country.geo_id = state.related_geo_id
    and state.level = 'State'

inner join {{ ref('stg_geography_relationships') }} as county
    on state.geo_id = county.related_geo_id
    and county.level = 'County'

inner join {{ ref('stg_geography_characteristics') }} as gc
    on county.geo_id = gc.geo_id

where continent.level = 'Continent'

group by
    continent.geo_id,
    country.geo_id,
    state.geo_id,
    county.geo_id,
    continent.geo_name,
    country.geo_name,
    state.geo_name,
    county.geo_name
