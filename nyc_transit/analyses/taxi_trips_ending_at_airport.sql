select 
    count(*) as total_trips
from {{ ref('mart__fact_all_taxi_trips') }} as taxi_trips
    left join {{ ref('mart__dim_locations') }} as location
        on taxi_trips.dolocationid = location.locationid
where location.service_zone in ('Airports', 'EWR')