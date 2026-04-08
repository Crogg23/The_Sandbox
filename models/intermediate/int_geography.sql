SELECT 
CensusTract.GEO_ID as CensusTract_GeoID,
County.GEO_ID as County_GeoID,
State.GEO_ID as State_GeoId,
Country.GEO_ID as Country_GeoId,
Continent.GEO_ID as Continent_GeoID,
CensusTract.GEO_NAME as CensusTract_GeoName,
County.GEO_NAME as County_GeoName,
State.GEO_NAME as State_GeoName,
Country.GEO_NAME as Country_GeoName,
Continent.GEO_NAME as Continent_GeoName
FROM {{ref('stg_geography_index') }} as CensusTract
    inner join {{ref('stg_geographic_relationships') }} as County on 
        CensusTract.GEO_ID = County.RELATED_GEO_ID
        and County.level = 'County'
    inner join {{ref('stg_geographic_relationships') }} as State on 
        County.GEO_ID = State.RELATED_GEO_ID
        and State.LEVEL = 'State'
     inner join {{ref('stg_geographic_relationships') }} as Country on 
            State.GEO_ID = Country.RELATED_GEO_ID
            and Country.LEVEL = 'Country'
    inner join {{ref('stg_geographic_relationships') }} as Continent on 
            Country.GEO_ID = Continent.RELATED_GEO_ID
            and Continent.LEVEL = 'Continent'
    where CensusTract.level = 'CensusTract'





   