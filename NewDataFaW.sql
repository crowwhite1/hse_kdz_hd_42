  DROP TABLE IF EXISTS kdz_42_etl.flights_i_00;
 CREATE TABLE kdz_42_etl.flights_i_00 AS
 SELECT
    MIN(loaded_ts) AS ts1,
    MAX(loaded_ts) AS ts2
 FROM kdz_42_src.flights
 WHERE loaded_ts > COALESCE((SELECT MAX(loaded_ts) FROM kdz_42_etl.flights_load), '1970-01-01');
 DROP TABLE IF exists kdz_42_etl.weather_i_00 ;
 CREATE TABLE kdz_42_etl.weather_i_00 AS
 SELECT
    MIN(loaded_ts) AS ts1,
    MAX(loaded_ts) AS ts2
 FROM kdz_42_src.weather
 WHERE loaded_ts > COALESCE((SELECT MAX(loaded_ts) FROM kdz_42_etl.weather_load), '1970-01-01');
