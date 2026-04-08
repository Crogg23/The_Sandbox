SELECT
    STATION_ID,
    LOCATION
FROM {{ source('snowflake_public_data', 'NOAA_NWRFC_STATION_INDEX') }}
