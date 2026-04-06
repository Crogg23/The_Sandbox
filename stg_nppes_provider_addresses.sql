-- Provider addresses — reference table, no timeseries date column expected.
-- No date filter applied. If this table is massive, consider filtering to
-- specific states: where state in ('CA','TX','FL', ...)

select * from {{ source('snowflake_public_data', 'nppes_provider_addresses') }}
