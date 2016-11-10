DROP MATERIALIZED VIEW IF EXISTS not_in_osm;

CREATE MATERIALIZED VIEW not_in_osm AS
WITH buffered_osm AS (
	SELECT 
		ST_Transform( ST_Union(ST_Buffer(way, 20.0)), 4283) AS ways
	FROM planet_osm_line
	WHERE 
		highway IS NOT NULL 
		-- AND ST_Transform(ST_MakeEnvelope( 117.074, -33.4207, 117.1745, -33.3163, 4283), 900913) && way
)
SELECT 
	row_number() over() as id,
--	osm.highway AS osm_type,
--	osm.name AS osm_name,
	mrwa.road AS mrwa_type,
	mrwa.road_name AS mrwa_name,
	ST_Difference(ST_SetSRID(mrwa.geom, 4283), (select ways from buffered_osm)) AS geom
FROM mrwa
-- WHERE ST_MakeEnvelope( 117.074, -33.4207, 117.1745, -33.3163, 4283 ) && mrwa.geom
;

