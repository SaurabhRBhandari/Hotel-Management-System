SELECT r.bill_id , r.room_no, c.name AS customer_name, r.checkin_date, r.checkout_date
FROM reservation r
JOIN bill b ON r.bill_id = b.bill_id
JOIN pays p ON b.bill_id = p.bill_id
JOIN customer c ON p.customer_id = c.customer_id
ORDER BY r.checkin_date DESC