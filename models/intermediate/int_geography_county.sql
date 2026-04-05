{{ config(materialized='table') }}

-- Step 1: Single scan of geography_index, split by level
with geo_index_base as (
    select geo_id, geo_name, level
    from {{ ref('stg_geography_index') }}
    where level in ('Continent', 'Country', 'State', 'County')
),

continents as (select geo_id, geo_name from geo_index_base where level = 'Continent'),
countries  as (select geo_id, geo_name from geo_index_base where level = 'Country'),
states     as (select geo_id, geo_name from geo_index_base where level = 'State'),
counties   as (select geo_id, geo_name from geo_index_base where level = 'County'),

-- Step 2: Single scan of geography_relationships, split by level
relationships_base as (
    select geo_id, related_geo_id, level
    from {{ ref('stg_geography_relationships') }}
    where level in ('Country', 'State', 'County')
),

country_rels as (select geo_id, related_geo_id from relationships_base where level = 'Country'),
state_rels   as (select geo_id, related_geo_id from relationships_base where level = 'State'),
county_rels  as (select geo_id, related_geo_id from relationships_base where level = 'County'),

-- Step 3: Single scan of characteristics, pre-filtered to coordinates only, pre-pivoted
county_coordinates as (
    select
        geo_id,
        max(case when relationship_type = 'coordinates_wkt'     then value end) as wkt_coordinates,
        max(case when relationship_type = 'coordinates_geojson' then value end) as json_coordinates
    from {{ ref('stg_geography_characteristics') }}
    where relationship_type in ('coordinates_wkt', 'coordinates_geojson')
    group by geo_id
),

-- Step 4: Build continent → country → state → county hierarchy with names
hierarchy as (
    select
        continents.geo_id   as geo_id_continent,
        continents.geo_name as geoname_continent,
        country_rels.geo_id as geo_id_country,
        countries.geo_name  as geoname_country,
        state_rels.geo_id   as geo_id_state,
        states.geo_name     as geoname_state,
        county_rels.geo_id  as geo_id_county,
        counties.geo_name   as geoname_county
    from continents
    inner join country_rels on continents.geo_id = country_rels.related_geo_id
    inner join countries    on country_rels.geo_id = countries.geo_id
    inner join state_rels   on country_rels.geo_id = state_rels.related_geo_id
    inner join states       on state_rels.geo_id = states.geo_id
    inner join county_rels  on state_rels.geo_id = county_rels.related_geo_id
    inner join counties     on county_rels.geo_id = counties.geo_id
)

-- Step 5: Final join — no GROUP BY needed, coordinates are pre-aggregated
select
    h.geo_id_continent,
    h.geo_id_country,
    h.geo_id_state,
    h.geo_id_county,
    h.geoname_continent,
    h.geoname_country,
    h.geoname_state,
    h.geoname_county,
    cc.wkt_coordinates,
    cc.json_coordinates
from hierarchy as h
inner join county_coordinates as cc
    on h.geo_id_county = cc.geo_id
