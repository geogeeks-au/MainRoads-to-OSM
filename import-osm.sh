#!/bin/bash

# Do everything in our directory.
#cd $(dirname $0)

# Download latest data.
#wget "http://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf"
OSM_FILE=$(cd $(dirname $0); pwd -P)/australia-latest.osm.pbf
if [ ! -f $OSM_FILE ]; then
	echo "Can't find OSM file at $OSM_FILE"
	exit 1
fi

# Import into Postgresql.
export PGPASS=geogeekery
osm2pgsql --cache-strategy sparse -s -U sam -d osm "$OSM_FILE"

