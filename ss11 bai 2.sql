-- Tạo bảng accounts
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    owner_name VARCHAR(100),
    balance NUMERIC(10,2)
);

-- Thêm dữ liệu mẫu
INSERT INTO accounts (owner_name, balance)
VALUES ('A', 500.00), ('B', 300.00);
BEGIN;

-- Trừ 100 từ tài khoản A
UPDATE accounts
SET balance = balance - 100.00
WHERE owner_name = 'A';

-- Cộng 100 vào tài khoản B
UPDATE accounts
SET balance = balance + 100.00
WHERE owner_name = 'B';

COMMIT;

BEGIN;

-- Trừ 100 từ tài khoản A
UPDATE accounts
SET balance = balance - 100.00
WHERE owner_name = 'A';

-- Lỗi: tài khoản 'C' không tồn tại
UPDATE accounts
SET balance = balance + 100.00
WHERE owner_name = 'C';

-- Sau khi lỗi, transaction bị hủy → cần rollback
ROLLBACK;

SELECT * FROM accounts;

