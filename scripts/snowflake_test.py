import getpass
import os

import pandas as pd
import snowflake.connector

password = os.environ.get("SNOWFLAKE_PASSWORD") or getpass.getpass("Snowflake password: ")

conn = snowflake.connector.connect(
    account="ONEAFDA-UMB20733",
    user="CROGG23",
    password=password,
    warehouse="COMPUTE_WH",
    database="DISASTER_IMPACT",
    schema="DBT_CROGERS",
)

df = pd.read_sql("SELECT CURRENT_DATABASE(), CURRENT_SCHEMA(), CURRENT_WAREHOUSE()", conn)
print(df)
conn.close()
