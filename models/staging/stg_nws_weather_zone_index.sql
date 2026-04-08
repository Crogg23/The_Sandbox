{{ config(materialized='table') }}

select
NWS_WEATHER_ZONE_ID,
NWS_WEATHER_ZONE_NAME,
STATE_GEO_ID,
EFFECTIVE_DATE
FROM {{ source('snowflake_public_data', 'NWS_WEATHER_ZONE_INDEX') }}