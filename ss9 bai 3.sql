CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    category_id INT NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Thêm dữ liệu mẫu vào bảng Products
INSERT INTO Products (category_id, price, stock_quantity)
VALUES
(1, 100.00, 50),   -- Sản phẩm thuộc danh mục 1
(1, 150.00, 30),
(1, 200.00, 20),
(2, 80.00, 100),   -- Sản phẩm thuộc danh mục 2
(2, 120.00, 60),
(2, 90.00, 40),
(3, 300.00, 10),   -- Sản phẩm thuộc danh mục 3
(3, 250.00, 15),
(3, 400.00, 5),
(4, 50.00, 200),   -- Sản phẩm thuộc danh mục 4
(4, 70.00, 150),
(4, 60.00, 180);



CREATE CLUSTERED INDEX idx_products_category
ON Products(category_id);

CREATE NONCLUSTERED INDEX idx_products_price
ON Products(price);

-- truy  van toi ưu --
SELECT * 
FROM Products 
WHERE category_id = 4
ORDER BY price;

