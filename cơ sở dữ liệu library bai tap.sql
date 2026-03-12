create database libraryDB;

create schema library;
--tạo bảng books trong lược đồ library--
create table library.books (
book_id serial primary key,
title varchar(100) not null,
tacgia varchar (50) not null,
published_year int,
gia decimal(10,2)
);
 -- xem cấu trúc bảng --
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'Library'
  AND table_name   = 'Books';
-- xem toàn bộ cơ sở dữ liệu--
SELECT datname 
FROM pg_database;
  --. Xem tất cả các lược đồ trong cơ sở dữ liệu hiện tại--
select schema_name
from information_schema.schemata;
