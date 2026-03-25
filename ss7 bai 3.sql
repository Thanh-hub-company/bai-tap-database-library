-- Bảng lưu bài đăng
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    author_id INT NOT NULL,
    body TEXT,
    hashtags TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    visibility BOOLEAN DEFAULT TRUE
);

-- Bảng lưu lượt thích
CREATE TABLE likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- Thêm dữ liệu vào bảng posts
INSERT INTO posts (author_id, body, hashtags, visibility)
VALUES
(1, 'Hôm nay trời đẹp quá!', ARRAY['weather','happy'], TRUE),
(2, 'Đang học SQL, thú vị ghê.', ARRAY['study','sql'], TRUE),
(3, 'Bài đăng riêng tư chỉ mình xem.', ARRAY['private'], FALSE);

-- Thêm dữ liệu vào bảng likes
INSERT INTO likes (user_id, post_id)
VALUES
(2, 1),  -- User 2 thích bài của User 1
(3, 1),  -- User 3 cũng thích bài của User 1
(1, 2);  -- User 1 thích bài của User 2


EXPLAIN ANALYZE
SELECT *
FROM posts
WHERE visibility = TRUE
  AND LOWER(body) LIKE '%sql%';

  CREATE INDEX idx_posts_body_lower
ON posts (LOWER(body));

EXPLAIN ANALYZE
SELECT *
FROM posts
WHERE visibility = TRUE
  AND LOWER(body) LIKE '%sql%';


--Tối ưu hóa truy vấn lọc bài đăng theo thẻ (tags):--
EXPLAIN ANALYZE
SELECT *
FROM posts
WHERE visibility = TRUE
  AND tags @> ARRAY['sql'];

ALTER TABLE posts ADD COLUMN tags TEXT[];

CREATE INDEX idx_posts_tags_gin
ON posts USING GIN (tags);

EXPLAIN ANALYZE
SELECT *
FROM posts
WHERE visibility = TRUE
  AND tags @> ARRAY['sql'];

SELECT *
FROM posts
WHERE visibility = TRUE
  AND 'sql' = ANY(tags);


--Tối ưu hóa truy vấn tìm bài đăng mới trong 7 ngày gần nhất:--

EXPLAIN ANALYZE
SELECT *
FROM posts
WHERE visibility = TRUE
  AND created_at >= NOW() - INTERVAL '7 days';

CREATE INDEX idx_posts_recent_public
ON posts (created_at)
WHERE visibility = TRUE;

EXPLAIN ANALYZE
SELECT *
FROM posts
WHERE visibility = TRUE
  AND created_at >= NOW() - INTERVAL '7 days';

--Phân tích chỉ mục tổng hợp (Composite Index):--
--1. truy vấn trc khi có mục
EXPLAIN ANALYZE
SELECT *
FROM posts
WHERE visibility = TRUE
  AND author_id IN (2,3,5)
ORDER BY created_at DESC
LIMIT 20;

--tạo composite index
CREATE INDEX idx_posts_user_recent
ON posts (author_id, created_at DESC);

-- truy vấn sau khi có mục 
EXPLAIN ANALYZE
SELECT *
FROM posts
WHERE visibility = TRUE
  AND author_id IN (2,3,5)
ORDER BY created_at DESC
LIMIT 20;






  



