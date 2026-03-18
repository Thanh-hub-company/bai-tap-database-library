create schema library;
create table library.books (
book_id serial primary key,
title varchar(225) not null,
author varchar (225) not null,
pusblished_year int,
available boolean default true 
);

create table members (
member_id serial primary key,
name varchar(225) not null,
email varchar(225) not null unique,
join_date date default current_date
);
