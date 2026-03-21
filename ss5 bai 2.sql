create table product (
product_id int primary key,
product_name varchar (100),
category varchar (11)
);
insert into product (product_id,product_name,category) values
(1, 'Laptop Dell', 'Electronicts'),
(2, 'iphone 15', 'Electronicts'),
(3, 'Laptop ', 'Electronicts'),
(1, 'Laptop Dell', 'Electronicts'),
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SELECT 
    p.category AS category,
    SUM(o.total_price) AS total_sales,
    SUM(o.quantity) AS total_quantity
FROM product p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 2000
ORDER BY total_sales DESC;


select p.category 
from product p 
join orders o on p.product_id = p.product_id 
group by p.product_id , p.category 
order by sum(o.total_price) DESC 
limit 1

SELECT 
    p.product_name,
    (SELECT SUM(o.total_price) 
     FROM orders o 
     WHERE o.product_id = p.product_id) AS total_revenue
FROM product p
WHERE p.product_id = (
    SELECT product_id
    FROM orders
    GROUP BY product_id
    ORDER BY SUM(total_price) DESC
    LIMIT 1
);



--Tổng doanh thu theo từng nhóm category (JOIN + GROUP BY)--

SELECT 
    p.category,
    SUM(o.total_price) AS total_sales
FROM product p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;

-- Nhóm category chứa sản phẩm có doanh thu cao nhất
SELECT p.category
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.category
ORDER BY SUM(o.total_price) DESC
LIMIT 1



-- Nhóm category có tổng doanh thu > 3000
SELECT p.category
FROM product p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.category
ORDER BY SUM(o.total_price) DESC
LIMIT 1



-- Nhóm category có tổng doanh thu > 3000
SELECT p.category
FROM product p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 3000;


