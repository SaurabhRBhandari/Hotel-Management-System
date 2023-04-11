SELECT b.bill_id, c.name, b.base_cost, b.service_cost
FROM bill b
JOIN pays p ON b.bill_id = p.bill_id
JOIN customer c ON p.customer_id = c.customer_id