CREATE PROCEDURE IF NOT EXISTS book_rooms(
    IN customer_id INT, 
    IN room_nos VARCHAR(255), 
    IN checkin_date DATE, 
    IN checkout_date DATE
)
BEGIN
    -- Create a new bill for the customer
    INSERT INTO bill (base_cost, service_cost) VALUES (0, 0);
    SET @bill_id = LAST_INSERT_ID();

    -- Insert a new record in the pays table to link the customer and bill
    INSERT INTO pays (customer_id, bill_id) VALUES (customer_id, @bill_id);

    -- Split the room numbers string into a temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_room_nos;
    CREATE TEMPORARY TABLE temp_room_nos (room_no INT);
    SET @query = CONCAT("INSERT INTO temp_room_nos (room_no) VALUES ", room_nos, ";");
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Book each room in the temporary table
    WHILE EXISTS(SELECT * FROM temp_room_nos) DO
        -- Get the first available room of the desired type
        SELECT room.room_no INTO @room_no
        FROM room
        INNER JOIN room_type_cost ON room.room_type = room_type_cost.room_type
        WHERE room.room_no IN (SELECT room_no FROM temp_room_nos)
        AND NOT EXISTS (
            SELECT 1
            FROM reservation
            WHERE reservation.room_no = room.room_no
            AND reservation.checkin_date <= checkout_date
            AND reservation.checkout_date >= checkin_date
        )
        ORDER BY room_type_cost.price ASC
        LIMIT 1;

        -- Book the room by inserting a record into the reservation table
        INSERT INTO reservation (room_no, bill_id, checkin_date, checkout_date)
        VALUES (@room_no, @bill_id, checkin_date, checkout_date);

        -- Remove the booked room from the temporary table
        DELETE FROM temp_room_nos WHERE room_no = @room_no;
    END WHILE;

    -- Update the base cost of the bill to reflect the total room cost
    UPDATE bill
    SET base_cost = (
        SELECT SUM(room_type_cost.price * DATEDIFF(checkout_date, checkin_date))
        FROM reservation
        INNER JOIN room ON reservation.room_no = room.room_no
        INNER JOIN room_type_cost ON room.room_type = room_type_cost.room_type
        WHERE reservation.bill_id = @bill_id
    )
    WHERE bill_id = @bill_id;
END;


CREATE PROCEDURE IF NOT EXISTS delete_reservation(IN booking_id INT, IN room_no INT)
BEGIN
    DECLARE reservation_cost INT;
    DECLARE checkin_date DATE;
    DECLARE checkout_date DATE;
    SELECT price INTO reservation_cost FROM room_type_cost WHERE room_type = (SELECT room_type FROM room r WHERE r.room_no = room_no);
    SELECT r.checkin_date,r.checkout_date INTO checkin_date,checkout_date FROM reservation r WHERE r.bill_id = booking_id AND r.room_no = room_no;
    DELETE FROM reservation r WHERE r.bill_id = booking_id AND r.room_no = room_no;
    UPDATE bill b SET base_cost = base_cost - reservation_cost*(DATEDIFF(checkout_date,checkin_date)) WHERE b.bill_id = bill_id;
END ;

CREATE PROCEDURE IF NOT EXISTS generate_bill(
    IN bill_id INT
)
BEGIN
    SELECT c.name, c.email, b.base_cost, b.service_cost, r.checkin_date, r.checkout_date, COUNT(DISTINCT r.room_no) AS num_rooms
    FROM pays p
    JOIN customer c ON p.customer_id = c.customer_id
    JOIN bill b ON p.bill_id = b.bill_id
    JOIN reservation r ON p.bill_id = r.bill_id
    WHERE p.bill_id = bill_id
    GROUP BY c.name, c.email, b.base_cost, b.service_cost, r.checkin_date, r.checkout_date;
END;