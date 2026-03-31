-- 1. Tạo bảng customers
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credit_limit NUMERIC(12,2) NOT NULL
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(id),
    order_amount NUMERIC(12,2) NOT NULL
);

CREATE OR REPLACE FUNCTION check_credit_limit()
RETURNS TRIGGER AS $$
DECLARE
    total_orders NUMERIC(12,2);
    limit_value NUMERIC(12,2);
BEGIN
    -- Lấy tổng giá trị đơn hàng hiện tại của khách hàng
    SELECT COALESCE(SUM(order_amount),0)
    INTO total_orders
    FROM orders
    WHERE customer_id = NEW.customer_id;

    -- Lấy hạn mức tín dụng của khách hàng
    SELECT credit_limit
    INTO limit_value
    FROM customers
    WHERE id = NEW.customer_id;

    -- Kiểm tra nếu vượt hạn mức
    IF total_orders + NEW.order_amount > limit_value THEN
        RAISE EXCEPTION 'Khách hàng % vượt hạn mức tín dụng (%.2f > %.2f)',
            NEW.customer_id, total_orders + NEW.order_amount, limit_value;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--4--
CREATE TRIGGER trg_check_credit
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION check_credit_limit();

--chèn dữ liệu--
-- 5. Chèn dữ liệu mẫu vào customers
INSERT INTO customers (name, credit_limit)
VALUES
('Nguyễn Văn A', 2000.00),
('Trần Thị B', 1500.00),
('Lê Văn C', 1000.00);

-- Trường hợp hợp lệ
INSERT INTO orders (customer_id, order_amount)
VALUES (1, 500.00);  -- Tổng 500 <= 2000, hợp lệ

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 1200.00); -- Tổng 1700 <= 2000, hợp lệ


INSERT INTO orders (customer_id, order_amount)
VALUES (1, 600.00);  -- Tổng 2300 > 2000, sẽ bị chặn bởi trigger

SELECT * FROM customers;
SELECT * FROM orders;