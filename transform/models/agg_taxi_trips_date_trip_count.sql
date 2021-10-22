{{ config(materialized='table') }}

with final as (

select date
, count(1) number_of_trips
from {{ref('tgt_taxi_trips')}}
group by date

)

select * from final
