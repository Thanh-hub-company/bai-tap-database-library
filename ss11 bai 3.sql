-- Bảng sản phẩm
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    stock INT,
    price NUMERIC(10,2)
);

-- Bảng đơn hàng
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    total_amount NUMERIC(10,2),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Bảng chi tiết đơn hàng
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    subtotal NUMERIC(10,2)
);

-- Thêm dữ liệu mẫu
INSERT INTO products (product_name, stock, price)
VALUES ('Laptop', 5, 1500.00),
       ('Phone', 10, 800.00);

	   BEGIN;

-- Kiểm tra tồn kho cho sản phẩm 1
DO $$
DECLARE stock1 INT;
BEGIN
    SELECT stock INTO stock1 FROM products WHERE product_id = 1;
    IF stock1 < 2 THEN
        RAISE EXCEPTION 'Không đủ hàng cho sản phẩm 1';
    END IF;
END $$;

-- Kiểm tra tồn kho cho sản phẩm 2
DO $$
DECLARE stock2 INT;
BEGIN
    SELECT stock INTO stock2 FROM products WHERE product_id = 2;
    IF stock2 < 1 THEN
        RAISE EXCEPTION 'Không đủ hàng cho sản phẩm 2';
    END IF;
END $$;

-- Giảm tồn kho
UPDATE products SET stock = stock - 2 WHERE product_id = 1;
UPDATE products SET stock = stock - 1 WHERE product_id = 2;

-- Tạo đơn hàng
INSERT INTO orders (customer_name, total_amount)
VALUES ('Nguyen Van A', 0)
RETURNING order_id;

-- Giả sử trả về order_id = 1

-- Thêm chi tiết sản phẩm
INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES (1, 1, 2, (SELECT price*2 FROM products WHERE product_id = 1));

INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES (1, 2, 1, (SELECT price FROM products WHERE product_id = 2));

-- Cập nhật tổng tiền đơn hàng
UPDATE orders
SET total_amount = (
    SELECT SUM(subtotal) FROM order_items WHERE order_id = 1
)
WHERE order_id = 1;

COMMIT;

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

