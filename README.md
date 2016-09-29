Main Roads to OSM
=================

[![Stories in Ready](https://badge.waffle.io/geogeeks-au/MainRoads-to-OSM.png?label=ready&title=Ready)](http://waffle.io/geogeeks-au/MainRoads-to-OSM)

Getting missing roads into OSM.

## OSM

OSM data is re-imported monthly with `import-osm.sh` script,
into the `osm` database.

Download australia-latest.osm.pbf from
http://download.geofabrik.de/australia-oceania/australia.html
(c.f. https://wiki.openstreetmap.org/wiki/Shapefiles )
http://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf
The last import took 1,572 s.

## Main Roads

Download `RoadNetworkMRWA_514.zip` from
http://catalogue.beta.data.wa.gov.au/dataset/ntwk-iris-road-network
(Keith says it *is* possible to get download this from the command-line, but it's tricky.)
This dataset was last updated 2016-04-11.

## Schemas

The `osm` database:


 public | planet_osm_line 
 public | planet_osm_nodes   | table | sam   | 1492 MB | 
 public | planet_osm_point   | table | sam   | 62 MB   | 
 public | planet_osm_polygon | table | sam   | 248 MB  | 
 public | planet_osm_rels    | table | sam   | 19 MB   | 
 public | planet_osm_roads   | table | sam   | 104 MB  | 
 public | planet_osm_ways    | table | sam   | 720 MB  | 
