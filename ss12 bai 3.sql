-- Bảng sản phẩm
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    stock      INT NOT NULL CHECK (stock >= 0)
);

-- Bảng bán hàng
CREATE TABLE sales (
    sale_id    SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products(product_id)
                ON DELETE CASCADE,
    quantity   INT NOT NULL CHECK (quantity > 0)
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
CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION reduce_stock_after_insert();

INSERT INTO products (name, stock)
VALUES ('Laptop', 5), ('Phone', 10);

INSERT INTO sales (product_id, quantity)
VALUES (1, 2);  -- Laptop, tồn kho 5, đặt 2

SELECT * FROM products;
