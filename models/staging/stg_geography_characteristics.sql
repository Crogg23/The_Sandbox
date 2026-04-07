{{ config(materialized='table') }}

SELECT 
    GEO_ID,
    GEO_Name,
    RELATIONSHIP_TYPE,
    VALUE,
    RELATIONSHIP_START_DATE,
    RELATIONSHIP_END_DATE
FROM {{ source('snowflake_public_data', 'GEOGRAPHY_CHARACTERISTICS') }}