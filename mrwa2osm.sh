#!/bin/bash

if (test -z $SLIP_USER -o -z $SLIP_PASS); then
	echo "Please set SLIP_USER and SLIP_PASS env vars"
	exit 1
fi

TOKEN=$(echo -n $SLIP_USER':'$SLIP_PASS | base64 -w 0)

URL="https://maps.slip.wa.gov.au/datadownloads/MRWA_Public_Services/MRWA_Public_Secure_Services/RoadNetworkMRWA_514/RoadNetworkMRWA_514.zip"

SHPZIP=RoadNetwork_MRWA_514.zip

echo "Downloading shapefile"
curl --location --cookie --verbose \
	-H "User-Agent: QGIS" -H "Authorization: Basic "$TOKEN \
	--output $SHPZIP \
	"$URL"

echo "Unzipping downloaded shapefile"
unzip -d shp "$SHPZIP"

echo "Converting to OSM format"
python ogr2osm/ogr2osm.py shp/RoadNetworkMRWA_514_1.shp -o docs/RoadNetworkMRWA_514.osm
