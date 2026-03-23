CREATE TABLE Customer (
    id SERIAL PRIMARY KEY,          -- Mã khách hàng, tự tăng
    name VARCHAR(100) NOT NULL,     -- Tên khách hàng
    email VARCHAR(100) UNIQUE,      -- Email, không trùng lặp
    phone VARCHAR(20),              -- Số điện thoại
    points INT DEFAULT 0            -- Điểm thưởng, mặc định = 0
);

INSERT INTO Customer (name, email, phone, points)
VALUES
('Nguyen Van An', 'an.nguyen@example.com', '0901234567', 120),
('Tran Thi Binh', 'binh.tran@example.com', '0912345678', 80),
('Le Hoang Nam', 'nam.le@example.com', '0923456789', 150),
('Pham Thi Lan', 'lan.pham@example.com', '0934567890', 60),
('Do Minh Anh', NULL, '0945678901', 90), -- khách hàng không có email
('Hoang Van Son', 'son.hoang@example.com', '0956789012', 200),
('Nguyen Thi Hoa', 'hoa.nguyen@example.com', '0967890123', 110);

SELECT DISTINCT name
FROM Customer;

SELECT *
FROM Customer
WHERE email IS NULL;

SELECT *
FROM Customer
ORDER BY points DESC
LIMIT 3 OFFSET 1;

SELECT *
FROM Customer
ORDER BY name DESC;

