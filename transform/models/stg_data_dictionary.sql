with final as (

    select Field
    , Description
    from data_dictionary

)

select * from final
