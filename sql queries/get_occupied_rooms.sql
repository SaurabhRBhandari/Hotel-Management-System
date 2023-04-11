SELECT r.room_no, r.room_status AND
       CASE
           WHEN res.checkin_date <= CURRENT_DATE() AND res.checkout_date >= CURRENT_DATE() THEN 0
           ELSE 1
       END
FROM room r
LEFT JOIN (
    SELECT *
    FROM reservation
    WHERE checkin_date <= CURRENT_DATE() AND checkout_date >= CURRENT_DATE()
) res ON r.room_no = res.room_no;
