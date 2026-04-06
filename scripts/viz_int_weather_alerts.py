import getpass
import os

import pandas as pd
import plotly.express as px
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

sql = """
SELECT EVENT_SEVERITY, COUNT(*) AS ALERT_COUNT
FROM DISASTER_IMPACT.DBT_CROGERS.INT_WEATHERALERTS
GROUP BY EVENT_SEVERITY
ORDER BY ALERT_COUNT DESC
"""

df = pd.read_sql(sql, conn)
conn.close()

fig = px.bar(
    df,
    x="EVENT_SEVERITY",
    y="ALERT_COUNT",
    title="Weather alerts by severity (INT_WEATHERALERTS)",
)
fig.update_layout(
    template="plotly_dark",
    paper_bgcolor="#0F172A",
    plot_bgcolor="#1E293B",
    font=dict(family="Inter, DM Sans, sans-serif", color="#E2E8F0"),
    color_discrete_sequence=["#38BDF8"],
)
fig.show()