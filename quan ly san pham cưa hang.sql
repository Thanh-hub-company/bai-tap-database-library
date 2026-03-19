CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price INT,
    stock INT,
    manufacturer VARCHAR(50)
);

-- 2. Thêm dữ liệu mẫu (theo đề bài)
INSERT INTO products (name, category, price, stock, manufacturer) VALUES
('Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
('Chuột Logitech M90', 'Phụ kiện', 150000, 50, 'Logitech'),
('Bàn phím cơ Razer', 'Phụ kiện', 2200000, 0, 'Razer'),
('Macbook Air M2', 'Laptop', 32000000, 7, 'Apple'),
('iPhone 14 Pro Max', 'Điện thoại', 35000000, 15, 'Apple'),
('Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
('Tai nghe AirPods 3', 'Phụ kiện', NULL, NULL, 'Apple');

-- 3. Chèn dữ liệu mới: Chuột không dây Logitech M170
INSERT INTO products (name, category, price, stock, manufacturer)
VALUES ('Chuột không dây Logitech M170', 'Phụ kiện', 300000, 20, 'Logitech');

-- 4. Cập nhật: tăng giá tất cả sản phẩm của Apple thêm 10%
UPDATE products
SET price = price * 1.1
WHERE manufacturer = 'Apple';

-- 5. Xóa sản phẩm có stock = 0
DELETE FROM products
WHERE stock = 0;

-- 6. Hiển thị sản phẩm có price BETWEEN 1000000 AND 30000000
SELECT * FROM products
WHERE price BETWEEN 1000000 AND 30000000;

-- 7. Hiển thị sản phẩm có stock IS NULL
SELECT * FROM products
WHERE stock IS NULL;

-- 8. Liệt kê danh sách hãng sản xuất duy nhất
SELECT DISTINCT manufacturer
FROM products;

-- 9. Hiển thị toàn bộ sản phẩm, sắp xếp giảm dần theo giá, sau đó tăng dần theo tên
SELECT * FROM products
ORDER BY price DESC, name ASC;

-- 10. Tìm sản phẩm có tên chứa từ "laptop" (không phân biệt hoa thường)
SELECT * FROM products
WHERE name ILIKE '%laptop%';

-- 11. Lấy về 2 sản phẩm đầu tiên sau khi sắp xếp theo giá giảm dần
SELECT * FROM products
ORDER BY price DESC
LIMIT 2;