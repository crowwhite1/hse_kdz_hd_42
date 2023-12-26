INSERT INTO kdz_42_staging.flights (year, quarter, month, flight_date, reporting_airline, tail_number, flight_number, origin,
   dest, crs_dep_time, dep_time, dep_delay_minutes, cancelled, cancellation_code, air_time, distance, weather_delay, loaded_ts)
SELECT year, quarter, month, flight_date, reporting_airline, tail_number, flight_number, origin,
	dest, crs_dep_time, dep_time, dep_delay_minutes, cancelled, cancellation_code, air_time, distance, weather_delay, loaded_ts
FROM kdz_42_etl.flights_i_01
ON CONFLICT (flight_date, flight_number, origin, dest, crs_dep_time) DO UPDATE
SET
   year = EXCLUDED.year,
   quarter = EXCLUDED.quarter,
   month = EXCLUDED.month,
   flight_date = EXCLUDED.flight_date,
   reporting_airline = EXCLUDED.reporting_airline,
   tail_number = EXCLUDED.tail_number,
   flight_number = EXCLUDED.flight_number,
   origin = EXCLUDED.origin,
   dest = EXCLUDED.dest,
   crs_dep_time = EXCLUDED.crs_dep_time,
   dep_time = EXCLUDED.dep_time,
   dep_delay_minutes = EXCLUDED.dep_delay_minutes,
   cancelled = EXCLUDED.cancelled,
   cancellation_code = EXCLUDED.cancellation_code,
   air_time = EXCLUDED.air_time,
   distance = EXCLUDED.distance,
   weather_delay = EXCLUDED.weather_delay,
   loaded_ts = now();
INSERT INTO kdz_42_staging.weather (icao_code, local_datetime, t_air_temperature, p0_sea_lvl, p_station_lvl, u_humidity, dd_wind_direction, ff_wind_speed,
ff10_max_gust_value, ww_present, ww_recent, c_total_clouds, vv_horizontal_visibility, td_temperature_dewpoint, loaded_ts)
SELECT icao_code, local_datetime, t_air_temperature, p0_sea_lvl, p_station_lvl, u_humidity, dd_wind_direction, ff_wind_speed,
ff10_max_gust_value, ww_present, ww_recent, c_total_clouds, vv_horizontal_visibility, td_temperature_dewpoint, loaded_ts
FROM kdz_42_etl.weather_i_01
ON CONFLICT (icao_code, local_datetime) DO UPDATE
SET
   icao_code = EXCLUDED.icao_code,
   local_datetime = EXCLUDED.local_datetime,
   t_air_temperature = EXCLUDED.t_air_temperature,
   p0_sea_lvl = EXCLUDED.p0_sea_lvl,
   p_station_lvl = EXCLUDED.p_station_lvl,
   u_humidity = EXCLUDED.u_humidity,
   dd_wind_direction = EXCLUDED.dd_wind_direction,
   ff_wind_speed = EXCLUDED.ff_wind_speed,
   ff10_max_gust_value = EXCLUDED.ff10_max_gust_value,
   ww_present = EXCLUDED.ww_present,
   ww_recent = EXCLUDED.ww_recent,
   c_total_clouds = EXCLUDED.c_total_clouds,
   vv_horizontal_visibility = EXCLUDED.vv_horizontal_visibility,
   td_temperature_dewpoint = EXCLUDED.td_temperature_dewpoint,
   loaded_ts = now();
