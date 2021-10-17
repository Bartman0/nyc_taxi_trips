# nyc_taxi_trips
Project for the NYC taxi trips challenge.

ELT has been done using Meltano.

To run meltano ETL:
* create a meltano project: meltano init NYC_Taxi_Trips
* download the data in a subdirectory `data` of the newly created subdirectory nyc_taxi_trips
* cd into nyc_taxi_trips
* execute preprocessing stuff
1. dos2unix data/454_calendar.csv   # resolves BOM character problem
1. iconv -c -t utf-8 < data/data_dictionary.csv > data/data_dictionary_2.csv   # resolves invalid utf-8 encoding
1. mv data/data_dictionary.csv data/data_dictionary.csv.orig
1. mv data/data_dictionary_2.csv data/data_dictionary.csv
1. head -1 data/taxi_trips/2019_taxi_trips.csv > data/taxi_trips/0_bootstrap.csv   # create a file with the complete header from 2019 data
1. grep -hv VendorID data/taxi_trips/*.csv | cat data/taxi_trips/0_bootstrap_header.csv - > data/taxi_trips/all_trips.csv   # put the complete header in front of all collected data
* alias meltano='docker run -v $(pwd):/project -p 5000:5000 -w /project meltano/meltano'
* meltano elt tap-csv target-postgres --job_id=csv-to-postgres --transform run

