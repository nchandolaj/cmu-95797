/*
Basic Window Functions
nyc_transit/analyses/yellow_taxi_fare_comparison.sql
Write a query to compare an individual fare to the zone, borough and overall
average fare using the fare_amount in yellow taxi trip data.
*/

/*
Assumption: 
1. Assignmeent is asking for fare comparison for pickup location - borough, zones
2. Any pickup location in the taxi trips fact table that does not exist in the dim locations mart is not
   relevant, i.e., the location is either null or an incorrect location and should be ignored in our query.
*/

select 
        pl.zone, 
        pl.borough, 
        t.fare_amount, 
    AVG(t.fare_amount) OVER (PARTITION BY pl.borough) as average_fare_borough,
    AVG(t.fare_amount) OVER (PARTITION BY pl.zone, pl.borough) as average_fare_zone_borough,
    AVG(t.fare_amount) OVER () as overall_average_fare
from {{ ref('stg__yellow_tripdata') }} t
join {{ ref('mart__dim_locations') }} pl on (t.pulocationid = pl.locationid)