/*
Lead & Lag
nyc_transit/analyses/seven_day_moving_average_prcp.sql
Write a query to calculate the 7 day moving average precipitation for every day in the weather data.
The 7 day window should center on the day in question.
*/

/*
Assumptions:
1. Station and Name are the same for our dataset. So I am excluing them from the query to keep it simple. 
*/

select date, 
    -- prcp,
    AVG(prcp) OVER (order by date asc
            range between interval 3 days preceding and interval 3 days following) 
    as avg_prcp
from {{ ref('stg__central_park_weather') }}