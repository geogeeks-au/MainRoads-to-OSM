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

```
              Table "public.planet_osm_roads"
       Column       |            Type             | Modifiers 
--------------------+-----------------------------+-----------
 osm_id             | bigint                      | 
 access             | text                        | 
 addr:housename     | text                        | 
 addr:housenumber   | text                        | 
 addr:interpolation | text                        | 
 admin_level        | text                        | 
 aerialway          | text                        | 
 aeroway            | text                        | 
 amenity            | text                        | 
 area               | text                        | 
 barrier            | text                        | 
 bicycle            | text                        | 
 brand              | text                        | 
 bridge             | text                        | 
 boundary           | text                        | 
 building           | text                        | 
 construction       | text                        | 
 covered            | text                        | 
 culvert            | text                        | 
 cutting            | text                        | 
 denomination       | text                        | 
 disused            | text                        | 
 embankment         | text                        | 
 foot               | text                        | 
 generator:source   | text                        | 
 harbour            | text                        | 
 highway            | text                        | 
 historic           | text                        | 
 horse              | text                        | 
 intermittent       | text                        | 
 junction           | text                        | 
 landuse            | text                        | 
 layer              | text                        | 
 leisure            | text                        | 
 lock               | text                        | 
 man_made           | text                        | 
 military           | text                        | 
 motorcar           | text                        | 
 name               | text                        | 
 natural            | text                        | 
 office             | text                        | 
 oneway             | text                        | 
 operator           | text                        | 
 place              | text                        | 
 population         | text                        | 
 power              | text                        | 
 power_source       | text                        | 
 public_transport   | text                        | 
 railway            | text                        | 
 ref                | text                        | 
 religion           | text                        | 
 route              | text                        | 
 service            | text                        | 
 shop               | text                        | 
 sport              | text                        | 
 surface            | text                        | 
 toll               | text                        | 
 tourism            | text                        | 
 tower:type         | text                        | 
 tracktype          | text                        | 
 tunnel             | text                        | 
 water              | text                        | 
 waterway           | text                        | 
 wetland            | text                        | 
 width              | text                        | 
 wood               | text                        | 
 z_order            | integer                     | 
 way_area           | real                        | 
 way                | geometry(LineString,900913) | 
Indexes:
    "planet_osm_roads_index" gist (way)
    "planet_osm_roads_pkey" btree (osm_id)
```

## Main Roads

Download `RoadNetworkMRWA_514.zip` from
http://catalogue.beta.data.wa.gov.au/dataset/ntwk-iris-road-network
(Keith says it *is* possible to get download this from the command-line, but it's tricky.)
This dataset was last updated 2016-04-11.

```
                                     Table "public.mrwa"
   Column   |            Type            |                     Modifiers                      
------------+----------------------------+----------------------------------------------------
 gid        | integer                    | not null default nextval('mrwa_gid_seq'::regclass)
 __gid      | numeric(10,0)              | 
 road       | character varying(30)      | 
 road_name  | character varying(80)      | 
 common_usa | character varying(80)      | 
 start_slk  | double precision           | 
 end_slk    | double precision           | 
 cwy        | character varying(10)      | 
 start_true | double precision           | 
 end_true_d | double precision           | 
 network_ty | character varying(30)      | 
 ra_no      | character varying(2)       | 
 ra_name    | character varying(80)      | 
 lg_no      | character varying(3)       | 
 lg_name    | character varying(80)      | 
 start_node | character varying(30)      | 
 start_no_1 | character varying(254)     | 
 end_node_n | character varying(30)      | 
 end_node_1 | character varying(254)     | 
 datum_ne_i | double precision           | 
 nm_begin_m | double precision           | 
 nm_end_mp  | double precision           | 
 network_el | character varying(254)     | 
 route_ne_i | numeric(10,0)              | 
 geoloc_len | double precision           | 
 geom       | geometry(MultiLineStringM) | 
Indexes:
    "mrwa_pkey" PRIMARY KEY, btree (gid)
```
