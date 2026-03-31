select * from {{ source('snowflake_public_data', 'us_real_estate_attributes') }}
