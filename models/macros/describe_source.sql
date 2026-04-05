-- Run: dbt run-operation describe_source --args '{"table_name": "fema_disaster_declaration_index"}'
-- Returns the first 5 rows so you can see column names and sample data.

{% macro describe_source(table_name) %}

    {% set query %}
        select *
        from SNOWFLAKE_PUBLIC_DATA_PAID.PUBLIC_DATA.{{ table_name }}
        limit 5
    {% endset %}

    {% set results = run_query(query) %}
    {{ log(results.column_names, info=True) }}

    {% for row in results.rows %}
        {{ log(row.values() | list, info=True) }}
    {% endfor %}

{% endmacro %}
