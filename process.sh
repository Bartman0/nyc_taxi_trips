#!/bin/bash

set -ex

# one-time commands
#dos2unix data/454_calendar.csv
#iconv -c -t utf-8 < data/data_dictionary.csv > data/data_dictionary_2.csv
#mv data/data_dictionary.csv data/data_dictionary.csv.orig
#mv data/data_dictionary_2.csv data/data_dictionary.csv
#head -1 data/taxi_trips/2019_taxi_trips.csv > data/taxi_trips/0_bootstrap.csv
#grep -hv VendorID data/taxi_trips/*.csv | cat data/taxi_trips/0_bootstrap_header.csv - > data/taxi_trips/all_trips.csv

meltano elt tap-csv target-postgres --job_id=csv-to-postgres
