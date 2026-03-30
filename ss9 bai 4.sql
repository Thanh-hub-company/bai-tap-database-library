CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    sale_date DATE NOT NULL,
    amount NUMERIC(10,2) NOT NULL
);

INSERT INTO Sales (customer_id, product_id, sale_date, amount)
VALUES
(101, 1, '2024-01-10', 500.00),
(101, 2, '2024-01-11', 600.00),
(102, 3, '2024-01-12', 300.00),
(102, 4, '2024-01-13', 800.00),
(103, 5, '2024-01-14', 1200.00),
(104, 6, '2024-01-15', 200.00);

CREATE VIEW CustomerSales AS
SELECT customer_id,
       SUM(amount) AS total_amount
FROM Sales
GROUP BY customer_id;


SELECT * 
FROM CustomerSales
WHERE total_amount > 1000;

CREATE OR REPLACE FUNCTION update_customersales()
RETURNS trigger AS $$
BEGIN
    -- Khi cập nhật total_amount trong View, ta sẽ thêm một bản ghi mới vào Sales
    INSERT INTO Sales (customer_id, product_id, sale_date, amount)
    VALUES (NEW.customer_id, 0, CURRENT_DATE, NEW.total_amount - OLD.total_amount);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER customersales_update
INSTEAD OF UPDATE ON CustomerSales
FOR EACH ROW
EXECUTE FUNCTION update_customersales();


UPDATE CustomerSales
SET total_amount = 2000
WHERE customer_id = 101;

SELECT * FROM CustomerSales WHERE customer_id = 101;
