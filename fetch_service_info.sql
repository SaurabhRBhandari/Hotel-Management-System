SELECT s.service_id, si.service_name, s.quantity, p.room_no,si.service_cost*s.quantity
FROM service s
JOIN service_info si ON s.service_name = si.service_name
JOIN provides p ON s.service_id = p.service_id;