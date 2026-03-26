CREATE TABLE products (
    id SERIAL PRIMARY KEY,          -- Mã sản phẩm, tự tăng
    name VARCHAR(100) NOT NULL,     -- Tên sản phẩm
    price NUMERIC(12,2) NOT NULL,   -- Giá gốc
    discount_percent INT NOT NULL   -- Phần trăm giảm giá (%)
);

INSERT INTO products (name, price, discount_percent)
VALUES
    ('Laptop Dell Inspiron', 15000000, 10),
    ('Chuột Logitech', 250000, 5),
    ('Bàn phím cơ Keychron', 2000000, 15),
    ('Màn hình Samsung 24 inch', 3500000, 20);

CREATE OR REPLACE PROCEDURE calculate_discount(p_id INT, OUT p_final_price NUMERIC)
LANGUAGE plpgsql
AS $$
DECLARE
    v_price NUMERIC;
    v_discount INT;
BEGIN
    -- Lấy giá và phần trăm giảm giá của sản phẩm
    SELECT price, discount_percent
    INTO v_price, v_discount
    FROM products
    WHERE id = p_id;

    IF v_price IS NULL THEN
        RAISE EXCEPTION 'Không tìm thấy sản phẩm với ID %', p_id;
    END IF;

    -- Giới hạn phần trăm giảm giá tối đa là 50
    IF v_discount > 50 THEN
        v_discount := 50;
    END IF;

    -- Tính giá sau giảm
    p_final_price := v_price - (v_price * v_discount / 100);

    -- Cập nhật lại giá trong bảng
    UPDATE products
    SET price = p_final_price
    WHERE id = p_id;

    RAISE NOTICE 'Giá sau giảm của sản phẩm % là %', p_id, p_final_price;
END;
$$;

INSERT INTO products (name, price, discount_percent)
VALUES
    ('Laptop Dell Inspiron', 15000000, 10),
    ('Chuột Logitech', 250000, 60);  -- giảm giá vượt quá 50%

	CALL calculate_discount(1, NULL);  -- Laptop, giảm 10%
CALL calculate_discount(2, NULL);  -- Chuột, giảm 60% nhưng giới hạn còn 50%


