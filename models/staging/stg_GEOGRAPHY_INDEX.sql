select * from {{ source('snowflake_public_data', 'geography_index') }}
