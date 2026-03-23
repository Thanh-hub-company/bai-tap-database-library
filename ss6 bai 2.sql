CREATE TABLE Employee (
    employee_id   SERIAL PRIMARY KEY,         -- Mã nhân viên, tự tăng
    full_name     VARCHAR(100) NOT NULL,      -- Họ và tên
    department    VARCHAR(50),                -- Phòng ban
    salary        DECIMAL(10,2) CHECK (salary >= 0), -- Lương, không âm
    hire_date     DATE DEFAULT CURRENT_DATE   -- Ngày tuyển dụng, mặc định là ngày hiện tại
);

INSERT INTO Employee (full_name, department, salary, hire_date)
VALUES
('Nguyen Van An', 'IT', 8000000, '2023-02-15'),
('Tran Thi Binh', 'HR', 7000000, '2023-03-10'),
('Le Hoang Nam', 'IT', 9000000, '2022-11-20'),
('Pham Thi Lan', 'Finance', 6500000, '2023-05-05'),
('Do Minh Anh', 'Marketing', 7500000, '2023-07-18'),
('Hoang Van Son', 'IT', 8500000, '2023-09-25');

UPDATE Employee
SET salary = salary * 1.10
WHERE department = 'IT';

DELETE FROM Employee
WHERE salary < 6000000;

SELECT *
FROM Employee
WHERE LOWER(full_name) LIKE '%an%';

SELECT *
FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';
