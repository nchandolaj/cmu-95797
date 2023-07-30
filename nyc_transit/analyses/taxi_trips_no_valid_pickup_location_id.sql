/*
Anti-Joins
nyc_transit/analyses/taxi_trips_no_valid_pickup_location_id.sql
Make a query which finds taxi trips which don’t have a pick up location_id in the locations table
*/ 

select 
    t.*
from {{ ref('mart__fact_all_taxi_trips') }} t
left join {{ ref('mart__dim_locations') }} pl on (pl.locationid = t.PUlocationID)
where pl.locationid is null