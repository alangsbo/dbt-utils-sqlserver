{% macro hash(field) -%}
  {{ adapter_macro('dbt_utils_sqlserver.hash', field) }}
{%- endmacro %}


{% macro default__hash(field) -%}
    md5(cast({{field}} as {{dbt_utils_sqlserver.type_string()}}))
{%- endmacro %}


{% macro bigquery__hash(field) -%}
    to_hex({{dbt_utils_sqlserver.default__hash(field)}})
{%- endmacro %}

{% macro sqlserver__hash(field) -%}

    CONVERT(VARCHAR(32), HashBytes('MD5',  {{field}} ), 2)
{%- endmacro %}
