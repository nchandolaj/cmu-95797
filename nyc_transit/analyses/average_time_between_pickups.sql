/*
Lead * Lag - Complex
nyc_transit/analyses/average_time_between_pickups.sql
Find the average time between taxi pick ups per zone:
Use lead or lag to find the next trip per zone for each record
then find the time difference between the pick up time for the current record and the next
then use this result to calculate the average time between pick ups per zone.
*/

-- filter by zones and run it individually.

{%- set all_zones = get_all_zones() -%} 

{%- for current_zone in all_zones %}
    select pl.zone 
    from {{ ref('mart__fact_all_taxi_trips') }} t
    join {{ ref('mart__dim_locations') }} pl on (pl.locationid = t.pulocationid)
    where pl.zone = '{{current_zone}}'
{% endfor %}
