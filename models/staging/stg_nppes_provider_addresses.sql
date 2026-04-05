select * from {{ source('snowflake_public_data', 'nppes_provider_addresses') }}
