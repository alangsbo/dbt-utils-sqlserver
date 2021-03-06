{% macro test_cardinality_equality(model, to, field) %}

{% set column_name = kwargs.get('column_name', kwargs.get('from')) %}


with table_a as (
select
  {{ column_name }},
  count(*) as num_rows
from {{ model }}
group by {{ column_name }}
),

table_b as (
select
  {{ field }},
  count(*) as num_rows
from {{ to }}
group by {{ column_name }}
),

except_a as (
  select *
  from table_a
  {{ dbt_utils_sqlserver.except() }}
  select *
  from table_b
),

except_b as (
  select *
  from table_b
  {{ dbt_utils_sqlserver.except() }}
  select *
  from table_a
),

unioned as (
  select *
  from except_a
  union all
  select *
  from except_b
)

select count(*) as num_rows
from unioned

{% endmacro %}
