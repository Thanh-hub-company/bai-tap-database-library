CREATE TABLE book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(10,2),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO book (title, author, genre, price, description)
VALUES
('Lập trình SQL cơ bản', 'Nguyen Van A', 'Database', 150000, 'Giới thiệu SQL cho người mới bắt đầu'),
('Phân tích dữ liệu với PostgreSQL', 'Tran Thi B', 'Data Science', 200000, 'Ứng dụng PostgreSQL trong phân tích dữ liệu'),
('Học máy nâng cao', 'Le Van C', 'AI', 350000, 'Các thuật toán học máy nâng cao'),
('Thương mại điện tử hiện đại', 'Pham D', 'E-commerce', 180000, 'Phân tích hệ thống thương mại điện tử'),
('Tiểu thuyết lịch sử Việt Nam', 'Nguyen E', 'Novel', 120000, 'Câu chuyện lịch sử qua tiểu thuyết');

INSERT INTO book (title, author, genre, price, description)
SELECT 
    'Book ' || g, 
    'Author ' || (g % 100), 
    CASE WHEN g % 5 = 0 THEN 'Novel'
         WHEN g % 5 = 1 THEN 'Database'
         WHEN g % 5 = 2 THEN 'AI'
         WHEN g % 5 = 3 THEN 'E-commerce'
         ELSE 'Data Science' END,
    (100000 + (g % 50000)),
    'Mô tả sách số ' || g
FROM generate_series(1, 100000) g;

-- cai Cài extension pg_trgm --
CREATE EXTENSION IF NOT EXISTS pg_trgm;

SELECT * FROM book;
CREATE INDEX idx_book_genre ON book(genre);
CREATE INDEX idx_book_author ON book(author);
CREATE INDEX idx_book_author_gin ON book USING gin (author gin_trgm_ops);
SELECT indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'book';


EXPLAIN ANALYZE SELECT * FROM book WHERE author ILIKE '%Rowling%';
EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';
CLUSTER book USING idx_book_genre;

SELECT * FROM book WHERE author ILIKE '%Rowling%';
SELECT * FROM book WHERE genre = 'Fantasy';

CLUSTER book USING idx_book_genre;

