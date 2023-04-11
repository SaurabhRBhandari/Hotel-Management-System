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
