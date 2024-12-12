DROP DATABASE IF EXISTS Binusantara;
CREATE DATABASE Binusantara;
USE Binusantara;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

CREATE TABLE Customer(
	customerID			CHAR(10)		PRIMARY KEY,
    `customer_fname`	VARCHAR(255)	NOT NULL,
    `customer_lname`	VARCHAR(255)	NOT NULL,
    `customer_email`	VARCHAR(255)	NOT NULL,
	`customer_phoneNo`	VARCHAR(255)	NOT NULL,
    `customer_sex`		CHAR(1)			NOT NULL,
    `customer_DOB`		DATE			NOT NULL,
    `customer_ppNo`		VARCHAR(255)	NOT NULL,
    
	CHECK(`customer_sex` LIKE 'M' OR `customer_sex` LIKE 'F'),
    CHECK(`customer_email` LIKE '%@%')
);

CREATE TABLE Staff(
	staffID 			CHAR(10) 		PRIMARY KEY,
    `staff_fname` 		VARCHAR(255)	NOT NULL,
    `staff_lname` 		VARCHAR(255)	NOT NULL,
    `staff_email`		VARCHAR(255)	NOT NULL,
    `staff_phoneNo`		VARCHAR(255)	NOT NULL,
    `staff_sex`			CHAR(1)			NOT NULL,
    `staff_salary`		INT				NOT NULL,
    
    CHECK(`staff_sex` LIKE 'M' OR `staff_sex` LIKE 'F'),
    CHECK(`staff_email` LIKE '%@binusantara.org')
);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
CREATE TABLE Tour(
	tourID				CHAR(10)		PRIMARY KEY,
    `tour_name`			VARCHAR(255)	NOT NULL,
    `start_date`		DATE 			NOT NULL,
    `end_date`			DATE 			NOT NULL,
    `tour_price`		INT				NOT NULL,
    `tour_desc`			VARCHAR(1000)	,
    
    CHECK(`start_date` > SYSDATE() AND `end_date` > SYSDATE())
);

CREATE TABLE Destination(
	destID				CHAR(10)		PRIMARY KEY,
    `dest_name`			VARCHAR(255)	NOT NULL,
    `country`			VARCHAR(255)	NOT NULL,
    `address`			VARCHAR(255)	NOT NULL,
    `dest_desc`			VARCHAR(255)	
);

CREATE TABLE TourDest(
	tourID				CHAR(10)		NOT NULL,
    destID				CHAR(10)		NOT NULL,
    
    PRIMARY KEY (tourID, destID)
);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

CREATE TABLE Flight(
	flightID			CHAR(10)		PRIMARY KEY,
    `airline_name`		VARCHAR(255)	NOT NULL,
    `dep_airport`		VARCHAR(255)	NOT NULL,
    `dep_time`			TIME			NOT NULL,
    `arr_airport`		VARCHAR(255)	NOT NULL,
    `arr_time`			TIME			NOT NULL
);

CREATE TABLE Booking(
	bookingID			CHAR(10)		PRIMARY KEY,
    customerID			CHAR(10)		NOT NULL,
    `booking_date`		DATE			NOT NULL,
    `status`			VARCHAR(255)	NOT NULL,
    tourID				CHAR(10)		NOT NULL,
    staffID				CHAR(10)		,
    
    FOREIGN KEY (customerID) 	REFERENCES Customer(customerID),
    FOREIGN KEY (tourID) 		REFERENCES Tour(tourID),
    FOREIGN KEY (staffID)		REFERENCES Staff(staffID),
    
    CHECK(`booking_date` > SYSDATE())
);

CREATE TABLE FlightBooking(
    bookingID			CHAR(10)		NOT NULL,
    flightID			CHAR(10)		,
    `seats`				INT				NOT NULL,
    `class`				VARCHAR(255)	NOT NULL,
     
    PRIMARY KEY (bookingID, flightID),
    CHECK (`seats` BETWEEN 1 AND 20),
    CHECK (`class` LIKE 'Economy' OR `class` LIKE 'Business' OR `class` LIKE 'First')
);

-- Sample data

-- CUSTOMER table
INSERT INTO Customer VALUES
    ('CUST000001', 'Jackie', 'Robinson', 'jackie.42@example.com', '1234567890', 'M', '1990-01-15', 'PP123456'),
    ('CUST000002', 'Magic', 'Johnson', 'magic.32@example.com', '2345678901', 'M', '1959-07-20', 'PP654321');

-- STAFF table
INSERT INTO Staff VALUES
('STAFF00001', 'Alex', 'Myfia', 'legs@binusantara.org', '082112345678', 'M', 300000000),
('STAFF00002', 'Rafael', 'Christianto', 'rafael.christianto@binusantara.org', '082298765432', 'M', 270000000);

-- TOUR table
INSERT INTO Tour VALUES
('TOUR000001', 'France', '2025-01-15', '2025-01-21', 25000000, '6-day tour of France and its most famous landmarks'),
('TOUR000002', 'Greece', '2025-03-01', '2025-03-07', 20000000, '6-day guided tour through Greece and the its wonders.'),
('TOUR000003', 'America', '2025-03-01', '2025-03-07', 30000000, '6-day guided tour of America and all it can offer.'),
('TOUR000004', 'Egypt', '2025-03-01', '2025-03-07', 15000000, '6-day guided tour through Egpyt filled with adventure.');

-- DESTINATION table
INSERT INTO Destination VALUES
('FR00000001', 'Eiffel Tower', 'France', 'Champ de Mars, 5 Avenue Anatole France, Paris', 'Iconic iron lattice tower and global symbol of France.'),
('FR00000002', 'Louvre Museum', 'France', 'Rue de Rivoli, Paris', 'World-renowned art museum home to the Mona Lisa.'),
('FR00000003', 'Arc de Triomphe', 'France', 'Place Charles de Gaulle, Paris', 'Triumphal arch honoring those who fought for France.'),
('FR00000004', 'Notre Dame Cathedral', 'France', '6 Parvis Notre-Dame, Place Jean-Paul II, Paris', 'Gothic cathedral famous for its architecture and history.'),
('FR00000005', 'Mont-Saint-Michel Abbey', 'France', 'Mont-Saint-Michel, Normandy', 'Medieval abbey on a tidal island in Normandy.'),
('FR00000006', 'Mont Blanc', 'France', 'Alps, Chamonix-Mont-Blanc', 'Tallest mountain in the Alps and popular hiking destination.'),

('GR00000001', 'Santorini', 'Greece', 'Santorini Island, Cyclades', 'Famous for whitewashed houses and stunning sunsets.'),
('GR00000002', 'Acropolis of Athens', 'Greece', 'Athens, Greece', 'Ancient citadel with historical ruins and temples.'),
('GR00000003', 'Acropolis Museum', 'Greece', 'Dionysiou Areopagitou Street, Athens', 'Modern museum housing artifacts from the Acropolis.'),
('GR00000004', 'Elafonissi Beach', 'Greece', 'Elafonissi, Crete', 'Pink-sand beach with crystal-clear waters.'),
('GR00000005', 'Parthenon', 'Greece', 'Acropolis, Athens', 'Ancient temple dedicated to the goddess Athena.'),
('GR00000006', 'Mount Lycabettus', 'Greece', 'Athens, Greece', 'Limestone hill offering panoramic views of Athens.'),

('US00000001', 'Times Square', 'America', 'Manhattan, New York City', 'Vibrant commercial and entertainment hub.'),
('US00000002', 'Statue of Liberty', 'America', 'Liberty Island, New York City', 'Colossal statue symbolizing freedom and democracy.'),
('US00000003', 'Mount Rushmore', 'America', 'Black Hills, South Dakota', 'Granite sculpture featuring U.S. presidents.'),
('US00000004', 'Grand Canyon', 'America', 'Arizona, USA', 'Massive canyon carved by the Colorado River.'),
('US00000005', 'Golden Gate Bridge', 'America', 'San Francisco, California', 'Famous suspension bridge spanning the Golden Gate Strait.'),
('US00000006', 'Hoover Dam', 'America', 'Nevada-Arizona Border', 'Concrete dam on the Colorado River generating hydroelectric power.'),

('EG00000001', 'Pyramids of Giza', 'Egypt', 'Giza, Cairo', 'Ancient wonders of the world and pharaohs’ tombs.'),
('EG00000002', 'Egyptian Museum', 'Egypt', 'Tahrir Square, Cairo', 'Museum housing extensive ancient Egyptian artifacts.'),
('EG00000003', 'Citadel of Saladin', 'Egypt', 'Al-Qalaa, Cairo', 'Medieval Islamic fortification overlooking Cairo.'),
('EG00000004', 'Valley of the Kings', 'Egypt', 'Luxor, Egypt', 'Burial ground of pharaohs with elaborately decorated tombs.'),
('EG00000005', 'Khan el Khalili', 'Egypt', 'Islamic Cairo, Egypt', 'Famous bazaar for traditional crafts and souvenirs.'),
('EG00000006', 'The Nile River', 'Egypt', 'Runs through Egypt', 'Longest river in the world, vital to Egyptian civilization.');

-- TOURDEST table
INSERT INTO TourDest VALUES
('TOUR000001', 'FR00000001'),
('TOUR000001', 'FR00000002'),
('TOUR000001', 'FR00000003'),
('TOUR000001', 'FR00000004'),
('TOUR000001', 'FR00000005'),
('TOUR000001', 'FR00000006'),

('TOUR000002', 'GR00000001'),
('TOUR000002', 'GR00000002'),
('TOUR000002', 'GR00000003'),
('TOUR000002', 'GR00000004'),
('TOUR000002', 'GR00000005'),
('TOUR000002', 'GR00000006'),

('TOUR000003', 'US00000001'),
('TOUR000003', 'US00000002'),
('TOUR000003', 'US00000003'),
('TOUR000003', 'US00000004'),
('TOUR000003', 'US00000005'),
('TOUR000003', 'US00000006'),

('TOUR000004', 'EG00000001'),
('TOUR000004', 'EG00000002'),
('TOUR000004', 'EG00000003'),
('TOUR000004', 'EG00000004'),
('TOUR000004', 'EG00000005'),
('TOUR000004', 'EG00000006');

-- FLIGHT table
INSERT INTO Flight VALUES
('FLIGHT0001', 'Garuda Indonesia', 'Soekarno-Hatta International Airport', '01:00:00', 'Charles de Gaulle Airport', '20:45:00'),
('FLIGHT0002', 'Garuda Indonesia', 'Soekarno-Hatta International Airport', '12:00:00', 'Athens International Airport', '06:35:00'),
('FLIGHT0003', 'Garuda Indonesia', 'Soekarno-Hatta International Airport', '17:00:00', 'John F. Kennedy International Airport', '11:50:00'),
('FLIGHT0004', 'Garuda Indonesia', 'Soekarno-Hatta International Airport', '09:00:00', 'Cairo International Airport', '19:40:00'),

('FLIGHT0011', 'Air France', 'Charles de Gaulle Airport', '12:00:00', 'Soekarno-Hatta International Airport', '05:45:00'),
('FLIGHT0012', 'Aegean Airlines', 'Athens International Airport', '08:00:00', 'Soekarno-Hatta International Airport', '02:35:00'),
('FLIGHT0013', 'United Airlines', 'John F. Kennedy International Airport', '20:00:00', 'Soekarno-Hatta International Airport', '14:50:00'),
('FLIGHT0014', 'EgyptAir', 'Cairo International Airport', '10:00:00', 'Soekarno-Hatta International Airport', '20:40:00');

-- BOOKING table
INSERT INTO Booking VALUES
('BOOK000001', 'CUST000001', '2024-12-24', 'Confirmed', 'TOUR000001', 'STAFF00001'),
('BOOK000002', 'CUST000002', '2024-12-24', 'Pending', 'TOUR000002', 'STAFF00002');

-- FLIGHTBOOKING table
INSERT INTO FlightBooking VALUES
('BOOK000001', 'FLIGHT0001', 2, 'Economy'),
('BOOK000001', 'FLIGHT0011', 1, 'Business'),

('BOOK000002', 'FLIGHT0002', 2, 'Economy'),
('BOOK000002', 'FLIGHT0012', 1, 'Business');
