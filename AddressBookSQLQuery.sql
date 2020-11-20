/*UC1 Creating a address book service database*/
Create database Address_Book_Service;
use Address_Book_Service;

/*UC2 Creating address book table*/
create table Address_Book(
Id int primary key identity(1,1),
firstName varchar(20) not null,
lastName varchar(20) not null,
address varchar(100) not null,
city varchar(50) not null,
state varchar(200) not null,
phoneNumber bigint not null,
zip bigint not null,
email varchar(50) not null, 
);

/*UC3 Insert data in to address book*/
insert into Address_Book values('Shashi','Dhar','Gowtham Nagar','Bangarpet','Karnataka','8073112156','563114','shashidhar.sasic@gmail.com')
insert into Address_Book values('Lalith','Kumar','Vijay Nagar','Bangarpet','Karnataka','7073112156','563114','lalithkumar.lallu@gmail.com')
insert into Address_Book values('Ravi','Kumar','Vivekanandha Nagar','kolar','AndhraPradesh','6073112156','563114','ravikumar.ravi@gmail.com')
insert into Address_Book values('Vinodh','Kumar','Shanthi Nagar','kgf','karnataka','8073222156','563114','vinodhkumar.reddy@gmail.com')
/*Displaying the address book data*/
select * from Address_Book;
drop table Address_Book

/*UC4 Able to edit existing contact in address book*/
update Address_Book set address = 'Gowtham Nagar' where firstName = 'Lalith' and lastName = 'Kumar';

/* UC5 Able to delete the person using person name*/
delete from Address_Book where firstName = 'Vinodh' and lastName = 'Kumar';

/* UC6 Able to retrieve data by giving city or state*/
select * from Address_Book where city = 'Bangarpet';
select * from Address_Book where state = 'Karnataka';

/* UC7 Able to find count by belongs city and state*/
select Count(city) as 'number of contact' from Address_Book where city='Bangarpet' group by city;
select Count(state) as 'number of contact' from Address_Book where state='Karnataka' group by state;
select city,state,Count(city) as 'number of contact' from Address_Book where city='Bangarpet' and state = 'karnataka' group by city,state;

/* UC8 Able to retrieve entries sorted alphabetically by names for given city */
select * from Address_Book where city = 'Bangarpet' order by firstname;

/* UC9 Able to add new address book name and address book type*/
Alter table Address_Book add addressBookName varchar(50) null default 0, addressBookType varchar(50) null default 0;
select * from Address_Book;
update Address_Book set addressBookName = 'FriendsAddressBook', addressBookType = 'Friends' where firstName = 'Shashi';
update Address_Book set addressBookName = 'FriendsAddressBook', addressBookType = 'Friends' where firstName = 'Lalith';
update Address_Book set addressBookName = 'ProfressionalAddressBook', addressBookType = 'Professional' where firstName = 'Vinodh';
update Address_Book set addressBookName = 'FamilyAddressBook', addressBookType = 'Family' where firstName = 'Ravi';

/* UC10 Able to get number of contact person by giving address book type*/
select addressBookType,Count(*) as 'number of contact' from Address_Book where addressBookType = 'Friends' group by addressBookType;