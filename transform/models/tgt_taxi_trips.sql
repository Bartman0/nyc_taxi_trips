with transform_filter as (

select vendorid
, least(lpep_pickup_datetime,lpep_dropoff_datetime) lpep_pickup_datetime     -- logically order the moments if swapped
, greatest(lpep_pickup_datetime,lpep_dropoff_datetime) lpep_dropoff_datetime -- logically order the moments if swapped
, store_and_fwd_flag
, ratecodeid
, pulocationid
, dolocationid
, coalesce(passenger_count, 1) passenger_count   -- if unknown then assume 1 passenger
, case when trip_distance = 0 then (fare_amount-2.5)/2.5 else trip_distance end trip_distance
, case when fare_amount = 0 then (2.5+(trip_distance*2.5)) else fare_amount end fare_amount
, extra
, mta_tax
, tip_amount
, tolls_amount
, improvement_surcharge
, total_amount
, payment_type
, trip_type
, congestion_surcharge
, fare_amount < 0 and mta_tax < 0 and improvement_surcharge < 0 and congestion_surcharge < 0 all_negative_fare_taxes_surcharges
from {{ref('stg_taxi_trips')}}
where 1=1
and store_and_fwd_flag = 'N'    -- not store-and-forward
and trip_type = '1'             -- street-hail
and payment_type in ('1', '2')  -- card or cash
and ratecodeid = '1'            -- standard rate
and extract(year from lpep_pickup_datetime) between 2017 and 2020    -- only keep 2017 to 2020
and extract(year from lpep_dropoff_datetime) between 2017 and 2020   -- only keep 2017 to 2020
and pulocationid is not null    -- pick up location is known
and dolocationid is not null    -- drop off location is known
and extract(epoch from greatest(lpep_pickup_datetime,lpep_dropoff_datetime)-least(lpep_pickup_datetime,lpep_dropoff_datetime)) < 24*3600 -- no trips longer than 1 day = 24 hour
and (trip_distance <> 0         -- distance <> 0 or 
or fare_amount <> 0)            -- fare amount <> 0

)
, final as (

select vendorid
, lpep_pickup_datetime
, lpep_dropoff_datetime
, store_and_fwd_flag
, ratecodeid
, pulocationid
, dolocationid
, passenger_count
, trip_distance
, extra
, tip_amount
, tolls_amount
, total_amount
, payment_type
, trip_type
, case when all_negative_fare_taxes_surcharges then abs(fare_amount) else fare_amount end fare_amount
, case when all_negative_fare_taxes_surcharges then abs(mta_tax) else mta_tax end mta_tax
, case when all_negative_fare_taxes_surcharges then abs(improvement_surcharge) else improvement_surcharge end improvement_surcharge
, case when all_negative_fare_taxes_surcharges then abs(congestion_surcharge) else congestion_surcharge end congestion_surcharge
, lpep_pickup_datetime::date date
from transform_filter f
left join {{ref('stg_calendar_454')}} c
on c.date = f.lpep_pickup_datetime::date

)

select * from final
