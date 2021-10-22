{{ config(materialized='table') }}

with final as (

select date
, pulocationid
, dolocationid
, count(1) number_of_trips
from {{ref('tgt_taxi_trips')}}
group by date
, pulocationid
, dolocationid

)

select * from final
