
{{ config(materialized='table') }}

SELECT
    STATION_ID,
    DATE,
    VARIABLE,
    VARIABLE_NAME,
    VALUE,
    UNIT,
    FREQUENCY,
    MEASURE,
    MEASUREMENT_TYPE,
    MEASUREMENT_METHOD,
    LOCATION,
    FCST_PERIOD,
    WATER_YEAR
FROM {{ source('snowflake_public_data', 'NOAA_NWRFC_WATER_SUPPLY_TIMESERIES') }}
