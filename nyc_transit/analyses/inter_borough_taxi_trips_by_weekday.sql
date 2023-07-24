select 
    weekday(pickup_datetime) as weekday,
    count(*) as total_trips,
    sum( if((start_location.borough != end_location.borough), 1, 0)) as trips_with_different_burrough,
    sum( if((start_location.borough != end_location.borough), 1, 0)) / count(*) as percentage_with_diff_start_end_borough
from {{ ref('mart__fact_all_taxi_trips') }} as taxi_trips
    left join {{ ref('mart__dim_locations') }} as start_location
        on taxi_trips.pulocationid = start_location.locationid
    left join {{ ref('mart__dim_locations') }} as end_location
        on taxi_trips.pulocationid = end_location.locationid
group by 1