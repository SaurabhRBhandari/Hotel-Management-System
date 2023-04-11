INSERT INTO customer (name, phone, email, address)
VALUES
    ('John Smith', '555-1234', 'jsmith@example.com', '123 Main St, Anytown, USA'),
    ('Jane Doe', '555-5678', 'jdoe@example.com', '456 Elm St, Anytown, USA'),
    ('Bob Johnson', '555-9012', 'bjohnson@example.com', '789 Oak St, Anytown, USA'),
    ('Mary Smith', '555-3456', 'msmith@example.com', '321 Maple Ave, Anytown, USA'),
    ('Mike Jones', '555-7890', 'mjones@example.com', '654 Cedar St, Anytown, USA'),
    ('Sue Wilson', '555-2345', 'swilson@example.com', '987 Pine St, Anytown, USA'),
    ('Tom Brown', '555-6789', 'tbrown@example.com', '246 Oak St, Anytown, USA'),
    ('Lisa Davis', '555-0123', 'ldavis@example.com', '135 Maple Ave, Anytown, USA'),
    ('David Lee', '555-4567', 'dlee@example.com', '864 Cedar St, Anytown, USA'),
    ('Karen Miller', '555-8901', 'kmiller@example.com', '753 Pine St, Anytown, USA'),
    ('Kevin White', '555-2345', 'kwhite@example.com', '951 Oak St, Anytown, USA'),
    ('Amy Taylor', '555-6789', 'ataylor@example.com', '357 Maple Ave, Anytown, USA'),
    ('Erica Brown', '555-0123', 'ebrown@example.com', '468 Cedar St, Anytown, USA'),
    ('Mark Davis', '555-4567', 'mdavis@example.com', '579 Pine St, Anytown, USA'),
    ('Laura Lee', '555-8901', 'llee@example.com', '690 Oak St, Anytown, USA'),
    ('Scott Miller', '555-2345', 'smiller@example.com', '802 Maple Ave, Anytown, USA'),
    ('Jenny White', '555-6789', 'jwhite@example.com', '913 Cedar St, Anytown, USA'),
    ('Peter Taylor', '555-0123', 'ptaylor@example.com', '124 Pine St, Anytown, USA'),
    ('Michelle Brown', '555-4567', 'mbrown@example.com', '235 Oak St, Anytown, USA'),
    ('Brian Davis', '555-8901', 'bdavis@example.com', '346 Maple Ave, Anytown, USA'),
    ('Kelly Lee', '555-2345', 'klee@example.com', '457 Cedar St, Anytown, USA'),
    ('Timothy Miller', '555-6789', 'tmiller@example.com', '568 Pine St, Anytown, USA'),
    ('Nancy White', '555-0123', 'nwhite@example.com', '679 Oak St, Anytown, USA'),
    ('Andrew Taylor', '555-4567', 'ataylor2@example.com', '790 Maple Ave, Anytown, USA'),
    ('Melissa Brown', '555-8901', 'mbrown2@example.com', '901 Cedar St, Anytown, USA'),
    ('Anthony Davis', '555-2345', 'adavis@example.com', '012 Pine St, Anytown, USA'),
    ('Sneha Sharma', '011-23456789', 'sneha.sharma@example.com', '21/6, Ashok Nagar, New Delhi, Delhi'),
    ('Rahul Singh', '022-34567890', 'rahul.singh@example.com', '28, Hill Road, Bandra West, Mumbai, Maharashtra'),
    ('Manish Gupta', '033-45678901', 'manish.gupta@example.com', '15, Park Street, Kolkata, West Bengal'),
    ('Rashmi Patel', '044-56789012', 'rashmi.patel@example.com', '49, Velachery Road, Chennai, Tamil Nadu'),
    ('Nikhil Shah', '080-67890123', 'nikhil.shah@example.com', '14, MG Road, Bangalore, Karnataka'),
    ('Priya Agarwal', '040-78901234', 'priya.agarwal@example.com', '7-1-618/2, Shanthi Nagar, Hyderabad, Telangana'),
    ('Rohit Verma', '022-90123456', 'rohit.verma@example.com', '3, SV Road, Andheri West, Mumbai, Maharashtra'),
    ('Neha Jain', '011-34567890', 'neha.jain@example.com', '22, Connaught Place, New Delhi, Delhi'),
    ('Sagarika Das', '033-45678901', 'sagarika.das@example.com', '8, Camac Street, Kolkata, West Bengal'),
    ('Rajesh Kumar', '044-56789012', 'rajesh.kumar@example.com', '17, Anna Salai, Chennai, Tamil Nadu'),
    ('Alok Singh', '080-67890123', 'alok.singh@example.com', '39, Brigade Road, Bangalore, Karnataka'),
    ('Ankita Sharma', '040-78901234', 'ankita.sharma@example.com', '10-1-47, Begumpet, Hyderabad, Telangana'),
    ('Gaurav Patel', '022-90123456', 'gaurav.patel@example.com', '41, Linking Road, Bandra West, Mumbai, Maharashtra'),
    ('Kiran Gupta', '011-23456789', 'kiran.gupta@example.com', '56, Janpath, New Delhi, Delhi'),
    ('Sudip Chakraborty', '033-45678901', 'sudip.chakraborty@example.com', '12, Shakespeare Sarani, Kolkata, West Bengal'),
    ('Shruti Desai', '044-56789012', 'shruti.desai@example.com', '23, Cathedral Road, Chennai, Tamil Nadu'),
    ('Amitabh Srivastava', '080-67890123', 'amitabh.srivastava@example.com', '10, MG Road, Bangalore, Karnataka'),
    ('Deepak Kumar', '040-78901234', 'deepak.kumar@example.com', '5-9-22, Secretariat Road, Hyderabad, Telangana'),
    ('Sanjana Gupta', '022-90123456', 'sanjana.gupta@example.com', '6, Hill Road, Bandra West, Mumbai, Maharashtra'),
    ('Siddharth Sharma', '011-34567890', 'siddharth.sharma@example.com', '18, Rajpath, New Delhi, Delhi');
INSERT INTO room_type_cost (room_type, price)
VALUES
    ('Single Room', 2500),
    ('Double Room', 3500),
    ('Twin Room', 3500),
    ('Triple Room', 4500),
    ('Family Room', 6000),
    ('Suite', 8000);
INSERT INTO staff (name, phone, email, address, position)
VALUES 
    ('Aarav Gupta', '555-1234', 'aarav.gupta@hotel.com', '123 Main St, Anytown, USA', 'Hotel Manager'),
    ('Aditi Shah', '555-5678', 'aditi.shah@hotel.com', '456 Elm St, Anytown, USA', 'Assistant Manager'),
    ('Anjali Singh', '555-9876', 'anjali.singh@hotel.com', '789 Oak St, Anytown, USA', 'Front Desk Clerk'),
    ('Arnav Patel', '555-4321', 'arnav.patel@hotel.com', '321 Elm St, Anytown, USA', 'Housekeeping Supervisor'),
    ('Aryan Sharma', '555-8765', 'aryan.sharma@hotel.com', '654 Oak St, Anytown, USA', 'Bellhop'),
    ('Diya Singh', '555-2345', 'diya.singh@hotel.com', '345 Main St, Anytown, USA', 'Restaurant Manager'),
    ('Ishaan Gupta', '555-6789', 'ishaan.gupta@hotel.com', '678 Elm St, Anytown, USA', 'Waiter'),
    ('Kavya Patel', '555-5432', 'kavya.patel@hotel.com', '432 Oak St, Anytown, USA', 'Housekeeper'),
    ('Manav Kumar', '555-9876', 'manav.kumar@hotel.com', '876 Main St, Anytown, USA', 'Maintenance'),
    ('Neha Shah', '555-3456', 'neha.shah@hotel.com', '567 Elm St, Anytown, USA', 'Concierge'),
    ('Pranav Singh', '555-7890', 'pranav.singh@hotel.com', '890 Oak St, Anytown, USA', 'Front Desk Clerk'),
    ('Riya Gupta', '555-2345', 'riya.gupta@hotel.com', '345 Main St, Anytown, USA', 'Housekeeping'),
    ('Rohan Patel', '555-6789', 'rohan.patel@hotel.com', '678 Elm St, Anytown, USA', 'Room Service'),
    ('Sahil Sharma', '555-5432', 'sahil.sharma@hotel.com', '432 Oak St, Anytown, USA', 'Security'),
    ('Tanya Kumar', '555-9876', 'tanya.kumar@hotel.com', '876 Main St, Anytown, USA', 'Sales Manager');

INSERT INTO service_info (service_name, service_cost) 
VALUES 
('Room Service', 500), 
('Laundry Service', 300), 
('In-room Dining', 800), 
('Concierge Service', 600), 
('Housekeeping Service', 400), 
('Airport Transfer', 1500), 
('Spa Service', 2000), 
('Fitness Center Access', 250), 
('Business Center Services', 800), 
('Pool Access', 500);

INSERT INTO room (room_no, room_type, room_status)
VALUES
(101, 'Single Room', true),
(102, 'Double Room', true),
(103, 'Twin Room', true),
(104, 'Triple Room', true),
(105, 'Family Room', true),
(106, 'Suite', true),
(201, 'Single Room', true),
(202, 'Double Room', true),
(203, 'Twin Room', true),
(204, 'Triple Room', true),
(205, 'Family Room', true),
(206, 'Suite', true),
(301, 'Single Room', true),
(302, 'Double Room', true),
(303, 'Twin Room', true),
(304, 'Triple Room', true),
(305, 'Family Room', true),
(306, 'Suite', true),
(401, 'Single Room', true),
(402, 'Double Room', true),
(403, 'Twin Room', true),
(404, 'Triple Room', true),
(405, 'Family Room', true),
(406, 'Suite', true),
(501, 'Single Room', true),
(502, 'Double Room', true),
(503, 'Twin Room', true),
(504, 'Triple Room', true),
(505, 'Family Room', true),
(506, 'Suite', true),
(601, 'Single Room', true),
(602, 'Double Room', true),
(603, 'Twin Room', true),
(604, 'Triple Room', true),
(605, 'Family Room', true),
(606, 'Suite', true),
(701, 'Single Room', true),
(702, 'Double Room', true),
(703, 'Twin Room', true),
(704, 'Triple Room', true),
(705, 'Family Room', true),
(706, 'Suite', true),
(801, 'Single Room', true),
(802, 'Double Room', true),
(803, 'Twin Room', true),
(804, 'Triple Room', true),
(805, 'Family Room', true),
(806, 'Suite', true),
(901, 'Single Room', true),
(902, 'Double Room', true),
(903, 'Twin Room', true),
(904, 'Triple Room', true),
(905, 'Family Room', true),
(906, 'Suite', true);


CALL book_rooms(1, '(101),(102)', '2023-04-01', '2023-04-05');
CALL book_rooms(2, '(103),(104)', '2023-04-06', '2023-04-11');
CALL book_rooms(3, '(105),(106)', '2023-04-12', '2023-04-18');
CALL book_rooms(4, '(201),(202)', '2023-04-04', '2023-04-11');
CALL book_rooms(5, '(203),(204)', '2023-04-13', '2023-04-20');
CALL book_rooms(6, '(205),(206)', '2023-04-21', '2023-04-28');
CALL book_rooms(7, '(301),(302)', '2023-04-07', '2023-04-17');
CALL book_rooms(8, '(303),(304)', '2023-04-18', '2023-04-28');
CALL book_rooms(9, '(305),(306)', '2023-04-29', '2023-05-09');
CALL book_rooms(10, '(401),(402)', '2023-04-10', '2023-04-23');
CALL book_rooms(11, '(403),(404)', '2023-04-24', '2023-05-06');
CALL book_rooms(12, '(405),(406)', '2023-05-07', '2023-05-19');
CALL book_rooms(13, '(501),(502)', '2023-04-13', '2023-04-29');
CALL book_rooms(14, '(503),(504)', '2023-04-30', '2023-05-16');
CALL book_rooms(15, '(505),(506)', '2023-05-17', '2023-06-02');



CALL new_order(101, 'Room Service', 1);
CALL new_order(102, 'Laundry Service', 2);
CALL new_order(103, 'In-room Dining', 3);
CALL new_order(104, 'Concierge Service', 4);
CALL new_order(105, 'Housekeeping Service', 5);
CALL new_order(101, 'Airport Transfer', 1);
CALL new_order(102, 'Spa Service', 2);
CALL new_order(103, 'Fitness Center Access', 3);
CALL new_order(104, 'Business Center Services', 4);
CALL new_order(105, 'Pool Access', 5);
CALL new_order(106, 'Room Service', 2);
CALL new_order(101, 'Laundry Service', 1);
CALL new_order(102, 'In-room Dining', 3);
CALL new_order(103, 'Housekeeping Service', 5);
CALL new_order(104, 'Airport Transfer', 2);
