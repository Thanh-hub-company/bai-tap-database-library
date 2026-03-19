-- Tạo bảng products
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

-- Thêm dữ liệu mẫu
INSERT INTO products (name, category, price, stock) VALUES
('Laptop Dell', 'Electronics', 1500.00, 5),
('Chuột Logitech', 'Electronics', 25.50, 50),
('Bàn phím Razer', 'Electronics', 120.00, 20),
('Tủ lạnh LG', 'Home Appliances', 800.00, 3),
('Máy giặt Samsung', 'Home Appliances', 600.00, 2);

-- 1. Thêm sản phẩm mới
INSERT INTO products (name, category, price, stock)
VALUES ('Điều hòa Panasonic', 'Home Appliances', 400.00, 10);

-- 2. Cập nhật stock của 'Laptop Dell' thành 7
UPDATE products
SET stock = 7
WHERE name = 'Laptop Dell';

-- 3. Xóa các sản phẩm có stock bằng 0
DELETE FROM products
WHERE stock = 0;

-- 4. Liệt kê tất cả sản phẩm theo giá tăng dần
SELECT * FROM products
ORDER BY price ASC;

-- 5. Liệt kê danh mục duy nhất của các sản phẩm
SELECT DISTINCT category
FROM products;

-- 6. Liệt kê sản phẩm có giá từ 100 đến 1000
SELECT * FROM products
WHERE price BETWEEN 100 AND 1000;

-- 7. Liệt kê các sản phẩm có tên chứa từ 'LG' hoặc 'Samsung'
SELECT * FROM products
WHERE name ILIKE '%LG%'
   OR name ILIKE '%Samsung%';

-- 8. Hiển thị 2 sản phẩm đầu tiên theo giá giảm dần
SELECT * FROM products
ORDER BY price DESC
LIMIT 2;

-- 9. Lấy sản phẩm thứ 2 đến thứ 3 theo giá giảm dần
SELECT * FROM products
ORDER BY price DESC
LIMIT 2 OFFSET 1;
