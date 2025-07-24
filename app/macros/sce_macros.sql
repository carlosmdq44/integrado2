{% macro sce_dimension(source_model, key) %}
  {% set relation = ref(source_model) %}
  {% set all_columns = adapter.get_columns_in_relation(relation) %}
  {% set columns = [] %}
  {% for col in all_columns %}
    {% if col.name != key and col.name != 'created_at' %}
      {% do columns.append(col.name) %}
    {% endif %}
  {% endfor %}

  with source as (
      select * from {{ relation }}
  ),
  latest as (
      select
          *,
          row_number() over (partition by {{ key }} order by created_at desc) as rn
      from source
  )
  select
      {{ key }},
      created_at,
      {{ columns | join(',\n      ') }},
      'Y' as current_flag
  from latest
  where rn = 1
{% endmacro %}