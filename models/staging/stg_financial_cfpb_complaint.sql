select * from {{ source('snowflake_public_data', 'financial_cfpb_complaint') }}
