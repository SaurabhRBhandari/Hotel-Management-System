SELECT room.room_no, room.room_type, room_type_cost.price
FROM room
INNER JOIN room_type_cost ON room.room_type = room_type_cost.room_type
LEFT JOIN reservation ON room.room_no = reservation.room_no
WHERE (reservation.room_no IS NULL OR reservation.checkout_date < CURDATE())
AND room.room_status = True;
