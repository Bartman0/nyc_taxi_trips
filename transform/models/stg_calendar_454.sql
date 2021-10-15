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
    from calendar_454 c

)

select * from final