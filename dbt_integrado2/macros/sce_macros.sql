{% macro sce_dimension(source_model, key) %}
with source as (
    select * from {{ ref(source_model) }}
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
    {% for column in dbt_utils.get_column_names(ref(source_model)) if column not in [key, 'created_at'] %}
    {{ column }},
    {% endfor %}
    'Y' as current_flag
from latest
where rn = 1
{% endmacro %}