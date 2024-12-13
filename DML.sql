-- Retrieve all customer information
SELECT * 
FROM Customer;

-- Retrieve flight details for a specific booking 
SELECT f.flightID, f.airline_name, f.dep_airport, f.dep_time, f.arr_airport, f.arr_time
FROM Flight f
JOIN FlightBooking fb ON f.flightID = fb.flightID
WHERE fb.bookingID = 'BOOK000001';

-- Retrieve booking details for a specific customer
SELECT b.bookingID, b.booking_date, b.status, t.tour_name, t.start_date, t.end_date, t.tour_price
FROM Booking b
JOIN Tour t ON b.tourID = t.tourID
WHERE b.customerID = 'CUST000001';

-- Retrieve destinations for a specific tour 
SELECT d.dest_name, d.country, d.address, d.dest_desc
FROM TourDest td
JOIN Destination d ON td.destID = d.destID
WHERE td.tourID = 'TOUR000001';

-- Retrieve bookings for a specific tour 
SELECT b.bookingID, c.customer_fname, c.customer_lname, b.status, b.booking_date
FROM Booking b
JOIN Customer c ON b.customerID = c.customerID
WHERE b.tourID = 'TOUR000003';

-- Retrieve upcoming tours with start dates greater than the current system date
SELECT tourID, tour_name, start_date, end_date, tour_price, tour_desc
FROM Tour
WHERE start_date > SYSDATE();

-- Add a new booking for a customer to a tour, assigned to a staff member
INSERT INTO Booking 
VALUES ('BOOK000003', 'CUST000003', '2024-12-25', 'Pending', 'TOUR000003', 'STAFF00002');

-- Add flight booking details for the newly created booking 
INSERT INTO FlightBooking 
VALUES ('BOOK000003', 'FLIGHT0003', 2, 'Economy');

-- Update the status of a booking 
UPDATE Booking
SET status = 'Confirmed'
WHERE bookingID = 'BOOK000002';

-- Add a new staff member to the database
INSERT INTO Staff VALUES
('STAFF00003', 'Darren', 'Muljono', 'darren.muljono@binusantara.org', '082425677781', 'M', 250000000);

-- Update the salary of an existing staff member 
UPDATE Staff
SET staff_salary = '350000000'
WHERE staffID = 'STAFF00001';

-- Retrieve all staff details
SELECT * 
FROM Staff;

-- Delete a specific booking from the database
DELETE FROM Booking 
WHERE bookingID = 'BOOK000002';

-- Delete a tour from the database
DELETE FROM Tour
WHERE tourID = 'TOUR000004';
