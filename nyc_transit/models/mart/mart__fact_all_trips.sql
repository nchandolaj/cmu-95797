with trips_renamed as
(
    select 'bike' as type, started_at_ts, ended_at_ts
    from {{ ref('stg__fhv_tripdata') }}
    union ALL
    select 'fhv' as type, pickup_datetime, dropoff_datetime
    from {{ ref('stg__fhv_tripdata') }}
    union ALL
    select 'fhvhv' as type, pickup_datetime, dropoff_datetime
    from {{ ref('stg__fhvhv_tripdata') }}
    union ALL
    select 'green' as type, lpep_pickup_datetime, lpep_dropoff_datetime
    from {{ ref('stg__green_tripdata') }}
    union ALL
    select 'yellow' as type, tpep_pickup_datetime, tpep_dropoff_datetime
    from {{ ref('stg__yellow_tripdata') }}
)

select 
    type, 
    started_at_ts, 
    ended_at_ts,
    datediff('minute', stated_at_ts, ended_at_ts) as duration_min,
    datediff('second', stated_at_ts, ended_at_ts) as duration_sec
from trips_renamed