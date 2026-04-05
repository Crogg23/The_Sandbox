{{ config(materialized='table') }}

with geo_names as (
    select geo_id, geo_name
    from {{ ref('stg_geography_index') }}
),

hierarchy as (
    select
        continent.geo_id    as geo_id_continent,
        country.geo_id      as geo_id_country,
        state.geo_id        as geo_id_state,
        county.geo_id       as geo_id_county

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

    where continent.level = 'Continent'
)

select
    h.geo_id_continent,
    h.geo_id_country,
    h.geo_id_state,
    h.geo_id_county,
    cn.geo_name        as geoname_continent,
    co.geo_name        as geoname_country,
    st.geo_name        as geoname_state,
    ct.geo_name        as geoname_county,
    max(case when gc.relationship_type = 'coordinates_wkt' then gc.value end)     as wkt_coordinates,
    max(case when gc.relationship_type = 'coordinates_geojson' then gc.value end) as json_coordinates

from hierarchy as h

inner join geo_names as cn on h.geo_id_continent = cn.geo_id
inner join geo_names as co on h.geo_id_country = co.geo_id
inner join geo_names as st on h.geo_id_state = st.geo_id
inner join geo_names as ct on h.geo_id_county = ct.geo_id

inner join {{ ref('stg_geography_characteristics') }} as gc
    on h.geo_id_county = gc.geo_id

group by
    h.geo_id_continent,
    h.geo_id_country,
    h.geo_id_state,
    h.geo_id_county,
    cn.geo_name,
    co.geo_name,
    st.geo_name,
    ct.geo_name
