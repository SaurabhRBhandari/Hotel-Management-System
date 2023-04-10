SELECT room.room_no, 
       CASE 
           WHEN reservation.room_no IS NULL 
                THEN 1
           WHEN NOW()>=reservation.checkin_date AND NOW()<=reservation.checkout_date 
                THEN 0
           ELSE 1
       END AS availability
FROM room
LEFT JOIN reservation ON room.room_no = reservation.room_no ;
