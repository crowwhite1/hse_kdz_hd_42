 -- view для загрузки в mart
 create or replace temp view data_for_mart_fact_dep as (
 select distinct on (flight_dep_scheduled_ts,flight_number, tail_number ) airport_origin_dk,
 airport_dest_dk as airport_destination_dk,
 weather_type_dk,
 flight_dep_scheduled_ts as flight_scheduled_ts,
 flight_dep_actual_ts as flight_actual_time,
 flight_number,
 distance,
 tail_number,
 reporting_airline as airline,
 dep_delay_minutes as dep_delay_min,
 cancelled,
 cancellation_code,
   t,
 max_gws,
 w_speed,
 air_time,
 42 as author,
 now() as loaded_ts
 from flights_for_dds f
	inner join weather_for_dds as w on f.airport_origin_dk=w.airport_dk and    (f.flight_dep_scheduled_ts::timestamp between w.date_start::timestamp and w.date_start::timestamp+ interval '1 hour')
 )


  --код загрузки в mart
 insert into   mart.fact_departure(airport_origin_dk,airport_destination_dk,weather_type_dk,flight_scheduled_  ts,flight_actual_time,flight_number,distance,tail_number,airline,dep_delay_min,cancelled,cancellation_code,t,max_gws,w_speed,air_time,author,loaded_ts)
 select * from data_for_mart_fact_dep
 where tail_number is not null
