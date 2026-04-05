select * from {{ source('snowflake_public_data', 'home_mortgage_disclosure_attributes') }}
