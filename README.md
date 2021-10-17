# nyc_taxi_trips
Project for the NYC taxi trips challenge.

ELT has been done using Meltano.

To run meltano ETL:
1. checkout this git repository
1. download the data in a subdirectory `data` of the newly created subdirectory nyc_taxi_trips
1. cd into nyc_taxi_trips
1. execute preprocessing stuff
* dos2unix data/454_calendar.csv   # resolves BOM character problem
* iconv -c -t utf-8 < data/data_dictionary.csv > data/data_dictionary_2.csv   # resolves invalid utf-8 encoding
* mv data/data_dictionary.csv data/data_dictionary.csv.orig
* mv data/data_dictionary_2.csv data/data_dictionary.csv
* head -1 data/taxi_trips/2019_taxi_trips.csv > data/taxi_trips/0_bootstrap.csv   # create a file with the complete header from 2019 data
* grep -hv VendorID data/taxi_trips/*.csv | cat data/taxi_trips/0_bootstrap_header.csv - > data/taxi_trips/all_trips.csv   # put the complete header in front of all collected data
1. alias meltano='docker run -v $(pwd):/project -p 5000:5000 -w /project meltano/meltano'
1. meltano elt tap-csv target-postgres --job_id=csv-to-postgres --transform run

