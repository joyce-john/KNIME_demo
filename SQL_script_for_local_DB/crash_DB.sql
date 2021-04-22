-- create the schema
DROP SCHEMA IF EXISTS crash_data;
CREATE SCHEMA crash_data;
USE crash_data;

-- create the table for storing crash records
DROP TABLE IF EXISTS crash_records;
CREATE TABLE crash_records(
date VARCHAR(255),
precipitation DOUBLE,
crash_time VARCHAR(255),
on_street_name VARCHAR(255),
number_of_persons_injured INT,
number_of_persons_killed INT,
number_of_pedestrians_injured INT,
number_of_pedestrians_killed INT,
number_of_cyclist_injured INT,
number_of_cyclist_killed INT,
number_of_motorist_injured INT,
number_of_motorist_killed INT,
contributing_factor_vehicle_1 VARCHAR(255),
contributing_factor_vehicle_2 VARCHAR(255),
collision_id VARCHAR(255),
vehicle_type_code1 VARCHAR(255),
vehicle_type_code2 VARCHAR(255),
latitude VARCHAR(255),
longitude VARCHAR(255));

-- after inserting data with KNIME, view records
SELECT * FROM crash_records;