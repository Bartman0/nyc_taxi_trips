with final as (

select f.sequence_desc - t.sequence_desc span
, f.fiscalyear_week fiscalyear_week_from
, t.fiscalyear_week fiscalyear_week_to
from {{ref('stg_calendar_week')}} f
join {{ref('stg_calendar_week')}} t
on t.sequence_desc between f.sequence_desc-10 and f.sequence_desc-1

)

select * from final
