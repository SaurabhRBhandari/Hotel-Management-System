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
