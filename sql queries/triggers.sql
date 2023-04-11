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
