-- Bảng lưu thông tin tài khoản khách hàng
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,          -- Mã tài khoản tự tăng
    customer_name VARCHAR(100),             -- Tên khách hàng
    balance NUMERIC(12,2)                   -- Số dư tài khoản
);

-- Bảng lưu lịch sử giao dịch
CREATE TABLE transactions (
    trans_id SERIAL PRIMARY KEY,            -- Mã giao dịch tự tăng
    account_id INT REFERENCES accounts(account_id), -- Liên kết tới tài khoản
    amount NUMERIC(12,2),                   -- Số tiền giao dịch
    trans_type VARCHAR(20),                 -- Loại giao dịch: 'WITHDRAW' hoặc 'DEPOSIT'
    created_at TIMESTAMP DEFAULT NOW()      -- Thời điểm thực hiện
);

INSERT INTO accounts (customer_name, balance)
VALUES ('Nguyen Van A', 1000.00);

BEGIN;

-- Kiểm tra số dư
DO $$
DECLARE current_balance NUMERIC(12,2);
BEGIN
    SELECT balance INTO current_balance FROM accounts WHERE account_id = 1;
    IF current_balance < 200.00 THEN
        RAISE EXCEPTION 'Số dư không đủ để rút tiền';
    END IF;
END $$;

-- Trừ số dư
UPDATE accounts
SET balance = balance - 200.00
WHERE account_id = 1;

-- Ghi log giao dịch
INSERT INTO transactions (account_id, amount, trans_type)
VALUES (1, 200.00, 'WITHDRAW');

COMMIT;

ROLLBACK

BEGIN;

-- Kiểm tra số dư
DO $$
DECLARE current_balance NUMERIC(12,2);
BEGIN
    SELECT balance INTO current_balance FROM accounts WHERE account_id = 1;
    IF current_balance < 200.00 THEN
        RAISE EXCEPTION 'Số dư không đủ để rút tiền';
    END IF;
END $$;

-- Trừ số dư
UPDATE accounts
SET balance = balance - 200.00
WHERE account_id = 1;

-- Ghi log giao dịch
INSERT INTO transactions (account_id, amount, trans_type)
VALUES (1, 200.00, 'WITHDRAW');

COMMIT;

SELECT * FROM accounts;
SELECT * FROM transactions;

BEGIN;

UPDATE accounts
SET balance = balance - 200.00
WHERE account_id = 1;

-- Lỗi: account_id không tồn tại
INSERT INTO transactions (account_id, amount, trans_type)
VALUES (9999, 200.00, 'WITHDRAW');

ROLLBACK;
