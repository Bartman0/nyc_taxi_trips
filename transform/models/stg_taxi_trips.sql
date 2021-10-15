with final as (
    
    select case when tt.vendorid = '' then null else tt.vendorid::int end vendorid
    , tt.lpep_pickup_datetime::timestamp
    , tt.lpep_dropoff_datetime::timestamp
    , tt.store_and_fwd_flag
    , case when tt.ratecodeid = '' then null else tt.ratecodeid::int end ratecodeid
    , case when tt.pulocationid = '' then null else tt.pulocationid::int end pulocationid
    , case when tt.dolocationid = '' then null else tt.dolocationid::int end dolocationid
    , case when tt.passenger_count = '' then null else tt.passenger_count::int end passenger_count
    , tt.trip_distance::decimal(18,5)
    , tt.fare_amount::decimal(18,5)
    , tt.extra::decimal(18,5)
    , tt.mta_tax::decimal(18,5)
    , tt.tip_amount::decimal(18,5)
    , tt.tolls_amount::decimal(18,5)
    , tt.improvement_surcharge::decimal(18,5)
    , tt.total_amount::decimal(18,5)
    , tt.payment_type
    , tt.trip_type
    , case when tt.congestion_surcharge = '' then null else tt.congestion_surcharge::int end congestion_surcharge
    from public.taxi_trips tt

)

select * from final
