CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    birth_year INT,
    major VARCHAR(50),
    gpa DECIMAL(3,1)
);

-- 2. Thêm dữ liệu mẫu (theo đề bài)
INSERT INTO students (full_name, gender, birth_year, major, gpa) VALUES
('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
('Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
('Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
('Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
('Lưu Đức Tài', NULL, 2004, 'Cơ khí', NULL),
('Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

-- 3. Chèn dữ liệu mới: Phan Hoàng Nam
INSERT INTO students (full_name, gender, birth_year, major, gpa)
VALUES ('Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

-- 4. Cập nhật GPA cho Lê Quốc Cường
UPDATE students
SET gpa = 3.4
WHERE full_name = 'Lê Quốc Cường';

-- 5. Xóa sinh viên có GPA IS NULL
DELETE FROM students
WHERE gpa IS NULL;

-- 6. Hiển thị sinh viên ngành CNTT có GPA >= 3.0, chỉ lấy 3 kết quả đầu tiên
SELECT * FROM students
WHERE major = 'CNTT' AND gpa >= 3.0
LIMIT 3;

-- 7. Liệt kê danh sách ngành học duy nhất
SELECT DISTINCT major
FROM students;

-- 8. Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên
SELECT * FROM students
WHERE major = 'CNTT'
ORDER BY gpa DESC, full_name ASC;

-- 9. Tìm sinh viên có tên bắt đầu bằng "Nguyễn"
SELECT * FROM students
WHERE full_name ILIKE 'Nguyễn%';

-- 10. Hiển thị sinh viên có năm sinh từ 2001 đến 2003
SELECT * FROM students
WHERE birth_year BETWEEN 2001 AND 2003;