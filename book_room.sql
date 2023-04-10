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
