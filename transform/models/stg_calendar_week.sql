{{ config(
    materialized = 'table',
    indexes=[
      {'columns': ['fiscalyear_week'], 'unique': True},
    ]
)}}

with group_by_week as (
    
select fiscalyear::int
, fiscalweekofyear::int
, fiscalyear_week
, row_number() over (order by fiscalyear::int desc, fiscalweekofyear::int desc) sequence_desc
from {{ref('stg_calendar_454')}}
group by fiscalyear::int
, fiscalweekofyear::int
, fiscalyear_week

)

, final as (

select fiscalyear
, fiscalweekofyear
, fiscalyear_week
, sequence_desc
from group_by_week

)

select * from final
