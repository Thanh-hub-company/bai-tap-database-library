--bảng students--
create table students (
id serial primary key,
name varchar (50),
age int ,
major varchar (50),
gpa decimal (3,2)
);

--insert students --
insert into students (name,age,major,gpa )values 
('An','20','cntt','3.5'),
('Binh','21','toan','3.2'),
('Cường','22','cntt','3.8'),
('Dương ','20','Vật lý','3.0'),
('Em  ','21','Cntt','2.9');

-- thêm sinh viên mới hùng--
insert into students (name,age,major,gpa )values 
('Hùng','23','Hoá học','3.4');

--cập nhật sinh viên bình thanh 3.6--
update students set gpa = 3.6 where name ='Binh';    

select * from students;

--xoa sinh vien --
delete from  students where gpa < 3.0;
-- liet ke sinh vien (tên, chuyên ngành)--
select name ,major
from students 
order by gpa DESC;
--liet ke ten sinh vien duy nhat có chuyen ngành cntt-
select name from students where major = 'cntt';
--liet ke cac sinh vien co gpa tu 3.0 den 3.6--
select * from students where gpa between 3.0 and 3.6;
--liet ke tat ca sinh vien có ten bang cu c --
select * from  students where  name ilike 'c%';
-- hien thi 3 sinh vien dau theo thu tu tang dan--
select * from students order by name asc limit 4 offset 2;