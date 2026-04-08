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
Continent.GEO_NAME as Continent_GeoName,
 FROM {{ source('snowflake_public_data', 'GEOGRAPHY_INDEX') }} as CensusTract
    inner join {{source('snowflake_public_data', 'GEOGRAPHY_RELATIONSHIPS') }} as County on 
        CensusTract.GEO_ID = County.RELATED_GEO_ID
        and County.level = 'County'
    inner join {{source('snowflake_public_data', 'GEOGRAPHY_RELATIONSHIPS') }} as State on 
        County.GEO_ID = State.RELATED_GEO_ID
        and State.LEVEL = 'State'
     inner join {{source('snowflake_public_data', 'GEOGRAPHY_RELATIONSHIPS') }} as Country on 
            State.GEO_ID = Country.RELATED_GEO_ID
            and Country.LEVEL = 'Country'
    inner join {{source('snowflake_public_data', 'GEOGRAPHY_RELATIONSHIPS') }} as Continent on 
            Country.GEO_ID = Continent.RELATED_GEO_ID
            and Continent.LEVEL = 'Continent'
    where CensusTract.level = 'CensusTract'





   