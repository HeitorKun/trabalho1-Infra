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


-- 1

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
    AND TRUNC(MONTHS_BETWEEN(SYSDATE, APD.BIRTHDATE) / 12) >= 40;


--2
SELECT 
    AA.AIRLINE_NAME,
    AP.AIRPLANE_ID,
    AT.NAME AS AIRPLANE_TYPE_NAME,
    COUNT(AF.FLIGHT_ID) AS NUMBER_OF_FLIGHTS
FROM 
    AIR_FLIGHTS AF
INNER JOIN 
    AIR_AIRLINES AA ON AF.AIRLINE_ID = AA.AIRLINE_ID -- Assuming AIRLINE_ID should be joined
INNER JOIN 
    AIR_AIRPLANES AP ON AF.AIRPLANE_ID = AP.AIRPLANE_ID
INNER JOIN 
    AIR_AIRPLANE_TYPES AT ON AP.AIRPLANE_TYPE_ID = AT.AIRPLANE_TYPE_ID
INNER JOIN 
    AIR_AIRPORTS FROM_A ON AF.FROM_AIRPORT_ID = FROM_A.AIRPORT_ID
INNER JOIN 
    AIR_AIRPORTS TO_A ON AF.TO_AIRPORT_ID = TO_A.AIRPORT_ID
INNER JOIN 
    AIR_AIRPORTS_GEO FROM_AG ON FROM_A.AIRPORT_ID = FROM_AG.AIRPORT_ID
INNER JOIN 
    AIR_AIRPORTS_GEO TO_AG ON TO_A.AIRPORT_ID = TO_AG.AIRPORT_ID
WHERE 
    FROM_AG.COUNTRY = 'BRAZIL' AND TO_AG.COUNTRY = 'BRAZIL'
GROUP BY 
    AA.AIRLINE_NAME, AP.AIRPLANE_ID, AT.NAME;


--3
SELECT 
    AF.FLIGHTNO AS FlightNumber,
    DEP_AIRPORT.NAME AS DepartureAirport,
    ARR_AIRPORT.NAME AS ArrivalAirport,
    (AP.FIRSTNAME || ' ' || AP.LASTNAME) AS FullName,
    AB.SEAT AS SeatNumber
FROM 
    AIR_FLIGHTS AF
INNER JOIN 
    AIR_AIRPORTS DEP_AIRPORT ON AF.FROM_AIRPORT_ID = DEP_AIRPORT.AIRPORT_ID
INNER JOIN 
    AIR_AIRPORTS ARR_AIRPORT ON AF.TO_AIRPORT_ID = ARR_AIRPORT.AIRPORT_ID
INNER JOIN 
    AIR_BOOKINGS AB ON AF.FLIGHT_ID = AB.FLIGHT_ID
INNER JOIN 
    AIR_PASSENGERS AP ON AB.PASSENGER_ID = AP.PASSENGER_ID
WHERE 
    TRUNC(AF.DEPARTURE) = DATE '2023-03-25';


--4

SELECT 
    AA.AIRLINE_NAME,
    AFS.FLIGHTNO,
    AF.DEPARTURE
FROM 
    AIR_FLIGHTS_SCHEDULES AFS
INNER JOIN 
    AIR_AIRLINES AA ON AFS.AIRLINE_ID = AA.AIRLINE_ID
INNER JOIN 
    AIR_AIRPORTS ARR_AIRPORT ON AFS.TO_AIRPORT_ID = ARR_AIRPORT.AIRPORT_ID
INNER JOIN 
    AIR_AIRPORTS_GEO AG ON ARR_AIRPORT.AIRPORT_ID = AG.AIRPORT_ID
INNER JOIN 
    AIR_FLIGHTS AF ON AFS.FLIGHTNO = AF.FLIGHTNO
WHERE 
    AG.CITY = 'NEW YORK'
    AND (AFS.TUESDAY = 1 OR AFS.WEDNESDAY = 1 OR AFS.THURSDAY = 1)
    AND EXTRACT(MONTH FROM AF.DEPARTURE) = 3;

