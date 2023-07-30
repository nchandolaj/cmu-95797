/*
Named Windows
nyc_transit/analyses/seven_day_moving_aggs_weather.sql
Write a query to calculate the 7 day moving min, max, avg, sum for precipitation
and snow for every day in the weather data, defining the window only once.
The 7 day window should center on the day in question.
*/

/*
Assumptions:
1. Station and Name are the same for our dataset. So I am excluing them from the query to keep it simple. 
*/

select date, 
    MIN(prcp) OVER seven_days as min_prcp, 
    MAX(prcp) OVER seven_days as max_prcp, 
    AVG(prcp) OVER seven_days as avg_prcp, 
    SUM(prcp) OVER seven_days as sum_prcp, 
    MIN(snow) OVER seven_days as min_snow,
    MAX(snow) OVER seven_days as max_snow,
    AVG(snow) OVER seven_days as avg_snow,
    SUM(snow) OVER seven_days as sum_snow
from {{ ref('stg__central_park_weather') }}
window seven_days as (
    order by date asc
    range between interval 3 days preceding and
                  interval 3 days following)
