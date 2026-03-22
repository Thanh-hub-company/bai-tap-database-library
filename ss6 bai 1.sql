CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    stock INT
);

INSERT INTO Product (name, category, price, stock) VALUES
('iPhone 15', 'Điện tử', 25000000, 50),
('Laptop Dell XPS', 'Điện tử', 32000000, 30),
('Tủ lạnh LG', 'Điện tử', 15000000, 20),
('Áo sơ mi nam', 'Thời trang', 500000, 100),
('Giày thể thao Nike', 'Thời trang', 2000000, 80);

SELECT * FROM Product;

SELECT * 
FROM Product
ORDER BY price DESC
LIMIT 3;


SELECT * 
FROM Product
WHERE category = 'Điện tử' AND price < 10000000;
SELECT * 
FROM Product
ORDER BY stock ASC;