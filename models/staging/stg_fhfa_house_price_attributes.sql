select * from {{ source('snowflake_public_data', 'fhfa_house_price_attributes') }}
