CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,       -- Mã nhân viên, tự tăng
    emp_name VARCHAR(100) NOT NULL,  -- Tên nhân viên
    job_level INT NOT NULL,          -- Bậc công việc
    salary NUMERIC(12,2) NOT NULL    -- Mức lương
);
INSERT INTO employees (emp_name, job_level, salary)
VALUES
    ('Nguyễn Văn A', 1, 5000000),
    ('Trần Thị B', 2, 7000000),
    ('Lê Văn C', 3, 10000000);
CREATE OR REPLACE PROCEDURE adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC)
LANGUAGE plpgsql
AS $$
DECLARE
    v_job_level INT;
BEGIN
    -- Lấy bậc công việc của nhân viên
    SELECT job_level
    INTO v_job_level
    FROM employees
    WHERE emp_id = p_emp_id;

    IF v_job_level IS NULL THEN
        RAISE EXCEPTION 'Không tìm thấy nhân viên với ID %', p_emp_id;
    END IF;

    -- Cập nhật lương theo quy tắc
    IF v_job_level = 1 THEN
        UPDATE employees SET salary = salary * 1.1 WHERE emp_id = p_emp_id;
    ELSIF v_job_level = 2 THEN
        UPDATE employees SET salary = salary * 1.2 WHERE emp_id = p_emp_id;
    ELSIF v_job_level = 3 THEN
        UPDATE employees SET salary = salary * 1.3 WHERE emp_id = p_emp_id;
    ELSE
        RAISE NOTICE 'Không có quy tắc cho job_level %', v_job_level;
    END IF;

    -- Lấy lại lương mới để trả về
    SELECT salary
    INTO p_new_salary
    FROM employees
    WHERE emp_id = p_emp_id;

    RAISE NOTICE 'Lương mới của nhân viên % là %', p_emp_id, p_new_salary;
END;
$$;

CALL adjust_salary(1, NULL);  -- Nhân viên ID = 1, job_level = 1
CALL adjust_salary(2, NULL);  -- Nhân viên ID = 2, job_level = 2
CALL adjust_salary(3, NULL);  -- Nhân viên ID = 3, job_level = 3