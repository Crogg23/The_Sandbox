select * from {{ source('snowflake_public_data', 'irs_migration_by_characteristic_timeseries') }}
