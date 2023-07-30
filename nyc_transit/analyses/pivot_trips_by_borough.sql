/*
Pivot
Create a model which sums trips by borough (see Setup)
nyc_transit/analyses/pivot_trips_by_borough.sql
Write a query to pivot the results by borough.
*/

pivot {{ ref('mart__fact_trips_by_borough') }}
on puborough 
using first(all_trips)
