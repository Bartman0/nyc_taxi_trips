{{ config(materialized='table',
    indexes=[
      {'columns': ['locationid']},
    ]) }}

with final as (

select tz.locationid::int
, tz.borough
, tz.zone
, tz.service_zone
from taxi_zones tz

)

select * from final
