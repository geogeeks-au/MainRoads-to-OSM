#!/bin/bash

## Download zip of shapefile.
if [[ -z "$SLIP_USER" || -z "$SLIP_PASS" ]]; then
	echo "Please set SLIP_USER and SLIP_PASS env vars"
	exit 1
fi
TOKEN=$(echo -n $SLIP_USER':'$SLIP_PASS | base64 -w 0)
URL="https://maps.slip.wa.gov.au/datadownloads/MRWA_Public_Services/MRWA_Public_Secure_Services/RoadNetworkMRWA_514/RoadNetworkMRWA_514.zip"
SHPZIP=RoadNetwork_MRWA_514.zip
curl --version
echo "Downloading shapefile"
curl --location --cookie --verbose \
	-H "User-Agent: QGIS" -H "Authorization: Basic "$TOKEN \
	--output $SHPZIP \
	"$URL"
if [[ $? -ne 0 ]]; then
	echo "curl failed with: $?"
	exit $?
fi

## Check size in Mb.
ZIPSIZE=$(du -m "$SHPZIP" | cut -f 1)
if [[ $ZIPSIZE < 20 ]]; then
	echo "Zip file was not large enough (only $ZIPSIZE Mb). Contents:"
	cat $SHPZIP
	exit 1
fi

## Unzip.
echo "Unzipping downloaded shapefile"
unzip -d shp "$SHPZIP"

## Convert.
echo "Converting to OSM format"
OSMFILE="docs/RoadNetworkMRWA_514.osm"
python ogr2osm/ogr2osm.py shp/RoadNetworkMRWA_514_1.shp -o "$OSMFILE"

## Zip.
ZIPFILE="docs/RoadNetworkMRWA_514.zip"
zip "$ZIPFILE" "$OSMFILE"

## Send to Github.
git config user.name "Geogeeks (Travis CI)"
git config user.email "sam@samwilson.id.au"
git checkout master
git add "$ZIPFILE"
git commit -m"Updated from Slip"
echo "Pushing to Github"
git push -f "https://${GH_TOKEN}@github.com/geogeeks-au/MainRoads-to-OSM.git" master:master
