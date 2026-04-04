

SELECT 
Continent.GEO_ID as Geo_ID_Continent, 
Country.GEO_ID as Geo_ID_Country,
State.GEO_ID as Geo_ID_State,
County.GEO_ID as Geo_ID_County,
CensusTract.GEO_ID as Geo_ID_CensusTract,
Continent.GEO_NAME as GeoName_Continent,
Country.Geo_Name as GeoName_Country,
State.Geo_Name as GeoName_State,
County.Geo_Name as GeoName_County,
CensusTract.GEO_NAME as GeoName_CensusTract,
MAX(case when relationship_type = 'coordinates_wkt' then value end) as WKT_Coordinates,
MAX(case when relationship_type = 'coordinates_geojson' then value end) as JSON_Coordinates

FROM  {{ ref('stg_geography_index') }} as Continent
    inner join stg_geography_relationships as Country on 
        Continent.GEO_ID = Country.RELATED_GEO_ID
        and Country.level = 'Country'
    inner join {{ ref('stg_geography_relationships') }} as State on 
        Country.GEO_ID = State.RELATED_GEO_ID
        and State.level = 'State'
     inner join {{ ref('stg_geography_relationships') }} as County on 
        State.GEO_ID = County.RELATED_GEO_ID
        and County.level = 'County'
    inner join {{ ref('stg_geography_relationships') }} as CensusTract on 
        County.GEO_ID = CensusTract.RELATED_GEO_ID
        and CensusTract.level = 'CensusTract'
    inner join {{ ref('stg_geography_characteristics') }} as GC on
        County.Geo_id = GC.GEO_ID
where Continent.level = 'Continent'

group by Continent.GEO_ID, 
Country.GEO_ID,
State.GEO_ID,
County.GEO_ID,
CensusTract.GEO_ID,
Continent.GEO_NAME,
Country.Geo_Name,
State.Geo_Name,
County.Geo_Name,
CensusTract.GEO_NAME