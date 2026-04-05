-- 1. Tạo bảng products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    price      NUMERIC NOT NULL CHECK (price > 0),
    stock      INT NOT NULL CHECK (stock >= 0)
);

-- 2. Tạo bảng sales (nếu cần)
CREATE TABLE sales (
    sale_id    SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products(product_id)
                ON DELETE CASCADE,
    quantity   INT NOT NULL CHECK (quantity > 0)
);

-- 3. Tạo bảng orders
CREATE TABLE orders (
    order_id     SERIAL PRIMARY KEY,
    product_id   INT NOT NULL REFERENCES products(product_id)
                 ON DELETE CASCADE,
    quantity     INT NOT NULL CHECK (quantity > 0),
    total_amount NUMERIC
);

-- Hàm giảm tồn kho sau khi thêm đơn hàng
CREATE OR REPLACE FUNCTION reduce_stock_after_insert()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo trigger AFTER INSERT trên bảng sales
DROP TRIGGER trg_reduce_stock ON sales;

-- Sau đó tạo lại trigger
CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION reduce_stock_after_insert();

SELECT tgname
FROM pg_trigger
WHERE tgrelid = 'sales'::regclass;

INSERT INTO products (name, price, stock)
VALUES 
('Laptop', 1500, 5),
('Phone', 800, 10),
('Tablet', 600, 7);


INSERT INTO products (name, price, stock)
VALUES 
('Laptop', 1500, 5),
('Phone', 800, 10);

SELECT * FROM products;


