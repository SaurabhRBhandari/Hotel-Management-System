CREATE DATABASE IF NOT EXISTS hoteldb;

USE hoteldb;

CREATE TABLE IF NOT EXISTS customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255),
    address VARCHAR(255));

CREATE TABLE IF NOT EXISTS room_type_cost (
    room_type VARCHAR(255) PRIMARY KEY, 
    price INT);

CREATE TABLE IF NOT EXISTS room (
    room_no INT PRIMARY KEY, 
    room_type VARCHAR(255) REFERENCES room_type_cost, 
    room_status BOOLEAN);

CREATE TABLE IF NOT EXISTS bill (
    bill_id INT AUTO_INCREMENT PRIMARY KEY, 
    base_cost INT, 
    service_cost INT);

CREATE TABLE IF NOT EXISTS pays (
    customer_id INT REFERENCES customer ON DELETE CASCADE, 
    bill_id INT REFERENCES bill, 
    PRIMARY KEY (customer_id, bill_id));

CREATE TABLE IF NOT EXISTS staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(255), 
    phone VARCHAR(255), 
    email VARCHAR(255), 
    address VARCHAR(255), 
    position VARCHAR(255));

CREATE TABLE IF NOT EXISTS allots (
    staff_id INT REFERENCES staff ON DELETE CASCADE, 
    room_no INT REFERENCES room, 
    PRIMARY KEY (staff_id, room_no));

CREATE TABLE IF NOT EXISTS service_info (
    service_name VARCHAR(255) PRIMARY KEY , 
    service_cost INT);

CREATE TABLE IF NOT EXISTS service (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(255) REFERENCES service_info,
    quantity INT);

CREATE TABLE IF NOT EXISTS provides (
    room_no INT REFERENCES room, 
    service_id INT REFERENCES service, 
    PRIMARY KEY (service_id));

CREATE TABLE IF NOT EXISTS reservation (
    room_no INT REFERENCES room,
    bill_id INT REFERENCES bill,
    checkin_date DATE, 
    checkout_date DATE , 
    PRIMARY KEY (room_no, bill_id));
