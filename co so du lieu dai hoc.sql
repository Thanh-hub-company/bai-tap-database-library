create schema daihoc;
--tao bang sinh vien--
create table daihoc.students (
sinh_id serial primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
ngaysinh date,
email varchar(100) unique not null
);

--tao bang cac khoa hoc--
create table daihoc.courses (
khoa_hoc_id serial primary key,
course_name varchar(100) not null,
tin_chi int 
);

--tao bang enrollments --
create table daihoc.enrollments (
posted_id serial primary key,
sinh_id int references daihoc.students(sinh_id),
course_id int references daihoc.courses(khoa_hoc_id),
ghidanh_ngay date
);

--xem danh muc co so du lieu--
select datname
from pg_database;
--xem danh muc luoc do--
select schema_name  from information_schema.schemata;

--xem cau truc bang   Students ,  Courses ,  Enrollments  --
select column_name, data_type, is_nullable
from information_schema.columns 
where table_schema = 'daihoc' and table_name = 'students';
select  column_name, data_type, is_nullable 
from information_schema.columns 
where table_schema = 'daihoc' and table_name = 'courses';

select column_name,data_type, is_nullable 
from information_schema.columns
where table_schema ='daihoc' and table_name = 'enrollments';