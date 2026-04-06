# DISASTER_IMPACT dbt Optimization — Changelog

## What Changed

### Staging Layer
- **5 active staging models upgraded** from bare `select *` to proper CTE pattern with explicit column selection and timestamp casting (`stg_geography_index`, `stg_geography_relationships`, `stg_geography_characteristics`, `stg_nws_weather_alert_events`, `stg_nws_weather_alert_relationships`)
- **2 FEMA staging models** created with placeholder patterns — need column verification (see "Your Next Steps")
- **`_sources.yml`** — added descriptions to every source table
- **`_staging.yml`** — NEW schema file with `not_null`, `accepted_values` tests on all active staging models

### Intermediate Layer
- **`int_geography_county`** — replaced fragile `group by 1,2,3,...,8` with explicit column names
- **`int_weatheralerts`** — three fixes:
  1. Replaced correlated `EXISTS` subquery with cleaner `LEFT JOIN`
  2. Hardcoded date filter → `{{ var('min_alert_date') }}` (configurable in dbt_project.yml)
  3. Added date dimension columns (`sent_month`, `sent_year`, `sent_year_num`, `sent_month_num`) for downstream aggregation
  4. Renamed `was_parent_alert_yn` → `alert_hierarchy` (the old name implied boolean but held string values)
- **`_intermediate.yml`** — NEW schema file with `unique`, `not_null`, `relationships`, `accepted_values` tests

### Marts Layer
- **`weather_alert_geo`** — four major upgrades:
  1. Added `{{ config(materialized='table') }}` (was defaulting to view = expensive)
  2. Added **monthly date grain** (`alert_year`, `alert_month`, `alert_month_start`) — enables trend analysis
  3. Added `total_events`, `minor_events`, `other_severity_events` — catches all severity values
  4. Added category breakdowns (meteorological, geological, fire) and urgency breakdowns
  5. Explicit `group by` column names instead of positional
- **`_marts.yml`** — NEW schema file with composite uniqueness test on county + month

### Macros
- **`describe_source`** — utility to preview any source table columns via `dbt run-operation`

### Project Config
- **`dbt_project_additions.yml`** — vars and per-folder materialization defaults to add to your dbt_project.yml

---

## Your Next Steps (Priority Order)

### 1. Verify FEMA column names (5 min)
Run this in your Snowflake worksheet or dbt:
```
dbt run-operation describe_source --args '{"table_name": "fema_disaster_declaration_index"}'
dbt run-operation describe_source --args '{"table_name": "fema_disaster_declaration_areas_index"}'
```
Then update the two FEMA staging models with real column names.

### 2. Merge dbt_project_additions.yml into your dbt_project.yml (2 min)
Add the `vars:` block and the per-folder `+materialized` settings.

### 3. Copy the optimized files into your project (2 min)
Replace the existing files with the optimized versions. New files go in their matching directories.

### 4. Run `dbt build` (validates models + runs tests)
```
dbt build
```
Fix any test failures — the `accepted_values` tests on `event_severity` and `geography level` might surface values you haven't seen yet. That's the point.

### 5. Build FEMA intermediate model
Once you've verified FEMA columns, build `int_fema_disasters` to join declarations → areas → geography. This is the second data layer that makes the project portfolio-worthy.

---

## Files Included

```
models/
├── staging/
│   ├── _sources.yml                          (REPLACE)
│   ├── _staging.yml                          (NEW)
│   ├── stg_geography_index.sql               (REPLACE)
│   ├── stg_geography_relationships.sql       (REPLACE)
│   ├── stg_geography_characteristics.sql     (REPLACE)
│   ├── stg_nws_weather_alert_events.sql      (REPLACE)
│   ├── stg_nws_weather_alert_relationships.sql (REPLACE)
│   ├── stg_fema_disaster_declaration_index.sql (REPLACE)
│   └── stg_fema_disaster_declaration_areas_index.sql (REPLACE)
├── intermediate/
│   ├── _intermediate.yml                     (NEW)
│   ├── int_geography_county.sql              (REPLACE)
│   └── int_weatheralerts.sql                 (REPLACE)
└── marts/
    ├── _marts.yml                            (NEW)
    └── weather_alert_geo.sql                 (REPLACE)
macros/
└── describe_source.sql                       (NEW)
dbt_project_additions.yml                     (MERGE into dbt_project.yml)
CHANGELOG.md                                  (this file)
```
