{% macro test_unique_threshold(model) %}

{% set column_name = kwargs.get('column_name', kwargs.get('arg')) %}
{% set threshold = kwargs.get('threshold', 0) %}


with validation_errors as (
    select
        {{ column_name }}
    from {{ model }}
    where {{ column_name }} is not null
    group by {{ column_name }}
    having count(*) > 1
),
aggregated as (
    select
        count(*) as n_errors
    from validation_errors
    group by 1
)
select
    case
      when n_errors <= {{ threshold }} then 0
      else n_errors
    end as result
from aggregated

{% endmacro %}