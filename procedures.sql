CREATE PROCEDURE IF NOT EXISTS new_guest(
    IN p_name VARCHAR(255),
    IN p_phone VARCHAR(20),
    IN p_email VARCHAR(255),
    IN p_address VARCHAR(255)
)
BEGIN
    INSERT INTO customer
    VALUES (NULL, p_name, p_phone, p_email, p_address);
END;

CREATE PROCEDURE IF NOT EXISTS new_staff(
    IN p_name VARCHAR(255),
    IN p_phone VARCHAR(20),
    IN p_email VARCHAR(255),
    IN p_address VARCHAR(255),
    IN p_position VARCHAR(255)
)
BEGIN
    INSERT INTO staff
    VALUES (NULL, p_name, p_phone, p_email, p_address,p_position);
END;

CREATE PROCEDURE IF NOT EXISTS delete_guest (
    IN p_id INT
)
BEGIN
    DELETE FROM customer
    WHERE customer_id = p_id;
END;

CREATE PROCEDURE IF NOT EXISTS update_customer(
    IN id INT, 
    IN name VARCHAR(255), 
    IN phone VARCHAR(20), 
    IN email VARCHAR(255), 
    IN address VARCHAR(255))
BEGIN
    UPDATE customer SET
        name = name,
        phone = phone,
        email = email,
        address = address
    WHERE customer_id = id;
END;

CREATE PROCEDURE IF NOT EXISTS get_customer(
    IN id INT
)
BEGIN
    SELECT * FROM customer
    WHERE customer_id = id;
END;

CREATE PROCEDURE IF NOT EXISTS update_staff(
    IN id INT, 
    IN name VARCHAR(255), 
    IN phone VARCHAR(20), 
    IN email VARCHAR(255), 
    IN position VARCHAR(255))
BEGIN
    UPDATE staff SET
        name = name,
        phone = phone,
        email = email,
        position=position
    WHERE staff_id = id;
END;

CREATE PROCEDURE IF NOT EXISTS delete_staff (
    IN p_id INT
)
BEGIN
    DELETE FROM staff
    WHERE staff_id = p_id;
END;

CREATE PROCEDURE IF NOT EXISTS new_order(
    IN p_room_no INT,
    IN p_service_name VARCHAR(255),
    IN p_quantity INT
)
BEGIN
    INSERT INTO service
    VALUES (NULL, p_service_name, p_quantity);
    INSERT INTO provides
    VALUES (p_room_no, LAST_INSERT_ID());
END;

CREATE PROCEDURE IF NOT EXISTS new_room(
    IN p_room_no INT,
    IN p_room_type VARCHAR(255),
    IN p_room_status BOOLEAN
)
BEGIN
    INSERT INTO room
    VALUES (p_room_no, p_room_type, p_room_status);
END;

CREATE PROCEDURE IF NOT EXISTS set_staff(
    IN p_staff_id INT,
    IN p_room_no INT
)
BEGIN
    INSERT INTO allots
    VALUES (p_staff_id, p_room_no);
END;

CREATE PROCEDURE toggle_status(
    IN p_room_no INT
)
BEGIN
    UPDATE room SET
        room_status = NOT room_status
    WHERE room_no = p_room_no;
END;

