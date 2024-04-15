
DECLARE
  v_sql VARCHAR2(1000);
BEGIN
  FOR cur_tables IN (SELECT table_name FROM user_tables WHERE table_name LIKE 'AIR%' ESCAPE '_') LOOP
    v_sql := 'DROP TABLE ' || cur_tables.table_name;
    EXECUTE IMMEDIATE v_sql;
  END LOOP;
END;
/

DECLARE
  v_sql VARCHAR2(1000);
BEGIN
  FOR cur_clusters IN (SELECT cluster_name FROM user_clusters) LOOP
    v_sql := 'DROP CLUSTER ' || cur_clusters.cluster_name;
    EXECUTE IMMEDIATE v_sql;
  END LOOP;
END;
/

create table AIR_AIRLINES as select * from DSILVA.AIR_AIRLINES;
create table AIR_AIRPLANES as select * from DSILVA.AIR_AIRPLANES;
create table AIR_AIRPLANE_TYPES as select * from DSILVA.AIR_AIRPLANE_TYPES;
create table AIR_AIRPORTS as select * from DSILVA.AIR_AIRPORTS;
create table AIR_AIRPORTS_GEO as select * from DSILVA.AIR_AIRPORTS_GEO;
create table AIR_BOOKINGS as select * from DSILVA.AIR_BOOKINGS;
create table AIR_FLIGHTS as select * from DSILVA.AIR_FLIGHTS;
create table AIR_FLIGHTS_SCHEDULES as select * from DSILVA.AIR_FLIGHTS_SCHEDULES;
create table AIR_PASSENGERS as select * from DSILVA.AIR_PASSENGERS;
create table AIR_PASSENGERS_DETAILS as select * from DSILVA.AIR_PASSENGERS_DETAILS;
