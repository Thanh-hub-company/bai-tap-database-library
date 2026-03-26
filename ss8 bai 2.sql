CREATE TABLE order_detail (
    order_detail_id SERIAL PRIMARY KEY,   -- Khóa chính tự tăng
    order_id INT NOT NULL,                -- Mã đơn hàng
    product_name VARCHAR(100) NOT NULL,   -- Tên sản phẩm
    quantity INT NOT NULL,                -- Số lượng
    unit_price NUMERIC(10,2) NOT NULL     -- Đơn giá
);

CREATE TABLE inventory (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL
);

INSERT INTO inventory (product_name, quantity)
VALUES
    ('Laptop Dell Inspiron', 10),
    ('Chuột Logitech', 50),
    ('Bàn phím cơ Keychron', 20);


INSERT INTO order_detail (order_id, product_name, quantity, unit_price)
VALUES
    (1, 'Laptop Dell Inspiron', 2, 15000000),
    (1, 'Chuột Logitech', 3, 250000),
    (2, 'Bàn phím cơ Keychron', 1, 2000000),
    (2, 'Màn hình Samsung 24 inch', 2, 3500000),
    (3, 'Tai nghe Sony WH-1000XM4', 1, 7000000);

CREATE OR REPLACE PROCEDURE check_stock(p_id INT, p_qty INT)
LANGUAGE plpgsql
AS $$
DECLARE
    current_qty INT;
BEGIN
    -- Lấy số lượng tồn kho hiện tại của sản phẩm
    SELECT quantity
    INTO current_qty
    FROM inventory
    WHERE product_id = p_id;

    -- Nếu không tìm thấy sản phẩm thì báo lỗi
    IF current_qty IS NULL THEN
        RAISE EXCEPTION 'Sản phẩm với ID % không tồn tại trong kho', p_id;
    END IF;

    -- Kiểm tra tồn kho
    IF current_qty < p_qty THEN
        RAISE EXCEPTION 'Không đủ hàng trong kho. Hiện có %, yêu cầu %', current_qty, p_qty;
    ELSE
        RAISE NOTICE 'Đủ hàng trong kho. Hiện có %, yêu cầu %', current_qty, p_qty;
    END IF;
END;
$$;


CALL check_stock(1, 5);   -- kiểm tra sản phẩm có product_id = 1, yêu cầu 5 cái
CALL check_stock(2, 100); -- kiểm tra sản phẩm có product_id = 2, yêu cầu 100 cái




