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