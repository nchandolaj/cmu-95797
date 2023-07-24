select
    distinct
    start_station_id as station_id,
    start_station_name as station_name,
    start_lag station_lag,
    start_lng station_lng
from {{ ref('stg__bike_data') }}
union
select
    distinct
    end_station_id as station_id,
    end_station_name as station_name,
    end_lat station_lat,
    end_lng station_lng
from {{ ref('stg__bike_data') }}