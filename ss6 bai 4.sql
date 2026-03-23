CREATE TABLE OrderInfo (
    id          SERIAL PRIMARY KEY,        -- Mã đơn hàng, tự tăng
    customer_id INT NOT NULL,              -- Mã khách hàng (khóa ngoại)
    order_date  DATE DEFAULT CURRENT_DATE, -- Ngày đặt hàng, mặc định là ngày hiện tại
    total       NUMERIC(10,2) CHECK (total >= 0), -- Tổng tiền, không âm
    status      VARCHAR(20)                -- Trạng thái đơn hàng
);

INSERT INTO OrderInfo (customer_id, order_date, total, status)
VALUES
(1, '2024-09-15', 450000, 'Pending'),
(2, '2024-10-05', 600000, 'Completed'),
(3, '2024-10-20', 1200000, 'Shipped'),
(4, '2024-11-02', 300000, 'Cancelled'),
(5, '2024-10-25', 800000, 'Pending');

SELECT *
FROM OrderInfo
WHERE total > 500000;

SELECT *
FROM OrderInfo
WHERE order_date BETWEEN '2024-10-01' AND '2024-10-31';

SELECT *
FROM OrderInfo
WHERE status <> 'Completed';


SELECT *
FROM OrderInfo
ORDER BY order_date DESC
LIMIT 2;
