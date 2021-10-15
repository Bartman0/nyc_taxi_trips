#!/bin/bash

set -ex

#dos2unix data/454_calendar.csv

meltano elt tap-csv target-postgres --job_id=csv-to-postgres
