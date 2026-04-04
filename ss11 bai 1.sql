-- Tạo bảng flights
CREATE TABLE flights (
    flight_id SERIAL PRIMARY KEY,
    flight_name VARCHAR(100),
    available_seats INT
);

-- Tạo bảng bookings
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    flight_id INT REFERENCES flights(flight_id),
    customer_name VARCHAR(100)
);

-- Thêm dữ liệu mẫu
INSERT INTO flights (flight_name, available_seats)
VALUES ('VN123', 3), ('VN456', 2);
ROLLBACK;

BEGIN;

-- Giảm số ghế của chuyến bay VN123 đi 1
UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

-- Thêm bản ghi đặt vé cho khách hàng Nguyen Van A
INSERT INTO bookings (flight_id, customer_name)
VALUES (
    (SELECT flight_id FROM flights WHERE flight_name = 'VN123'),
    'Nguyen Van A'
);

COMMIT;

SELECT * FROM flights;
SELECT * FROM bookings;

