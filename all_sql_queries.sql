-- This procedure creates a new guest in the customer table with the provided information
CREATE PROCEDURE IF NOT EXISTS new_guest(
    IN p_name VARCHAR(255),
    -- Input parameter for the guest name
    IN p_phone VARCHAR(20),
    -- Input parameter for the guest phone number
    IN p_email VARCHAR(255),
    -- Input parameter for the guest email
    IN p_address VARCHAR(255) -- Input parameter for the guest address
) BEGIN
INSERT INTO
    customer -- Insert a new row into the customer table with the provided information
VALUES
    (NULL, p_name, p_phone, p_email, p_address);

END;

-- This procedure creates a new staff member in the staff table with the provided information
CREATE PROCEDURE IF NOT EXISTS new_staff(
    IN p_name VARCHAR(255),
    -- Input parameter for the staff member's name
    IN p_phone VARCHAR(20),
    -- Input parameter for the staff member's phone number
    IN p_email VARCHAR(255),
    -- Input parameter for the staff member's email
    IN p_address VARCHAR(255),
    -- Input parameter for the staff member's address
    IN p_position VARCHAR(255) -- Input parameter for the staff member's position
) BEGIN
INSERT INTO
    staff -- Insert a new row into the staff table with the provided information
VALUES
    (
        NULL,
        p_name,
        p_phone,
        p_email,
        p_address,
        p_position
    );

END;

-- This procedure deletes a guest from the customer table based on the provided customer_id
CREATE PROCEDURE IF NOT EXISTS delete_guest (
    IN p_id INT -- Input parameter for the customer_id to be deleted
) BEGIN
DELETE FROM
    customer -- Delete the row from the customer table with the provided customer_id
WHERE
    customer_id = p_id;

END;

-- This procedure updates the information of a customer in the customer table based on the provided customer_id
CREATE PROCEDURE IF NOT EXISTS update_customer(
    IN id INT,
    -- Input parameter for the customer_id to be updated
    IN p_name VARCHAR(255),
    -- Input parameter for the updated name of the customer
    IN p_phone VARCHAR(20),
    -- Input parameter for the updated phone number of the customer
    IN p_email VARCHAR(255),
    -- Input parameter for the updated email of the customer
    IN p_address VARCHAR(255) -- Input parameter for the updated address of the customer
) BEGIN
UPDATE
    customer
SET
    -- Update the row in the customer table with the provided information
    name = p_name,
    phone = p_phone,
    email = p_email,
    address = p_address
WHERE
    customer_id = id;

END;

-- This procedure retrieves the information of a customer from the customer table based on the provided customer_id
CREATE PROCEDURE IF NOT EXISTS get_customer(
    IN id INT -- Input parameter for the customer_id to be retrieved
) BEGIN
SELECT
    *
FROM
    customer -- Select all columns from the customer table for the row with the provided customer_id
WHERE
    customer_id = id;

END;

-- This procedure updates the information of a staff member in the staff table based on the provided staff_id
CREATE PROCEDURE IF NOT EXISTS update_staff(
    IN id INT,
    -- Input parameter for the staff_id to be updated
    IN name VARCHAR(255),
    -- Input parameter for the updated name of the staff member
    IN phone VARCHAR(20),
    -- Input parameter for the updated phone number of the staff member
    IN email VARCHAR(255),
    -- Input parameter for the updated email of the staff member
    IN position VARCHAR(255) -- Input parameter for the updated position of the staff member
) BEGIN
UPDATE
    staff
SET
    -- Update the row in the staff table with the provided information
    name = name,
    phone = phone,
    email = email,
    position = position
WHERE
    staff_id = id;

END;

-- Stored procedure to delete staff member
CREATE PROCEDURE IF NOT EXISTS delete_staff (IN p_id INT) BEGIN
DELETE FROM
    staff
WHERE
    staff_id = p_id;

END;

CREATE PROCEDURE IF NOT EXISTS new_order(
    IN p_room_no INT,
    IN p_service_name VARCHAR(255),
    IN p_quantity INT
) BEGIN -- Declare variables to store customer ID, bill ID, and service cost
DECLARE v_customer_id INT;

DECLARE v_bill_id INT;

DECLARE v_service_cost INT;

-- Find the customer ID of the guest currently occupying the room
SELECT
    customer_id INTO v_customer_id
FROM
    pays
WHERE
    bill_id = (
        SELECT
            bill_id
        FROM
            reservation
        WHERE
            room_no = p_room_no
            AND checkin_date <= NOW()
            AND checkout_date > NOW()
    );

-- Get the bill ID for the customer's current bill
SELECT
    bill_id INTO v_bill_id
FROM
    pays
WHERE
    customer_id = v_customer_id
    AND bill_id = (
        SELECT
            bill_id
        FROM
            reservation
        WHERE
            room_no = p_room_no
            AND checkin_date <= NOW()
            AND checkout_date > NOW()
    );

-- Get the service cost for the requested service
SELECT
    service_cost INTO v_service_cost
FROM
    service_info
WHERE
    service_name = p_service_name;

-- Add the service cost to the current bill's service_cost field
UPDATE
    bill
SET
    service_cost = service_cost + (v_service_cost * p_quantity)
WHERE
    bill_id = v_bill_id;

-- Add the service to the room's list of provided services
INSERT INTO
    service
VALUES
    (NULL, p_service_name, p_quantity);

INSERT INTO
    provides
VALUES
    (p_room_no, LAST_INSERT_ID());

END;

-- This procedure creates a new room in the hotel database
CREATE PROCEDURE IF NOT EXISTS new_room(
    IN p_room_no INT,
    -- The room number of the new room
    IN p_room_type VARCHAR(255),
    -- The type of the new room (e.g. "Single", "Double", etc.)
    IN p_room_status BOOLEAN -- The status of the new room (True = available, False = occupied)
) BEGIN
INSERT INTO
    room -- Insert a new row into the "room" table
VALUES
    (
        p_room_no,
        -- Use the value passed in as the room number
        p_room_type,
        -- Use the value passed in as the room type
        p_room_status
    );

-- Use the value passed in as the room status
END;

-- The following stored procedure sets the staff assigned to a specific room.
-- It takes in two parameters: the staff ID and the room number.
CREATE PROCEDURE IF NOT EXISTS set_staff(IN p_staff_id INT, IN p_room_no INT) BEGIN
INSERT INTO
    allots
VALUES
    (p_staff_id, p_room_no);

END;

-- The following stored procedure toggles the status of a specific room.
-- It takes in one parameter: the room number.
CREATE PROCEDURE toggle_status(IN p_room_no INT) BEGIN
UPDATE
    room
SET
    room_status = NOT room_status
WHERE
    room_no = p_room_no;

END;

CREATE PROCEDURE IF NOT EXISTS book_rooms(
    IN customer_id INT,
    IN room_nos VARCHAR(255),
    IN checkin_date DATE,
    IN checkout_date DATE
) BEGIN -- Create a new bill for the customer
INSERT INTO
    bill (base_cost, service_cost)
VALUES
    (0, 0);

SET
    @bill_id = LAST_INSERT_ID();

-- Insert a new record in the pays table to link the customer and bill
INSERT INTO
    pays (customer_id, bill_id)
VALUES
    (customer_id, @bill_id);

-- Split the room numbers string into a temporary table
DROP TEMPORARY TABLE IF EXISTS temp_room_nos;

-- drop temporary table if it exists
CREATE TEMPORARY TABLE temp_room_nos (room_no INT);

-- create temporary table to hold the room numbers
SET
    @query = CONCAT(
        "INSERT INTO temp_room_nos (room_no) VALUES ",
        room_nos,
        ";"
    );

-- construct query to insert the room numbers into temporary table
PREPARE stmt
FROM
    @query;

-- prepare the query for execution
EXECUTE stmt;

-- execute the query to insert the room numbers into temporary table
DEALLOCATE PREPARE stmt;

-- deallocate the prepared statement to free up resources
-- Book each room in the temporary table
WHILE EXISTS(
    SELECT
        *
    FROM
        temp_room_nos
) DO -- loop while there are still rooms to book
-- Get the first available room of the desired type
SELECT
    room.room_no INTO @room_no
FROM
    room
    INNER JOIN room_type_cost ON room.room_type = room_type_cost.room_type
WHERE
    room.room_no IN (
        SELECT
            room_no
        FROM
            temp_room_nos
    )
    AND NOT EXISTS (
        SELECT
            1
        FROM
            reservation
        WHERE
            reservation.room_no = room.room_no
            AND reservation.checkin_date <= checkout_date
            AND reservation.checkout_date >= checkin_date
    )
ORDER BY
    room_type_cost.price ASC
LIMIT
    1;

-- select the cheapest available room of the desired type
-- Book the room by inserting a record into the reservation table
INSERT INTO
    reservation (room_no, bill_id, checkin_date, checkout_date)
VALUES
    (@room_no, @bill_id, checkin_date, checkout_date);

-- Remove the booked room from the temporary table
DELETE FROM
    temp_room_nos
WHERE
    room_no = @room_no;

END WHILE;

-- Update the base cost of the bill to reflect the total room cost
UPDATE
    bill
SET
    base_cost = (
        SELECT
            SUM(
                room_type_cost.price * DATEDIFF(checkout_date, checkin_date)
            )
        FROM
            reservation
            INNER JOIN room ON reservation.room_no = room.room_no
            INNER JOIN room_type_cost ON room.room_type = room_type_cost.room_type
        WHERE
            reservation.bill_id = @bill_id
    )
WHERE
    bill_id = @bill_id;

END;

-- Procedure to delete a reservation for a given booking ID and room number
CREATE PROCEDURE IF NOT EXISTS delete_reservation(IN booking_id INT, IN room_no INT) BEGIN -- Declare variables to hold reservation cost, check-in date, and check-out date
DECLARE reservation_cost INT;

DECLARE checkin_date DATE;

DECLARE checkout_date DATE;

-- Retrieve the reservation cost based on the room type associated with the given room number
SELECT
    price INTO reservation_cost
FROM
    room_type_cost
WHERE
    room_type = (
        SELECT
            room_type
        FROM
            room r
        WHERE
            r.room_no = room_no
    );

-- Retrieve the check-in and check-out dates for the reservation matching the given booking ID and room number
SELECT
    r.checkin_date,
    r.checkout_date INTO checkin_date,
    checkout_date
FROM
    reservation r
WHERE
    r.bill_id = booking_id
    AND r.room_no = room_no;

-- Delete the reservation matching the given booking ID and room number
DELETE FROM
    reservation r
WHERE
    r.bill_id = booking_id
    AND r.room_no = room_no;

-- Update the bill associated with the given booking ID to reflect the change in base cost
UPDATE
    bill b
SET
    base_cost = base_cost - reservation_cost *(DATEDIFF(checkout_date, checkin_date))
WHERE
    b.bill_id = bill_id;

END;

-- Procedure to generate a bill for a given bill ID
CREATE PROCEDURE IF NOT EXISTS generate_bill(IN bill_id INT) BEGIN -- Select customer information, base cost, service cost, check-in date, check-out date, and number of rooms for the given bill ID
SELECT
    c.name,
    c.email,
    b.base_cost,
    b.service_cost,
    r.checkin_date,
    r.checkout_date,
    COUNT(DISTINCT r.room_no) AS num_rooms
FROM
    pays p
    JOIN customer c ON p.customer_id = c.customer_id
    JOIN bill b ON p.bill_id = b.bill_id
    JOIN reservation r ON p.bill_id = r.bill_id
WHERE
    p.bill_id = bill_id
GROUP BY
    c.name,
    c.email,
    b.base_cost,
    b.service_cost,
    r.checkin_date,
    r.checkout_date;

END;

-- Query to fetch all bills
SELECT b.bill_id, c.name, b.base_cost, b.service_cost
FROM bill b
JOIN pays p ON b.bill_id = p.bill_id
JOIN customer c ON p.customer_id = c.customer_id

-- Query to fetch all customers
SELECT customer_id, name, phone, email, address FROM customer;

-- Query to fetch all reservations
SELECT r.bill_id , r.room_no, c.name AS customer_name, r.checkin_date, r.checkout_date
FROM reservation r
JOIN bill b ON r.bill_id = b.bill_id
JOIN pays p ON b.bill_id = p.bill_id
JOIN customer c ON p.customer_id = c.customer_id
ORDER BY r.checkin_date DESC

-- Query to fetch all rooms info
SELECT r.room_no, rtc.room_type, 
CASE 
    WHEN r.room_status = 0 THEN 'Maintenance'
    WHEN NOT EXISTS (
        SELECT *
        FROM reservation
        WHERE reservation.room_no = r.room_no AND
              reservation.checkin_date <= CURDATE() AND
              reservation.checkout_date >= CURDATE()
    ) THEN 'Available'
    ELSE 'Booked'
END AS is_available,
GROUP_CONCAT(DISTINCT s.name ORDER BY s.staff_id ASC SEPARATOR ', ') AS staff_allotted,
IFNULL(c.name, 'N/A') AS guest_name
FROM room r
JOIN room_type_cost rtc ON r.room_type = rtc.room_type
LEFT JOIN allots a ON r.room_no = a.room_no
LEFT JOIN staff s ON a.staff_id = s.staff_id
LEFT JOIN (
    SELECT res.room_no, res.bill_id, c.name
    FROM reservation res
    LEFT JOIN pays p ON res.bill_id = p.bill_id
    LEFT JOIN customer c ON p.customer_id = c.customer_id
    WHERE res.checkin_date <= CURDATE() AND (res.checkout_date >= CURDATE() OR res.checkout_date IS NULL)
) res ON r.room_no = res.room_no
LEFT JOIN pays p ON res.bill_id = p.bill_id
LEFT JOIN customer c ON p.customer_id = c.customer_id
GROUP BY r.room_no, rtc.room_type, r.room_status, c.name;


--Query to fetch all services info
SELECT s.service_id, si.service_name, s.quantity, p.room_no,si.service_cost*s.quantity
FROM service s
JOIN service_info si ON s.service_name = si.service_name
JOIN provides p ON s.service_id = p.service_id;

--Query to fetch all staff info
SELECT staff_id, name, phone, email, position FROM staff;

--Query to get all available rooms
SELECT room.room_no, room.room_type, room_type_cost.price
FROM room
INNER JOIN room_type_cost ON room.room_type = room_type_cost.room_type
WHERE room.room_status AND NOT EXISTS (
    SELECT *
    FROM reservation
    WHERE reservation.room_no = room.room_no AND
          reservation.checkin_date <= CURRENT_DATE() AND
          reservation.checkout_date >= CURRENT_DATE()
);

--Query to fetch all customers
SELECT customer_id,name FROM customer;

--Query to get occupancy status of all rooms
SELECT r.room_no,
       CASE
           WHEN res.checkin_date <= CURRENT_DATE() AND res.checkout_date >= CURRENT_DATE() THEN 0
           ELSE r.room_status+1
       END AS room_status,
       DATEDIFF(res.checkout_date,CURRENT_DATE())
FROM room r
LEFT JOIN (
    SELECT *
    FROM reservation
    WHERE checkin_date <= CURRENT_DATE() AND checkout_date >= CURRENT_DATE()
) res ON r.room_no = res.room_no

--Query to get revenue for each type of room
SELECT room.room_type, SUM(bill.base_cost + bill.service_cost) AS revenue
FROM room
INNER JOIN reservation ON room.room_no = reservation.room_no
INNER JOIN bill ON reservation.bill_id = bill.bill_id
GROUP BY room.room_type

--Query to get room nos.
SELECT room_no FROM room;

--Query to get room types
SELECT room_type FROM room_type_cost;

--Query to get service names
SELECT service_name FROM service_info;

--Trigger to update checkout date and bill base cost when a room is sent under maintenance
CREATE TRIGGER IF NOT EXISTS update_checkout_date_and_bill 
AFTER UPDATE ON room 
FOR EACH ROW 
BEGIN 
    IF NEW.room_status = 0 THEN 
        -- Update checkout date of reservations for the room
        UPDATE reservation 
        SET checkout_date = CURRENT_DATE() 
        WHERE room_no = NEW.room_no 
        AND checkin_date <= CURRENT_DATE() AND checkout_date >= CURRENT_DATE();
    
        -- Update base cost of bills for the reservations of the room
        UPDATE bill b
        SET b.base_cost = (
            SELECT SUM(room_type_cost.price * DATEDIFF(checkout_date, checkin_date))
            FROM reservation
            INNER JOIN room_type_cost ON NEW.room_type = room_type_cost.room_type
            WHERE reservation.bill_id = b.bill_id
                AND reservation.room_no = NEW.room_no
                AND reservation.checkin_date <= CURRENT_DATE()
                AND reservation.checkout_date >= CURRENT_DATE()
        )
        WHERE b.bill_id IN (
            SELECT bill_id FROM reservation WHERE room_no = NEW.room_no AND checkin_date <= CURRENT_DATE() AND checkout_date >= CURRENT_DATE()
        );
        
    END IF; 
END;
