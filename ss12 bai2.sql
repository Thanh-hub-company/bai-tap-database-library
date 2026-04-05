-- Bảng sản phẩm
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    stock      INT CHECK (stock >= 0)
);

-- Bảng bán hàng
CREATE TABLE sales (
    sale_id    SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products(product_id)
                ON DELETE CASCADE,
    quantity   INT NOT NULL CHECK (quantity > 0)
);


-- Hàm kiểm tra tồn kho
CREATE OR REPLACE FUNCTION check_stock_before_insert()
RETURNS TRIGGER AS $$
DECLARE
    current_stock INT;
BEGIN
    -- Lấy tồn kho hiện tại của sản phẩm
    SELECT stock INTO current_stock
    FROM products
    WHERE product_id = NEW.product_id;

    -- Nếu không đủ hàng thì báo lỗi
    IF current_stock IS NULL THEN
        RAISE EXCEPTION 'Sản phẩm không tồn tại!';
    ELSIF NEW.quantity > current_stock THEN
        RAISE EXCEPTION 'Không đủ tồn kho! Hiện có % sản phẩm.', current_stock;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo trigger BEFORE INSERT trên bảng sales
CREATE TRIGGER trg_check_stock
BEFORE INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION check_stock_before_insert();

INSERT INTO products (name, stock)
VALUES ('Laptop', 5), ('Phone', 10);


INSERT INTO sales (product_id, quantity)
VALUES (1, 3);  -- Laptop, tồn kho 5, đặt 3 -> OK

INSERT INTO sales (product_id, quantity)
VALUES (1, 10); -- Laptop, tồn kho 5, đặt 10 -> Trigger báo lỗi


