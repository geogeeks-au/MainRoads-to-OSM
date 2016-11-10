#!/bin/bash
date
THISDIR=$(cd $(dirname $0); pwd -P)

# Download latest data, if it's newer than what we've already got.
OSM_FILE="$THISDIR/australia.osm.pbf"
TIMECOND=""
if [ -f $OSM_FILE ]; then
	TIMECOND="--time-cond $OSM_FILE"
fi
curl "http://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf" \
	$TIMECOND \
	--output "$THISDIR/australia.osm.pbf"
if [ ! -f $OSM_FILE ]; then
	echo "Can't find OSM file at $OSM_FILE"
	exit 1
fi

# Import into Postgresql.
date
psql -d osm -c "DROP MATERIALIZED VIEW IF EXISTS not_in_osm;"
osm2pgsql --cache-strategy sparse --slim -d osm "$OSM_FILE"

# Create materialized view.
date
psql -d osm -U sam -f $THISDIR/not_in_osm.sql

