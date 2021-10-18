#!/bin/bash

set -ex

# one-time commands
#dos2unix data/454_calendar.csv
#dos2unix data/taxi_trips/2017_taxi_trips.csv   # prepare for sed
#dos2unix data/taxi_trips/2018_taxi_trips.csv   # prepare for sed
#dos2unix data/taxi_trips/2019_taxi_trips.csv
#dos2unix data/taxi_trips/2020_taxi_trips.csv
#sed -e 's/$/,/' data/taxi_trips/2017_taxi_trips.csv > data/taxi_trips/2017_taxi_trips_modified.csv   # add missing column
#sed -e 's/$/,/' data/taxi_trips/2018_taxi_trips.csv > data/taxi_trips/2018_taxi_trips_modified.csv   # add missing column
#mv data/taxi_trips/2017_taxi_trips.csv data/taxi_trips/2017_taxi_trips.csv.orig   # move out of *.csv selection
#mv data/taxi_trips/2018_taxi_trips.csv data/taxi_trips/2018_taxi_trips.csv.orig   # move out of *.csv selection
#iconv -c -t utf-8 < data/data_dictionary.csv > data/data_dictionary_2.csv
#mv data/data_dictionary.csv data/data_dictionary.csv.orig
#mv data/data_dictionary_2.csv data/data_dictionary.csv
#head -1 data/taxi_trips/2019_taxi_trips.csv > data/taxi_trips/0_bootstrap_header.csv
#rm -fr data/taxi_trips/all_trips.csv
#grep -hv VendorID data/taxi_trips/*.csv | cat data/taxi_trips/0_bootstrap_header.csv - > data/taxi_trips/all_trips.csv

# create taxi_trips table:
-- Table: public.taxi_trips

-- DROP TABLE IF EXISTS public.taxi_trips;

CREATE TABLE IF NOT EXISTS public.taxi_trips
(
    vendorid text COLLATE pg_catalog."default" NULL,
    lpep_pickup_datetime text COLLATE pg_catalog."default" NULL,
    lpep_dropoff_datetime text COLLATE pg_catalog."default" NULL,
    store_and_fwd_flag text COLLATE pg_catalog."default" NULL,
    ratecodeid text COLLATE pg_catalog."default" NULL,
    pulocationid text COLLATE pg_catalog."default" NULL,
    dolocationid text COLLATE pg_catalog."default" NULL,
    passenger_count text COLLATE pg_catalog."default" NULL,
    trip_distance text COLLATE pg_catalog."default" NULL,
    fare_amount text COLLATE pg_catalog."default" NULL,
    extra text COLLATE pg_catalog."default" NULL,
    mta_tax text COLLATE pg_catalog."default" NULL,
    tip_amount text COLLATE pg_catalog."default" NULL,
    tolls_amount text COLLATE pg_catalog."default" NULL,
    improvement_surcharge text COLLATE pg_catalog."default" NULL,
    total_amount text COLLATE pg_catalog."default" NULL,
    payment_type text COLLATE pg_catalog."default" NULL,
    trip_type text COLLATE pg_catalog."default" NULL,
	congestion_surcharge text COLLATE pg_catalog."default" NULL
)

# use psql to execute:
\copy public.taxi_trips (vendorid, lpep_pickup_datetime, lpep_dropoff_datetime, store_and_fwd_flag, ratecodeid, pulocationid, dolocationid, passenger_count, trip_distance, fare_amount, extra, mta_tax, tip_amount, tolls_amount, improvement_surcharge, total_amount, payment_type, trip_type, congestion_surcharge) FROM '/Users/rkooijman/Projects/NYC_Taxi_Trips/nyc_taxi_trips/data/taxi_trips/all_trips.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8' QUOTE '\"' ESCAPE '''';

meltano elt tap-csv target-postgres --job_id=csv-to-postgres

