select * from {{ source('snowflake_public_data', 'american_community_survey_attributes') }}
