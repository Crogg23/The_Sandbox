# Disaster Impact Analytics

dbt + Snowflake analytics pipeline for analyzing the intersection of natural disasters, demographics, housing, employment, and migration across U.S. counties.

## Data Sources

- **FEMA** — disaster declarations, mission assignments, flood insurance
- **NWS** — weather alerts, forecasts, station data
- **Census/ACS** — demographics, community survey
- **BLS** — employment statistics
- **IRS** — migration flows, individual income
- **FHFA** — house price index
- **NOAA** — weather metrics, station data

## Project Structure

```
models/
  staging/       — source wrappers (materialized as views)
  intermediate/  — joined/enriched layers (materialized as tables)
  marts/         — analytics-ready aggregations (materialized as tables)
macros/          — dbt utility macros
notebooks/       — Jupyter notebooks for exploration
scripts/         — Python scripts for visualization and testing
```

## Setup

1. Copy `.env.example` to `.env` and fill in your Snowflake credentials
2. Install Python dependencies: `pip install -r requirements.txt`
3. Install dbt packages: `dbt deps`
4. Run the pipeline: `dbt build`
