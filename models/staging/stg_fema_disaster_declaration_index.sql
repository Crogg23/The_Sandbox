select * from {{ source('snowflake_public_data', 'fema_disaster_declaration_index') }}
