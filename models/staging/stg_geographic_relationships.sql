{{ config(materialized='table') }}

SELECT 
    GEO_ID,
    GEO_Name,
    LEVEL,
    RELATED_GEO_NAME,
    RELATED_GEO_ID,
    RELATED_LEVEL,
    RELATIONSHIP_TYPE
FROM {{ source('snowflake_public_data', 'GEOGRAPHY_RELATIONSHIPS') }}