{{ config(materialized='table') }}

with final as (

select w.year_week
, avg(fare_amount) average_fare
, avg(trip_distance) average_distance
from {{ref('tgt_taxi_trips')}} tt
left join {{ref('stg_calendar_454')}} c
on c.date = tt.date
left join {{ref('stg_calendar_week')}} w
on w.year_week = c.year_week
group by w.year_week

)

select * from final
