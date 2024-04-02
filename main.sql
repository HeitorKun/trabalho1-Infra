select 'create table '
       || table_name
       || ' as select * from ARRUDA.'
       || table_name
       || ';'
  from all_tables
 where owner = 'ARRUDA'
   and table_name like 'AIR_%';

create table air_airlines
	as
		select *
		  from arruda.air_airlines;

create table air_airplanes
	as
		select *
		  from arruda.air_airplanes;

create table air_airplane_types
	as
		select *
		  from arruda.air_airplane_types;

create table air_airports
	as
		select *
		  from arruda.air_airports;

create table air_airports_geo
	as
		select *
		  from arruda.air_airports_geo;

create table air_bookings
	as
		select *
		  from arruda.air_bookings;

create table air_flights
	as
		select *
		  from arruda.air_flights;

create table air_flights_schedules
	as
		select *
		  from arruda.air_flights_schedules;

create table air_passengers
	as
		select *
		  from arruda.air_passengers;

create table air_passengers_details
	as
		select *
		  from arruda.air_passengers_details;


select firstname,
       lastname
  from arruda.air_passengers;



SELECT 
    AP.FIRSTNAME || ' ' || AP.LASTNAME AS FullName,
    TRUNC(MONTHS_BETWEEN(SYSDATE, APD.BIRTHDATE) / 12) AS Age,
    APD.CITY
FROM 
    AIR_PASSENGERS AP
INNER JOIN 
    AIR_PASSENGERS_DETAILS APD 
    ON AP.PASSENGER_ID = APD.PASSENGER_ID
WHERE 
    APD.SEX = 'w'
    AND APD.COUNTRY = 'BRAZIL'
    AND TRUNC(MONTHS_BETWEEN(SYSDATE, APD.BIRTHDATE) / 12) > 40;
