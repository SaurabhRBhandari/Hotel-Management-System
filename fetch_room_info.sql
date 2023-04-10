SELECT 
    r.room_no,
    rtc.room_type,
    CASE 
        WHEN r.room_status = 1 THEN 'Yes'
        ELSE 'No'
    END AS is_avail,
    GROUP_CONCAT(s.name SEPARATOR ', ') AS staff_alloted,
    IFNULL(c.name, 'N/A') AS customer_staying
FROM 
    room r 
    JOIN room_type_cost rtc ON r.room_type = rtc.room_type
    LEFT JOIN allots a ON r.room_no = a.room_no
    LEFT JOIN staff s ON a.staff_id = s.staff_id
    LEFT JOIN (
        SELECT 
            res.room_no, 
            MAX(res.bill_id) AS bill_id, 
            MAX(res.checkin_date) AS checkin_date, 
            MAX(res.checkout_date) AS checkout_date, 
            cus.name AS customer_name
        FROM 
            reservation res
            JOIN pays p ON res.bill_id = p.bill_id
            JOIN customer cus ON p.customer_id = cus.customer_id
        GROUP BY 
            res.room_no, 
            cus.name
    ) rc ON r.room_no = rc.room_no
    LEFT JOIN customer c ON rc.customer_name = c.name
GROUP BY 
    r.room_no, rtc.room_type, is_avail, customer_staying
ORDER BY 
    r.room_no ASC;
