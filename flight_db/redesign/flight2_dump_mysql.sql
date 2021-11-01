--------------------
-- 1. preamble 
--------------------
SET autocommit = 0;
-- PRAGMA foreign_keys=OFF;
SET FOREIGN_KEY_CHECKS = 0;
-- BEGIN TRANSACTION;
START TRANSACTION;
-----------------------
-- 2. schema object 
-----------------------
DROP SCHEMA IF EXISTS flight2;
CREATE SCHEMA IF NOT EXISTS flight2;
USE flight2;
----------------------------
-- 3. table objects 
----------------------------
DROP TABLE IF EXISTS airport;
CREATE TABLE IF NOT EXISTS airport (
    faa char(3) primary key,
    airport_name varchar(100) not null, 
    tzone varchar(100) default null
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- dump data
LOCK TABLES airport WRITE;
INSERT INTO airport VALUES('DFW','Dallas Fort Worth Intl','America/Chicago');
INSERT INTO airport VALUES('BQK','Brunswick Golden Isles','America/New_York');
INSERT INTO airport VALUES('EWR','Newark Liberty Intl','America/New_York');
INSERT INTO airport VALUES('FLL','Fort Lauderdale Hollywood Intl','America/New_York');
INSERT INTO airport VALUES('IAH','George Bush Intercontinental','America/Chicago');
INSERT INTO airport VALUES('JFK','John F Kennedy Intl','America/New_York');
INSERT INTO airport VALUES('LGA','La Guardia','America/New_York');
INSERT INTO airport VALUES('MIA','Miami Intl','America/New_York');
INSERT INTO airport VALUES('ORD','Chicago Ohare Intl','America/Chicago');
UNLOCK TABLES;
--
DROP TABLE IF EXISTS airline;
CREATE TABLE IF NOT EXISTS airline (
    carrier char(2) primary key,
    airline_name varchar(100) not null 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- dump data
LOCK TABLES airline WRITE;
INSERT INTO airline VALUES('9E','Endeavor Air Inc.');
INSERT INTO airline VALUES('AA','American Airlines Inc.');
INSERT INTO airline VALUES('AS','Alaska Airlines Inc.');
INSERT INTO airline VALUES('B6','JetBlue Airways');
INSERT INTO airline VALUES('DL','Delta Air Lines Inc.');
INSERT INTO airline VALUES('EV','ExpressJet Airlines Inc.');
INSERT INTO airline VALUES('F9','Frontier Airlines Inc.');
INSERT INTO airline VALUES('FL','AirTran Airways Corporation');
INSERT INTO airline VALUES('HA','Hawaiian Airlines Inc.');
INSERT INTO airline VALUES('MQ','Envoy Air');
INSERT INTO airline VALUES('OO','SkyWest Airlines Inc.');
INSERT INTO airline VALUES('UA','United Air Lines Inc.');
INSERT INTO airline VALUES('US','US Airways Inc.');
INSERT INTO airline VALUES('VX','Virgin America');
INSERT INTO airline VALUES('WN','Southwest Airlines Co.');
INSERT INTO airline VALUES('YV','Mesa Airlines Inc.');
UNLOCK TABLES;
-- 
DROP TABLE IF EXISTS flight;
CREATE TABLE IF NOT EXISTS flight (
    flight_id int primary key auto_increment,
    origin char(3) not null,
    destination char(3) not null,
    carrier char(2) not null,
    duration integer default null,
    foreign key (origin) references airport (faa),
    foreign key (destination) references airport (faa),
    foreign key (carrier) references airline (carrier)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- dump data
LOCK TABLES flight WRITE;
INSERT INTO flight VALUES(1,'DFW','ORD','DL',165);
INSERT INTO flight VALUES(2,'EWR','IAH','AA',227);
INSERT INTO flight VALUES(3,'JFK','MIA','US',160);
INSERT INTO flight VALUES(4,'JFK','BQK','US',300);
INSERT INTO flight VALUES(5,'EWR','ORD','AA',150);
INSERT INTO flight VALUES(6,'EWR','FLL','AA',158);
INSERT INTO flight VALUES(7,'LGA','DFW','DL',257);
UNLOCK TABLES;
--
DROP TABLE IF EXISTS passenger;
CREATE TABLE IF NOT EXISTS passenger (
    passenger_id int primary key auto_increment,
    flight_id int not null,
    firstname varchar(100) not null,
    midname varchar(50),
    lastname varchar(100) not null,
    sex char(1) not null,
    foreign key (flight_id) references flight (flight_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- DELETE FROM sqlite_sequence;
-- INSERT INTO sqlite_sequence VALUES('flight',7);
------------------
-- 4. postamble 
------------------
SET FOREIGN_KEY_CHECKS = 1;
COMMIT; -- commits the current transaction, making its changes permanent. 
SET autocommit = 1;
SHOW table status;
