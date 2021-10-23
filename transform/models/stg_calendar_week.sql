{{ config(
    materialized = 'table',
    indexes=[
      {'columns': ['year_week'], 'unique': True},
    ]
)}}

with group_by_week as (
    
select fiscalyear::int
, fiscalweekofyear::int
, row_number() over (order by fiscalyear::int desc, fiscalweekofyear::int desc) sequence_desc
from calendar_454 c
group by fiscalyear::int
, fiscalweekofyear::int

)

, final as (

select fiscalyear
, fiscalweekofyear
, fiscalyear || '-' || lpad(fiscalweekofyear::text, 2, '0') year_week
, sequence_desc
from group_by_week

)

select * from final
