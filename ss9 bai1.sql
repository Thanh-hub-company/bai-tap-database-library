-- Tạo bảng Orders
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC(10,2) NOT NULL
);

-- Thêm dữ liệu mẫu
INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES
(101, '2024-01-10', 250.00),
(102, '2024-01-11', 300.00),
(103, '2024-01-12', 150.00),
(101, '2024-01-13', 400.00),
(104, '2024-01-14', 500.00),
(102, '2024-01-15', 200.00);

EXPLAIN ANALYZE
SELECT * FROM Orders WHERE customer_id = 101;


CREATE INDEX idx_orders_customer_id
ON Orders(customer_id);

EXPLAIN ANALYZE
SELECT * FROM Orders WHERE customer_id = 101;
