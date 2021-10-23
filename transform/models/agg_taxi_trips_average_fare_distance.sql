{{ config(materialized='table', unlogged=True) }}

with final as (

select w.fiscalyear_week
, avg(fare_amount) average_fare
, avg(trip_distance) average_distance
from {{ref('tgt_taxi_trips')}} tt
left join {{ref('stg_calendar_454')}} c
on c.date = tt.date
left join {{ref('stg_calendar_week')}} w
on w.fiscalyear_week = c.fiscalyear_week
group by w.fiscalyear_week

)

select * from final
