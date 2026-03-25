-- Bảng khách hàng
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    region VARCHAR(50)
);

-- Bảng đơn hàng
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'pending'
);

-- Bảng sản phẩm
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50)
);

-- Bảng chi tiết đơn hàng
CREATE TABLE order_details (
    order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(id),
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id)
);


-- Thêm khách hàng
INSERT INTO customers (full_name, region)
VALUES
('Nguyễn Văn A', 'Hà Nội'),
('Trần Thị B', 'Hồ Chí Minh'),
('Lê Văn C', 'Đà Nẵng');

-- Thêm sản phẩm
INSERT INTO products (name, price, category)
VALUES
('Laptop Dell XPS 13', 25000000, 'Electronics'),
('Điện thoại iPhone 15', 30000000, 'Electronics'),
('Áo sơ mi nam', 500000, 'Fashion'),
('Giày thể thao Adidas', 2000000, 'Fashion');

-- Thêm đơn hàng
INSERT INTO orders (customer_id, total_amount, order_date, status)
VALUES
(1, 30500000, '2026-03-20', 'completed'),
(2, 2000000, '2026-03-21', 'pending'),
(3, 500000, '2026-03-22', 'completed');

-- Thêm chi tiết đơn hàng
INSERT INTO order_details (order_id, product_id, quantity)
VALUES
(1, 1, 1),  -- Laptop Dell XPS 13
(1, 2, 1),  -- iPhone 15
(2, 4, 1),  -- Giày Adidas
(3, 3, 1);  -- Áo sơ mi nam


-- Tạo View tổng hợp doanh thu theo khu vực
CREATE VIEW revenue_by_region AS
SELECT c.region,
       SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.status = 'completed'
GROUP BY c.region;

-- doanh thu cao nhất 
SELECT region, total_revenue
FROM revenue_by_region
ORDER BY total_revenue DESC
LIMIT 3;

--1. Tạo View chi tiết đơn hàng
CREATE VIEW order_status_view AS
SELECT o.id AS order_id,
       o.customer_id,
       o.status,
       o.total_amount,
       o.order_date
FROM orders o
WHERE o.status IN ('pending', 'completed')
WITH CHECK OPTION;

--2. Cập nhật status thông qua View
UPDATE order_status_view
SET status = 'completed'
WHERE order_id = 2;

UPDATE order_status_view
SET status = 'canceled'
WHERE order_id = 2;


--Tạo View phức hợp (Nested View):
CREATE VIEW v_revenue_by_region AS
SELECT c.region,
       SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.status = 'completed'
GROUP BY c.region;

CREATE VIEW v_revenue_above_avg AS
SELECT region, total_revenue
FROM v_revenue_by_region
WHERE total_revenue > (
    SELECT AVG(total_revenue) 
    FROM v_revenue_by_region
);

SELECT region, total_revenue
FROM v_revenue_above_avg
ORDER BY total_revenue DESC
LIMIT 3;




