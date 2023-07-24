with trips_renamed as
(
<<<<<<< HEAD
-- UNION ALL will use the column name from the first SELECT
=======
>>>>>>> 29814fd (mart tables and seed made)
    select 'fhv' as type, pickup_datetime, dropoff_datetime, pulocationid, dolocationid
    from {{ ref('stg__fhv_tripdata') }}
    union ALL
    select 'fhvhv' as type, pickup_datetime, dropoff_datetime, pulocationid, dolocationid
    from {{ ref('stg__fhvhv_tripdata') }}
    union ALL
    select 'green' as type, pickup_datetime, dropoff_datetime, pulocationid, dolocationid
    from {{ ref('stg__green_tripdata') }}
    union ALL
    select 'yellow' as type, pickup_datetime, dropoff_datetime, , pulocationid, dolocationid
    from {{ ref('stg__yellow_tripdata') }}
)

select 
    type, 
    pickup_datetime, 
    dropoff_datetime,
    datediff('minute', pickup_datetime, dropoff_datetime) as duration_min,
    datediff('second', pickup_datetime, dropoff_datetime) as duration_sec, 
    pulocationid,
    dolocationid
<<<<<<< HEAD
from trips_renamed
=======
from trips_renamed
>>>>>>> 29814fd (mart tables and seed made)