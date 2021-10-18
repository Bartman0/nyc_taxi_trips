# nyc_taxi_trips
Project for the [NYC taxi trips challenge](https://www.mavenanalytics.io/blog/maven-taxi-challenge)

ELT has been done using Meltano, mostly.

You'll need:
* a PostgreSQL database
* this repository
* the [data](https://maven-datasets.s3.amazonaws.com/Taxi+Trips/NYC_Taxi_Trips.zip) from the challenge: 

To run meltano ETL:
1. checkout this git repository
1. download the data in a subdirectory `data` of the newly created subdirectory nyc_taxi_trips
1. cd into nyc_taxi_trips
1. execute preprocessing stuff from process.sh; most of the stuff is commented out so not to repeat actions by accident
1. alias meltano='docker run -v $(pwd):/project -p 5000:5000 -w /project meltano/meltano'
1. update the postgres target to reflect your database configuration in meltano.yml
1. meltano elt tap-csv target-postgres --job_id=csv-to-postgres --transform run

Remarks:
- I load taxi_trips myself here: none of the target-postgres loaders is efficient enough to load the 28 million records in reasonable time
- I tried the datamill-co and meltano variants of target-postgres; the meltano variant is a good candidate for fast loading because it uses COPY INTO also, but the buffer size is just around 1000 records so the overhead of executing the loading steps nullifies the speed of COPY INTO
- the datamill-co seems more lenient towards data (format) issues (COPY INTO requires a very strict data format)

