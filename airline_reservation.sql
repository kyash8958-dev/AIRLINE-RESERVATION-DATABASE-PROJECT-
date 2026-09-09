-- =========================================
-- AIRLINE RESERVATION DATABASE PROJECT
-- DBMS: MySQL 8+
-- =========================================

CREATE DATABASE IF NOT EXISTS airline_reservation;
USE airline_reservation;

-- Clean old objects
DROP VIEW IF EXISTS v_ticket_details;
DROP TRIGGER IF EXISTS trg_book_seat;

DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS seats;
DROP TABLE IF EXISTS passengers;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS maps;


-- =========================================
-- 1. MAPS TABLE
-- =========================================

CREATE TABLE maps (
    map_id INT PRIMARY KEY,
    map_name VARCHAR(100) NOT NULL,
    origin_city VARCHAR(60) NOT NULL,
    destination_city VARCHAR(60) NOT NULL,
    distance_km INT NOT NULL,
    route_type VARCHAR(20) NOT NULL
);


-- =========================================
-- 2. FLIGHTS TABLE
-- =========================================

CREATE TABLE flights (
    flight_id INT PRIMARY KEY,
    flight_no VARCHAR(20) NOT NULL UNIQUE,
    airline VARCHAR(80) NOT NULL,
    map_id INT NOT NULL,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Scheduled',

    FOREIGN KEY (map_id)
        REFERENCES maps(map_id)
);


-- =========================================
-- 3. PASSENGERS TABLE
-- =========================================

CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    passport_no VARCHAR(30) NOT NULL UNIQUE
);


-- =========================================
-- 4. SEATS TABLE
-- =========================================

CREATE TABLE seats (
    seat_id INT PRIMARY KEY,
    flight_id INT NOT NULL,
    seat_no VARCHAR(5) NOT NULL,
    seat_class VARCHAR(20) NOT NULL,
    seat_status VARCHAR(20) NOT NULL DEFAULT 'Available',

    UNIQUE (flight_id, seat_no),

    FOREIGN KEY (flight_id)
        REFERENCES flights(flight_id)
);


-- =========================================
-- 5. TICKETS TABLE
-- =========================================

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    passenger_id INT NOT NULL,
    seat_id INT NOT NULL UNIQUE,
    booking_date DATE NOT NULL,
    fare DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    ticket_status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',

    FOREIGN KEY (passenger_id)
        REFERENCES passengers(passenger_id),

    FOREIGN KEY (seat_id)
        REFERENCES seats(seat_id)
);


-- =========================================
-- SAMPLE DATA: MAPS
-- =========================================

INSERT INTO maps VALUES
(1,'Delhi-Mumbai Route','Delhi','Mumbai',1150,'Domestic'),
(2,'Delhi-Bengaluru Route','Delhi','Bengaluru',1740,'Domestic'),
(3,'Mumbai-Chennai Route','Mumbai','Chennai',1030,'Domestic'),
(4,'Delhi-Kolkata Route','Delhi','Kolkata',1305,'Domestic'),
(5,'Mumbai-Hyderabad Route','Mumbai','Hyderabad',620,'Domestic'),
(6,'Bengaluru-Kolkata Route','Bengaluru','Kolkata',1560,'Domestic'),
(7,'Delhi-Goa Route','Delhi','Goa',1510,'Domestic'),
(8,'Chennai-Delhi Route','Chennai','Delhi',1760,'Domestic'),
(9,'Hyderabad-Delhi Route','Hyderabad','Delhi',1260,'Domestic'),
(10,'Kolkata-Mumbai Route','Kolkata','Mumbai',1650,'Domestic'),
(11,'Delhi-Dubai Route','Delhi','Dubai',2190,'International'),
(12,'Mumbai-Singapore Route','Mumbai','Singapore',3920,'International'),
(13,'Delhi-London Route','Delhi','London',6700,'International'),
(14,'Bengaluru-Dubai Route','Bengaluru','Dubai',2630,'International'),
(15,'Chennai-Singapore Route','Chennai','Singapore',2900,'International'),
(16,'Mumbai-Bangkok Route','Mumbai','Bangkok',3000,'International'),
(17,'Delhi-Bangkok Route','Delhi','Bangkok',2920,'International'),
(18,'Hyderabad-Dubai Route','Hyderabad','Dubai',2450,'International'),
(19,'Kolkata-Dhaka Route','Kolkata','Dhaka',240,'International'),
(20,'Delhi-Kathmandu Route','Delhi','Kathmandu',800,'International');


-- =========================================
-- SAMPLE DATA: FLIGHTS
-- =========================================

INSERT INTO flights VALUES
(1,'AI101','Air India',1,'2026-10-01','06:30:00','08:40:00','Scheduled'),
(2,'6E202','IndiGo',2,'2026-10-02','07:00:00','10:00:00','Scheduled'),
(3,'AI303','Air India',3,'2026-10-03','09:15:00','11:10:00','Scheduled'),
(4,'6E404','IndiGo',4,'2026-10-04','10:30:00','13:00:00','Scheduled'),
(5,'UK505','Vistara',5,'2026-10-05','12:00:00','13:20:00','Scheduled'),
(6,'6E606','IndiGo',6,'2026-10-06','14:10:00','16:45:00','Scheduled'),
(7,'AI707','Air India',7,'2026-10-07','16:00:00','18:30:00','Scheduled'),
(8,'6E808','IndiGo',8,'2026-10-08','18:00:00','21:00:00','Scheduled'),
(9,'AI909','Air India',9,'2026-10-09','06:45:00','09:00:00','Scheduled'),
(10,'UK010','Vistara',10,'2026-10-10','08:30:00','11:15:00','Scheduled'),
(11,'AI111','Air India',11,'2026-10-11','21:00:00','23:45:00','Scheduled'),
(12,'6E212','IndiGo',12,'2026-10-12','23:00:00','06:30:00','Scheduled'),
(13,'AI313','Air India',13,'2026-10-13','22:00:00','06:30:00','Scheduled'),
(14,'6E414','IndiGo',14,'2026-10-14','20:30:00','23:55:00','Scheduled'),
(15,'AI515','Air India',15,'2026-10-15','19:00:00','23:00:00','Scheduled'),
(16,'6E616','IndiGo',16,'2026-10-16','18:30:00','23:45:00','Scheduled'),
(17,'AI717','Air India',17,'2026-10-17','20:00:00','01:30:00','Scheduled'),
(18,'6E818','IndiGo',18,'2026-10-18','22:30:00','01:30:00','Scheduled'),
(19,'AI919','Air India',19,'2026-10-19','08:00:00','09:15:00','Scheduled'),
(20,'6E020','IndiGo',20,'2026-10-20','11:00:00','13:00:00','Scheduled');


-- =========================================
-- SAMPLE DATA: PASSENGERS
-- =========================================

INSERT INTO passengers VALUES
(1,'Aarav','Sharma','aarav.sharma@example.com','9876500001','P100001'),
(2,'Ananya','Verma','ananya.verma@example.com','9876500002','P100002'),
(3,'Rohan','Gupta','rohan.gupta@example.com','9876500003','P100003'),
(4,'Priya','Singh','priya.singh@example.com','9876500004','P100004'),
(5,'Karan','Mehta','karan.mehta@example.com','9876500005','P100005'),
(6,'Neha','Kapoor','neha.kapoor@example.com','9876500006','P100006'),
(7,'Aditya','Jain','aditya.jain@example.com','9876500007','P100007'),
(8,'Isha','Malhotra','isha.malhotra@example.com','9876500008','P100008'),
(9,'Rahul','Bansal','rahul.bansal@example.com','9876500009','P100009'),
(10,'Simran','Kaur','simran.kaur@example.com','9876500010','P100010'),
(11,'Vikram','Yadav','vikram.yadav@example.com','9876500011','P100011'),
(12,'Pallavi','Agarwal','pallavi.agarwal@example.com','9876500012','P100012'),
(13,'Nikhil','Sethi','nikhil.sethi@example.com','9876500013','P100013'),
(14,'Sakshi','Mishra','sakshi.mishra@example.com','9876500014','P100014'),
(15,'Arjun','Rao','arjun.rao@example.com','9876500015','P100015'),
(16,'Meera','Joshi','meera.joshi@example.com','9876500016','P100016'),
(17,'Dev','Chopra','dev.chopra@example.com','9876500017','P100017'),
(18,'Tanya','Shah','tanya.shah@example.com','9876500018','P100018'),
(19,'Yash','Arora','yash.arora@example.com','9876500019','P100019'),
(20,'Kriti','Saxena','kriti.saxena@example.com','9876500020','P100020');


-- =========================================
-- SEATS: 4 SEATS PER FLIGHT
-- =========================================

INSERT INTO seats
(seat_id,flight_id,seat_no,seat_class,seat_status) VALUES
(1,1,'1A','Economy','Available'),
(2,1,'1B','Economy','Available'),
(3,1,'2A','Business','Available'),
(4,1,'2B','Business','Available'),

(5,2,'1A','Economy','Available'),
(6,2,'1B','Economy','Available'),
(7,2,'2A','Business','Available'),
(8,2,'2B','Business','Available'),

(9,3,'1A','Economy','Available'),
(10,3,'1B','Economy','Available'),
(11,3,'2A','Business','Available'),
(12,3,'2B','Business','Available'),

(13,4,'1A','Economy','Available'),
(14,4,'1B','Economy','Available'),
(15,4,'2A','Business','Available'),
(16,4,'2B','Business','Available'),

(17,5,'1A','Economy','Available'),
(18,5,'1B','Economy','Available'),
(19,5,'2A','Business','Available'),
(20,5,'2B','Business','Available'),

(21,6,'1A','Economy','Available'),
(22,6,'1B','Economy','Available'),
(23,6,'2A','Business','Available'),
(24,6,'2B','Business','Available'),

(25,7,'1A','Economy','Available'),
(26,7,'1B','Economy','Available'),
(27,7,'2A','Business','Available'),
(28,7,'2B','Business','Available'),

(29,8,'1A','Economy','Available'),
(30,8,'1B','Economy','Available'),
(31,8,'2A','Business','Available'),
(32,8,'2B','Business','Available'),

(33,9,'1A','Economy','Available'),
(34,9,'1B','Economy','Available'),
(35,9,'2A','Business','Available'),
(36,9,'2B','Business','Available'),

(37,10,'1A','Economy','Available'),
(38,10,'1B','Economy','Available'),
(39,10,'2A','Business','Available'),
(40,10,'2B','Business','Available'),

(41,11,'1A','Economy','Available'),
(42,11,'1B','Economy','Available'),
(43,11,'2A','Business','Available'),
(44,11,'2B','Business','Available'),

(45,12,'1A','Economy','Available'),
(46,12,'1B','Economy','Available'),
(47,12,'2A','Business','Available'),
(48,12,'2B','Business','Available'),

(49,13,'1A','Economy','Available'),
(50,13,'1B','Economy','Available'),
(51,13,'2A','Business','Available'),
(52,13,'2B','Business','Available'),

(53,14,'1A','Economy','Available'),
(54,14,'1B','Economy','Available'),
(55,14,'2A','Business','Available'),
(56,14,'2B','Business','Available'),

(57,15,'1A','Economy','Available'),
(58,15,'1B','Economy','Available'),
(59,15,'2A','Business','Available'),
(60,15,'2B','Business','Available'),

(61,16,'1A','Economy','Available'),
(62,16,'1B','Economy','Available'),
(63,16,'2A','Business','Available'),
(64,16,'2B','Business','Available'),

(65,17,'1A','Economy','Available'),
(66,17,'1B','Economy','Available'),
(67,17,'2A','Business','Available'),
(68,17,'2B','Business','Available'),

(69,18,'1A','Economy','Available'),
(70,18,'1B','Economy','Available'),
(71,18,'2A','Business','Available'),
(72,18,'2B','Business','Available'),

(73,19,'1A','Economy','Available'),
(74,19,'1B','Economy','Available'),
(75,19,'2A','Business','Available'),
(76,19,'2B','Business','Available'),

(77,20,'1A','Economy','Available'),
(78,20,'1B','Economy','Available'),
(79,20,'2A','Business','Available'),
(80,20,'2B','Business','Available');


-- =========================================
-- TICKETS
-- =========================================

INSERT INTO tickets VALUES
(1,1,1,'2026-09-01',5500,'Paid','Confirmed'),
(2,2,5,'2026-09-01',6200,'Paid','Confirmed'),
(3,3,9,'2026-09-02',5800,'Paid','Confirmed'),
(4,4,13,'2026-09-02',6000,'Paid','Confirmed'),
(5,5,17,'2026-09-03',4500,'Paid','Confirmed'),
(6,6,21,'2026-09-03',5200,'Paid','Confirmed'),
(7,7,25,'2026-09-04',4800,'Paid','Confirmed'),
(8,8,29,'2026-09-04',5100,'Paid','Confirmed'),
(9,9,33,'2026-09-05',5300,'Paid','Confirmed'),
(10,10,37,'2026-09-05',5700,'Paid','Confirmed'),
(11,11,41,'2026-09-06',18000,'Paid','Confirmed'),
(12,12,45,'2026-09-06',32000,'Paid','Confirmed'),
(13,13,49,'2026-09-06',55000,'Paid','Confirmed'),
(14,14,53,'2026-09-07',21000,'Paid','Confirmed'),
(15,15,57,'2026-09-07',28000,'Paid','Confirmed'),
(16,16,61,'2026-09-07',24000,'Paid','Confirmed'),
(17,17,65,'2026-09-08',23000,'Paid','Confirmed'),
(18,18,69,'2026-09-08',20000,'Paid','Confirmed'),
(19,19,73,'2026-09-08',9000,'Paid','Confirmed'),
(20,20,77,'2026-09-08',15000,'Paid','Confirmed');


-- =========================================
-- TRIGGER
-- =========================================

DELIMITER //

CREATE TRIGGER trg_book_seat
AFTER INSERT ON tickets
FOR EACH ROW
BEGIN
    UPDATE seats
    SET seat_status = 'Booked'
    WHERE seat_id = NEW.seat_id;
END//

DELIMITER ;


-- =========================================
-- 1. JOIN QUERY
-- =========================================

SELECT
    t.ticket_id,
    CONCAT(p.first_name,' ',p.last_name) AS passenger,
    f.flight_no,
    m.origin_city,
    m.destination_city,
    s.seat_no,
    s.seat_class,
    t.fare
FROM tickets t
JOIN passengers p
    ON t.passenger_id = p.passenger_id
JOIN seats s
    ON t.seat_id = s.seat_id
JOIN flights f
    ON s.flight_id = f.flight_id
JOIN maps m
    ON f.map_id = m.map_id
ORDER BY t.ticket_id;


-- =========================================
-- 2. GROUP BY + HAVING
-- =========================================

SELECT
    f.airline,
    COUNT(t.ticket_id) AS total_tickets,
    SUM(t.fare) AS total_revenue
FROM flights f
JOIN seats s
    ON f.flight_id = s.flight_id
JOIN tickets t
    ON s.seat_id = t.seat_id
GROUP BY f.airline
HAVING SUM(t.fare) > 50000;


-- =========================================
-- 3. SUBQUERY
-- Passengers who paid more than average fare
-- =========================================

SELECT
    CONCAT(p.first_name,' ',p.last_name) AS passenger,
    t.fare
FROM passengers p
JOIN tickets t
    ON p.passenger_id = t.passenger_id
WHERE t.fare > (
    SELECT AVG(fare)
    FROM tickets
);


-- =========================================
-- 4. VIEW
-- =========================================

CREATE OR REPLACE VIEW v_ticket_details AS
SELECT
    t.ticket_id,
    CONCAT(p.first_name,' ',p.last_name) AS passenger_name,
    p.email,
    f.flight_no,
    m.origin_city,
    m.destination_city,
    f.departure_date,
    f.departure_time,
    s.seat_no,
    s.seat_class,
    t.fare,
    t.payment_status,
    t.ticket_status
FROM tickets t
JOIN passengers p
    ON t.passenger_id = p.passenger_id
JOIN seats s
    ON t.seat_id = s.seat_id
JOIN flights f
    ON s.flight_id = f.flight_id
JOIN maps m
    ON f.map_id = m.map_id;


-- View result
SELECT * FROM v_ticket_details;


-- =========================================
-- EXTRA QUERIES
-- =========================================

-- Available seats
SELECT *
FROM seats
WHERE seat_status = 'Available';


-- Scheduled flights
SELECT
    f.flight_no,
    m.origin_city,
    m.destination_city
FROM flights f
JOIN maps m
    ON f.map_id = m.map_id
WHERE f.status = 'Scheduled';


-- Seats sold by class
SELECT
    seat_class,
    COUNT(*) AS seats_sold
FROM seats
WHERE seat_status = 'Booked'
GROUP BY seat_class;
