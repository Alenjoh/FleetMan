-- Database: fleetman

-- DROP DATABASE IF EXISTS fleetman;

CREATE DATABASE fleetman
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


-- Create Employee table
CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    latitude FLOAT,
    longitude FLOAT
);

-- Create Driver table
CREATE TABLE Driver (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL
);

-- Create Vehicle table
CREATE TABLE Vehicle (
    id SERIAL PRIMARY KEY,
    plate_number VARCHAR(20) UNIQUE NOT NULL,
    model VARCHAR(50) NOT NULL,
    capacity INTEGER NOT NULL
);

-- Create Route table
CREATE TABLE Route (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    waypoints JSON NOT NULL
);

-- Create Booking table
CREATE TABLE Booking (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES Employee(id),
    pickup_time TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL
);

-- Create Trip table
CREATE TABLE Trip (
    id SERIAL PRIMARY KEY,
    driver_id INTEGER REFERENCES Driver(id),
    vehicle_id INTEGER REFERENCES Vehicle(id),
    route_id INTEGER REFERENCES Route(id),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    status VARCHAR(20) NOT NULL
);

-- Create BookingTrip table (to associate bookings with trips)
CREATE TABLE BookingTrip (
    booking_id INTEGER REFERENCES Booking(id),
    trip_id INTEGER REFERENCES Trip(id),
    PRIMARY KEY (booking_id, trip_id)
);