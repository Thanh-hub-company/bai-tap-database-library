create schema elearn;
create table elearn.sinhvien (
sinh_id serial primary key ,
first_name varchar(50) not null ,
last_name varchar(50) not null,
email varchar(100) not null unique
);

create table elearn.intructors(
giangvien_id serial primary key,
frist_name varchar(50) not null,
last_name varchar (50) not null,
email varchar (100) not null unique
);

create table elearn.course (
course_id serial primary key,
course_name varchar(100) not null,
giangvien_id int not null references elearn.intructors(giangvien_id) 
);

create table  elearn.ghidanh (
ghidanh_id serial primary key,
sinh_id int references elearn.sinhvien(sinh_id),
course_id int references elearn.course (course_id),
register_date date not null
);

create table elearn.baitapbang(
task_id serial primary key,
course_id int not null references elearn.course(course_id),
title varchar(100) not null,
do_date date not null
);

create table elearn.submissions (
submit_id serial primary key,
task_id int not null references elearn.baitapbang(task_id),
sinh_id int not null references elearn.sinhvien(sinh_id),
submit_date date not null,
diem decimal(5,2) check (diem>=0 and diem<=100)
);