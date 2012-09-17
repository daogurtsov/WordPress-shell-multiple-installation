#!/bin/sh
./wp_dbcopy.sh
./createDB.sh
./importDB.sh &
./wpcopy.sh &
#./apache_config.sh &
