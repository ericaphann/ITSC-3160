DROP DATABASE IF EXISTS Car_Insurance;
CREATE DATABASE Car_Insurance;
USE Car_Insurance;

DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS car;
DROP TABLE IF EXISTS accident;
DROP TABLE IF EXISTS owns;
DROP TABLE IF EXISTS participates;

CREATE TABLE customer (
    fname VARCHAR(20),
    lname VARCHAR(20),
    zipcode CHAR(5),
    street VARCHAR(50),
    city VARCHAR(50),
    driver_id VARCHAR(12),
    PRIMARY KEY(driver_id)
);

CREATE TABLE car (
    license VARCHAR(8),
    model VARCHAR(50),
    year CHAR(4),
    PRIMARY KEY(license)
);

CREATE TABLE accident (
	location VARCHAR(50),
    date CHAR(10),
    report_number VARCHAR(20),
    PRIMARY KEY(report_number)
);

CREATE TABLE owns (
	license VARCHAR(8),
    driver_id VARCHAR(12),
    model VARCHAR(50),
    year CHAR(4),
    PRIMARY KEY(license, driver_id),
    FOREIGN KEY(license) REFERENCES car(license),
    FOREIGN KEY(driver_id) REFERENCES customer(driver_id)
);

CREATE TABLE participates (
	driver_id VARCHAR(12),
    license VARCHAR(8),
    responsible_driver VARCHAR(12),
    damage_amount CHAR(20),
    report_number VARCHAR(20),
    PRIMARY KEY(driver_id, license, report_number),
    FOREIGN KEY(driver_id) REFERENCES customer(driver_id),
    FOREIGN KEY(license) REFERENCES car(license),
    FOREIGN KEY(report_number) REFERENCES accident(report_number)
);

SELECT *
FROM customer;

SELECT *
FROM car;

SELECT *
FROM accident;

SELECT *
FROM owns;

SELECT *
FROM participates;




