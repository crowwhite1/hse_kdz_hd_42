 DROP TABLE IF EXISTS kdz_42_etl.fligths_i_01;
 CREATE TABLE kdz_42_etl.flights_i_01 AS
 select distinct on (flight_date, flight_number, origin, dest, crs_dep_time)
    year,
    quarter,
    month,
    flight_date,
    reporting_airline,
    tail_number,
    flight_number,
    origin,
    dest,
    crs_dep_time,
    dep_time,
    dep_delay_minutes,
    cancelled,
    cancellation_code,
    air_time,
    distance,
    weather_delay,
    loaded_ts
 FROM kdz_42_src.flights, kdz_42_etl.flights_i_00
 WHERE loaded_ts >= ts1 AND loaded_ts <= ts2
 order by flight_date, flight_number, origin, dest, crs_dep_time, loaded_ts desc;
 DROP TABLE IF EXISTS kdz_42_etl.weather_i_01;
 CREATE TABLE kdz_42_etl.weather_i_01 AS
 select distinct on (icao_code, local_datetime)
    icao_code,
    local_datetime,
    t_air_temperature,
    p0_sea_lvl,
    p_station_lvl,
    u_humidity,
    dd_wind_direction,
    ff_wind_speed,
    ff10_max_gust_value,
    ww_present,
    ww_recent,
    c_total_clouds,
    vv_horizontal_visibility,
    td_temperature_dewpoint,
    loaded_ts
 FROM kdz_42_src.weather, kdz_42_etl.weather_i_00
 WHERE loaded_ts >= ts1 AND loaded_ts <= ts2
 order by icao_code, local_datetime, loaded_ts desc;
