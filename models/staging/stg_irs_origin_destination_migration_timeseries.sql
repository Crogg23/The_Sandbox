select * from {{ source('snowflake_public_data', 'irs_origin_destination_migration_timeseries') }}
