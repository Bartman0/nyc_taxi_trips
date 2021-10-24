{{ config(materialized='table', unlogged=True,
    indexes=[
      {'columns': ['date']},
      {'columns': ['pulocationid']},
      {'columns': ['dolocationid']}
    ]) }}

with final as (

select date, pulocationid, dolocationid
, extract(isodow from lpep_pickup_datetime) isodow
, avg(fare_amount) average_fare
, avg(trip_distance) average_distance
, count(1) number_of_trips
from {{ref('tgt_taxi_trips')}} tt
group by date, pulocationid, dolocationid
, extract(isodow from lpep_pickup_datetime)

)

select * from final
