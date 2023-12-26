DELETE FROM kdz_42_etl.flights_load
WHERE EXISTS (SELECT 1 FROM kdz_42_etl.flights_i_00);
INSERT INTO kdz_42_etl.flights_load(loaded_ts)
SELECT ts2
FROM kdz_42_etl.flights_i_00
WHERE ts2 IS NOT NULL; -- Убедитесь, что ts2 не NULL
DELETE FROM kdz_42_etl.weather_load
WHERE EXISTS (SELECT 1 FROM kdz_42_etl.weather_i_00);
INSERT INTO kdz_42_etl.weather_load(loaded_ts)
SELECT ts2
FROM kdz_42_etl.weather_i_00
WHERE ts2 IS NOT NULL;
