/* 
GROUP BY
nyc_transit/analyses/trips_duration_grouped_by_borough_zone.sql
Calculate the number of trips and average duration by borough and zone
*/

/*
Assumption: 
1. It is assumed that the assignmeent is asking for number of taxi trips and avergae duration by pick up location.
2. Any pickup location in the taxi trips fact table that does not exist in the dim locations mart is not
   relevant, i.e., the location is either null or an incorrect location and should be ignored in our query.
*/

select 
    pl.borough, 
    pl.zone, 
    count(*) as all_trips, 
    avg(duration_min) as average_duration_min,
    avg(duration_sec) as average_duration_sec
from {{ ref('mart__fact_all_taxi_trips') }} t
join {{ ref('mart__dim_locations') }} pl on (pl.locationid = t.pulocationid)
group by all