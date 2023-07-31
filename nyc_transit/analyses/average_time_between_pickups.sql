/*
Lead * Lag - Complex
nyc_transit/analyses/average_time_between_pickups.sql
Find the average time between taxi pick ups per zone:
Use lead or lag to find the next trip per zone for each record
then find the time difference between the pick up time for the current record and the next
then use this result to calculate the average time between pick ups per zone.
*/

-- filter by zones and run it individually.
{%- set all_zones = get_all_zones() %} 

with renamed as (
    {%- for current_zone in all_zones %}
        select pl.zone as zone, 
        t.pickup_datetime as current_pu_ts,
        LAG(t.pickup_datetime, 1)
           over(partition by pl.zone order by t.pickup_datetime) as next_pu_ts,
        from {{ ref('mart__fact_all_taxi_trips') }} as t
        join {{ ref('mart__dim_locations') }} as pl on pl.locationid = t.pulocationid
        where pl.zone = '{{escape_single_quotes(current_zone)}}'
        {% if not loop.last %} union all {% endif -%}
    {% endfor %} 
)

select zone, 
    avg(datediff('minute', next_pu_ts, current_pu_ts)) as average_time_between_pickups_for_zone
from renamed
group by 1
