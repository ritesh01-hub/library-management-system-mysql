
 --  ' \'Creating database\''
   
create database library_db;
use library_db;

	 -- create Booktable
     
create table books(
book_id int auto_increment primary key,
title varchar(100) not null,
author varchar(100),
total_copies int not null,
available_copies int not null);


		-- create memberTable
        
create table members(
member_id int auto_increment primary key,
name varchar(100) not null,
email varchar(100) unique,
join_date date default(current_date)
);


-- Issued Books tables

create table issued_books(
issue_id int auto_increment primary key,
book_id int,
member_id int,
issue_date date default (current_date),
return_date date,
foreign key (book_id) references books(book_id),
foreign key (member_id) references members(member_id)
);
	
		-- insert sample data
        
insert into books (title, author, total_copies, available_copies)
values  
('Clean Code' ,'Robert C' ,5,5),
('Introduction to algo' , 'CLRS',3,3),
('DataBase concepts','silberchatz',4,4);  

insert into members (name,email)
values
('ritesh tiwari','ritesh@gmail.com'),
('surya singh' , 'suray@gmail.com'),
('Amit singh' , 'amit@gmail.com');    

		-- Issue a Book 
start transaction;
insert into issued_books(book_id,member_id)
values (1,1);
update books
set available_copies = available_copies -1
where book_id = 1 and available_copies > 0;
commit;

		-- Return a Book
        
update issued_books
set return_date = current_date
where issue_id = 1;

update books
set available_copies = available_copies + 1
where book_id = 1;       
 
 
-- 		Fetch Issued Books (join)


select m.name , b.title, i.issue_date
from issued_books i
join members m on i.member_id = m.member_id
join books b on i.book_id = b.book_id
where i.return_date is null;


		-- Find Overdue Books
     
select m.name , b.title, i.issue_date
from issued_books i
join members m on i.member_id = m.member_id
join books b on i.book_id = b.book_id
where i.return_date is null
and i.issue_date < current_date() - interval 14 day;     
     
        
        
