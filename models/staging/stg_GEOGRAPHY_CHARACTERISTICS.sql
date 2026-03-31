SELECT * FROM {{ source('snowflake_public_data', 'geography_characteristics') }}
