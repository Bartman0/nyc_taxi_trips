{{ config(materialized='table') }}

with final as (

select date
, extract(isodow from lpep_pickup_datetime) isodow
, extract(hour from lpep_pickup_datetime) hour_slot
, count(1) number_of_trips
from {{ref('tgt_taxi_trips')}}
group by date
, extract(isodow from lpep_pickup_datetime)
, extract(hour from lpep_pickup_datetime)

)

select * from final
