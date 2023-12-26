 create or replace temp view time_flight as
 (select *, replace(concat(split_part(split_part(flight_date,'  ',1),'/',3),'/',split_part(split_part(flight_date,' ',1),'/',1),'/',split_part(split_part(flight_date,' ',1),'/',2),' ', crs_dep_time),'/','-')::timestamp as flight_dep_scheduled,
 concat(split_part(split_part(flight_date,' ',1),'/',3),'/',split_part(split_part(flight_date,' ',1),'/',1),'/',split_part(split_part(flight_date,' ',1),'/',2),' ', crs_dep_time)::date as flight_scheduled_date,
 replace(concat(split_part(split_part(flight_date,' ',1),'/',3),'/',split_part(split_part(flight_date,' ',1),'/',1),'/',split_part(split_part(flight_date,' ',1),'/',2),' ', crs_dep_time),'/','-')::timestamp + (dep_delay_minutes ||' minutes')::interval as flight_dep_actual,
 (replace(concat(split_part(split_part(flight_date,' ',1),'/',3),'/',split_part(split_part(flight_date,' ',1),'/',1),'/',split_part(split_part(flight_date,' ',1),'/',2),' ', crs_dep_time),'/','-')::timestamp + (dep_delay_minutes ||' minutes')::interval)::date as flight_actual_date
 from kdz_42_staging.flights f )
 -- view для загрузки в flights
 create or replace temp view flights_for_dds as
 (select f."year",
 f.quarter ,
 f."month" ,
 t.flight_scheduled_date,
 t.flight_actual_date,
 t.flight_dep_scheduled as flight_dep_scheduled_ts,
 t.flight_dep_actual as flight_dep_actual_ts,
 f.reporting_airline ,
 f.tail_number ,
 f.flight_number,
 (select airport_dk from dds.airport a2 where a2.iata_code = f.origin) as airport_origin_dk,
 f.origin as origin_code,
 (select airport_dk from dds.airport a2 where a2.iata_code = f.dest) as airport_dest_dk,
 f.dest as dest_code,
 f.dep_delay_minutes ,
 f.cancelled,
 f.cancellation_code ,
 f.weather_delay,
 f.air_time,
 f.distance ,
 f.loaded_ts
 from kdz_42_staging.flights f
 inner join time_flight as t on f.flight_date = t.flight_date and f.flight_number = t.flight_number and f.crs_dep_time = t.crs_dep_time and f.origin = t.origin and f.dest = t.dest and f.tail_number=t.tail_number
)
