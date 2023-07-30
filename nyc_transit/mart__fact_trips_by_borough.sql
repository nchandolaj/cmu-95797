/* 
   Add a new fact table mart__fact_trips_by_borough.sql
   Add it to your models/mart/schema.yml
   description: "number of trips grouped by borough”
   You can build this from your existing facts and dimensions models
*/

/*
Assumption: 
1. It is assumed that the assignmeent is asking for number of taxi trips group by pick up boroughs.
2. Any pickup location in the taxi trips fact table that does not exist in the dim locations mart is not
   relevant, i.e., the location is either null or an incorrect location and should be ignored in our query.
*/

select 
    pl.borough as puborough,
    count(*) as all_trips
from {{ ref('mart__fact_all_taxi_trips')}} t
  join {{ ref('mart__dim_locations') }} pl on t.PUlocationID = pl.LocationID
group by all
