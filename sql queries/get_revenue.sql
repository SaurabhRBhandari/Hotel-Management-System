SELECT room.room_type, SUM(bill.base_cost + bill.service_cost) AS revenue
FROM room
INNER JOIN reservation ON room.room_no = reservation.room_no
INNER JOIN bill ON reservation.bill_id = bill.bill_id
GROUP BY room.room_type