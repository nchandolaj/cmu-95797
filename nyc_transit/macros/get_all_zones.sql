-- Referenced this article to write the method: https://docs.getdbt.com/guides/advanced/using-jinja 

{% macro get_all_zones() %}

{% set all_zones_query %}
select distinct pl.zone as zone
from {{ ref('mart__fact_all_taxi_trips') }} t
join {{ ref('mart__dim_locations') }} pl on (pl.locationid = t.pulocationid)
order by 1 
limit 50
{% endset %}

{% set results = run_query(all_zones_query) %}

{% if execute %}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}