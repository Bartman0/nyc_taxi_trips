{{ config(materialized='table', unlogged=True) }}

with final as (

select date
, extract(isodow from lpep_pickup_datetime) isodow
, count(1) number_of_trips
from {{ref('tgt_taxi_trips')}}
group by date
, extract(isodow from lpep_pickup_datetime)

)

select * from final
