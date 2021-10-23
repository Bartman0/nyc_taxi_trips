{{ config(
    materialized = 'table',
    indexes=[
      {'columns': ['date'], 'unique': True},
    ]
)}}

with final as (
    
select date::date
, fiscalyear::int
, fiscalquarter::int
, fiscalmonthnumber::int
, fiscalmonthofquarter::int
, fiscalweekofyear::int
, dayofweek::int
, fiscalmonthname
, fiscalmonthyear
, fiscalquarteryear::int
, dayofmonthnumber::int
, dayname
, fiscalyear::int || lpad(fiscalweekofyear, 2, '0') year_week
, row_number() over (order by date desc)
from calendar_454 c

)

select * from final
