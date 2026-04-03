--ONE ROW PER CENSUS TRACT


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
CensusTract.GEO_NAME as GeoName_CensusTract
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

where Continent.level = 'Continent'

