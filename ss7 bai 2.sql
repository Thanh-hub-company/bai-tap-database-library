-- Bảng khách hàng
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(100) UNIQUE,
    phone       VARCHAR(15)
);

-- Bảng đơn hàng
CREATE TABLE orders (
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT NOT NULL REFERENCES customer(customer_id),
    total_amount DECIMAL(10,2) NOT NULL,
    order_date   DATE DEFAULT CURRENT_DATE
);

-- Thêm khách hàng
INSERT INTO customer (full_name, email, phone)
VALUES
('Nguyen Van A', 'vana@example.com', '0901234567'),
('Tran Thi B', 'thib@example.com', '0912345678'),
('Le Van C', 'vanc@example.com', '0923456789');

-- Thêm đơn hàng
INSERT INTO orders (customer_id, total_amount, order_date)
VALUES
(1, 250000, '2026-03-20'),
(2, 500000, '2026-03-21'),
(3, 150000, '2026-03-22'),
(1, 300000, '2026-03-23');

DROP VIEW v_order_summary;

CREATE VIEW v_order_summary AS
SELECT c.full_name, o.total_amount, o.order_date
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id;

SELECT * FROM v_order_summary;

CREATE VIEW v_high_value_orders AS
SELECT c.full_name, o.total_amount, o.order_date
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
WHERE o.total_amount >= 1000000;

SELECT * FROM v_high_value_orders;

CREATE OR REPLACE VIEW v_all_orders AS
SELECT o.order_id,
       c.full_name,
       o.total_amount,
       o.order_date
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id;



SELECT * FROM v_high_value_orders;