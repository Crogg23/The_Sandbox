select * from {{ source('snowflake_public_data', 'urban_crime_timeseries') }}
