#!/bin/bash

# Don't just run this blindly!

shp2pgsql RoadNetworkMRWA_514_1 mrwa > mrwa.sql

psql -U sam -d osm -f mrwa.sql

