select * from {{ source('snowflake_public_data', 'fema_mission_assignment_index') }}
