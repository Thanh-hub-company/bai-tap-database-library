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

