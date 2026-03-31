CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    stock INT
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    quantity INT
);

CREATE OR REPLACE FUNCTION update_product_stock()
RETURNS TRIGGER AS $$
BEGIN
    -- Khi thêm đơn hàng mới
    IF TG_OP = 'INSERT' THEN
        UPDATE products
        SET stock = stock - NEW.quantity
        WHERE id = NEW.product_id;
        RETURN NEW;
    END IF;

    -- Khi cập nhật đơn hàng
    IF TG_OP = 'UPDATE' THEN
        UPDATE products
        SET stock = stock + OLD.quantity - NEW.quantity
        WHERE id = NEW.product_id;
        RETURN NEW;
    END IF;

    -- Khi xóa đơn hàng
    IF TG_OP = 'DELETE' THEN
        UPDATE products
        SET stock = stock + OLD.quantity
        WHERE id = OLD.product_id;
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER orders_stock_trigger
AFTER INSERT OR UPDATE OR DELETE ON orders
FOR EACH ROW
EXECUTE FUNCTION update_product_stock();

-- Thêm sản phẩm
INSERT INTO products (name, stock) VALUES ('Laptop', 10);

-- Thêm đơn hàng mới (Laptop - 2 cái)
INSERT INTO orders (product_id, quantity) VALUES (1, 2);

-- Kiểm tra tồn kho
SELECT * FROM products;  -- stock sẽ còn 8

-- Cập nhật đơn hàng (Laptop - đổi từ 2 cái thành 5 cái)
UPDATE orders SET quantity = 5 WHERE id = 1;

-- Kiểm tra tồn kho
SELECT * FROM products;  -- stock sẽ còn 5 (10 - 5)

-- Xóa đơn hàng
DELETE FROM orders WHERE id = 1;

-- Kiểm tra tồn kho
SELECT * FROM products;  -- stock sẽ trở lại 10

