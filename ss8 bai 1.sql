CREATE TABLE order_detail (
    id SERIAL PRIMARY KEY,        -- Khóa chính, tự tăng
    order_id INT NOT NULL,        -- Mã đơn hàng
    product_name VARCHAR(100),    -- Tên sản phẩm
    quantity INT CHECK (quantity > 0),   -- Số lượng, ràng buộc > 0
    unit_price NUMERIC(10,2) CHECK (unit_price >= 0) -- Đơn giá, ràng buộc >= 0
);

INSERT INTO order_detail (order_id, product_name, quantity, unit_price)
VALUES
    (1, 'Laptop Dell', 2, 1500.00),
    (1, 'Chuột Logitech', 3, 25.50),
    (2, 'Bàn phím cơ', 1, 75.00),
    (2, 'Màn hình Samsung', 2, 220.00);

CREATE OR REPLACE PROCEDURE calculate_order_total(
    order_id_input INT,
    OUT total NUMERIC
)
CREATE OR REPLACE FUNCTION calculate_order_total(order_id_input INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    total NUMERIC;
BEGIN
    SELECT SUM(quantity * unit_price)
    INTO total
    FROM order_detail
    WHERE order_id = order_id_input;

    IF total IS NULL THEN
        total := 0;
    END IF;

    RETURN total;
END;
$$;

SELECT calculate_order_total(1);


CREATE OR REPLACE FUNCTION calculate_order_total(order_id_input INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    total NUMERIC;
BEGIN
    -- Tính tổng tiền theo order_id
    SELECT SUM(quantity * unit_price)
    INTO total
    FROM order_detail
    WHERE order_id = order_id_input;

    -- Nếu không có dữ liệu thì gán 0
    IF total IS NULL THEN
        total := 0;
    END IF;

    RETURN total;
END;
$$;



SELECT calculate_order_total(1);


DROP FUNCTION IF EXISTS calculate_order_total(INT);

-- Tạo Procedure
DROP FUNCTION IF EXISTS calculate_order_total(INT);

CREATE OR REPLACE PROCEDURE calculate_order_total(order_id_input INT)
LANGUAGE plpgsql
AS $$
DECLARE
    total NUMERIC;
BEGIN
    SELECT SUM(quantity * unit_price)
    INTO total
    FROM order_detail
    WHERE order_id = order_id_input;

    IF total IS NULL THEN
        total := 0;
    END IF;

    RAISE NOTICE 'Tổng tiền đơn hàng % là %', order_id_input, total;
END;
$$;

CALL calculate_order_total(1);
