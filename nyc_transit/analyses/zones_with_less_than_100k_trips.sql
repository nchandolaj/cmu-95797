/*
Group By and Having
nyc_transit/analyses/zones_with_less_than_100k_trips.sql
Write a query which finds all the Zones where there are less than 100000 trips
*/

/*
Assumption: 
1. Assignmeent is asking for all the pickup location zones with less than 100k trips.
2. Any pickup location in the taxi trips fact table that does not exist in the dim locations mart is not
   relevant, i.e., the location is either null or an incorrect location and should be ignored in our query.
*/

select 
    pl.zone, 
    count(*) as all_trips
from {{ ref('mart__fact_all_taxi_trips') }} t
join {{ ref('mart__dim_locations') }} pl on (pl.locationid = t.pulocationid)
group by pl.zone
having count(*) < 100000