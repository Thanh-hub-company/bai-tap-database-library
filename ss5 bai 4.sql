-- Bảng khách hàng
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Nguyễn Văn A', 'Hà Nội'),
(2, 'Trần Thị B', 'Đà Nẵng'),
(3, 'Lê Văn C', 'Hồ Chí Minh'),
(4, 'Phạm Thị D', 'Hà Nội');


-- Bảng đơn hàng
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE NOT NULL,
    total_price NUMERIC(12,2) NOT NULL
);

INSERT INTO orders (order_id, customer_id, order_date, total_price) VALUES
(101, 1, '2024-12-20', 3000),
(102, 2, '2025-01-05', 1500),
(103, 1, '2025-02-10', 2500),
(104, 3, '2025-02-15', 4000),
(105, 4, '2025-03-01', 800);


-- Bảng chi tiết đơn hàng
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price NUMERIC(12,2) NOT NULL
);
--hien thi tat ca don hang--
INSERT INTO order_items (item_id, order_id, product_id, quantity, price) VALUES
(1, 101, 1, 2, 1500),
(2, 102, 2, 1, 1500),
(3, 103, 3, 5, 500),
(4, 104, 2, 4, 1000);

SELECT c.customer_name AS customer_name,
       o.order_date AS order_date,
       o.total_price AS total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

--thong tin tong hop--
SELECT SUM(total_price) AS total_revenue,
       AVG(total_price) AS avg_order_value,
       MAX(total_price) AS max_order_value,
       MIN(total_price) AS min_order_value,
       COUNT(order_id) AS order_count
FROM orders;

--having  tổng doanh thu theo thành phố--
SELECT c.city,
       SUM(o.total_price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_price) > 10000;

--join kiệt kê sản phẩm đã bán--
SELECT c.customer_name,
       c.city,
       o.order_date,
       oi.product_id,
       oi.quantity,
       oi.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id;


--khach hang co tong doanh thu cao nhat--
SELECT customer_name
FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    ORDER BY SUM(total_price) DESC
    LIMIT 1
);
--thanh  pho có khach hang hoặc dơn hàng--
SELECT city FROM customers
UNION
SELECT city FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

--thanh pho vừa khách hàng vừa đơn hàng
SELECT city FROM customers
INTERSECT
SELECT city FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
