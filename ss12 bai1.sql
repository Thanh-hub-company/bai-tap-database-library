-- Bảng lưu thông tin khách hàng
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    email       VARCHAR(50) UNIQUE
);

-- Bảng lưu lịch sử hành động của khách hàng
CREATE TABLE customer_log (
    log_id        SERIAL PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    action_time   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tạo trigger function
CREATE OR REPLACE FUNCTION log_customer_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO customer_log (customer_name, action_time)
    VALUES (NEW.name, CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tạo trigger gắn với bảng customers
CREATE TRIGGER trg_customer_insert
AFTER INSERT ON customers
FOR EACH ROW
EXECUTE FUNCTION log_customer_insert();


INSERT INTO customers (name, email)
VALUES 
('Nguyen Van A', 'vana@example.com'),
('Tran Thi B', 'thib@example.com'),
('Le Van C', 'vanc@example.com');

SELECT * FROM customer_log;

