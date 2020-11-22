/*UC1 Creating a address book service database*/
Create database Address_Book_Service;
use Address_Book_Service;

/*UC2 Creating address book table*/
create table Address_Book(
Id int primary key identity(1,1),
FullName varchar(20) not null,
Address varchar(100) not null,
City varchar(50) not null,
State varchar(200) not null,
PhoneNumber bigint not null,
Zip bigint not null,
Email varchar(50) not null, 
);

/*UC3 Insert data in to address book*/
insert into Address_Book values('Shashidhar','Gowtham Nagar','Bangarpet','Karnataka','8073112156','563114','shashidhar.sasic@gmail.com')
insert into Address_Book values('Lalithkumar','Vijay Nagar','Bangarpet','Karnataka','7073112156','563114','lalithkumar.lallu@gmail.com')
insert into Address_Book values('Ravikumar','Vivekanandha Nagar','kolar','AndhraPradesh','6073112156','563114','ravikumar.ravi@gmail.com')
insert into Address_Book values('Vinodhkumar','Shanthi Nagar','kgf','karnataka','8073222156','563114','vinodhkumar.reddy@gmail.com')
/*Displaying the address book data*/
select * from Address_Book;
drop table Address_Book

/*UC4 Able to edit existing contact in address book*/
update Address_Book set Address = 'Gowtham Nagar' where FullName = 'Lalithkumar';

/* UC5 Able to delete the person using person name*/
delete from Address_Book where FullName = 'Vinodhkumar';

/* UC6 Able to retrieve data by giving city or state*/
select * from Address_Book where City = 'Bangarpet';
select * from Address_Book where State = 'Karnataka';

/* UC7 Able to find count by belongs city and state*/
select Count(City) as 'number of contact' from Address_Book where City='Bangarpet' group by City;
select Count(State) as 'number of contact' from Address_Book where State='Karnataka' group by State;
select City,State,Count(City) as 'number of contact' from Address_Book where City='Bangarpet' and State = 'karnataka' group by City,State;

/* UC8 Able to retrieve entries sorted alphabetically by names for given city */
select * from Address_Book where City = 'Bangarpet' order by FullName;

/* UC9 Able to add new address book name and address book type*/
Alter table Address_Book add AddressBookName varchar(50) null default 0, AddressBookType varchar(50) null default 0;
select * from Address_Book;
update Address_Book set AddressBookName = 'FriendsAddressBook', AddressBookType = 'Friends' where FullName = 'Shashidhar';
update Address_Book set AddressBookName = 'FriendsAddressBook', AddressBookType = 'Friends' where FullName = 'Lalithkumar';
update Address_Book set AddressBookName = 'ProfressionalAddressBook', AddressBookType = 'Professional' where FullName = 'Vinodhkumar';
update Address_Book set AddressBookName = 'FamilyAddressBook', AddressBookType = 'Family' where FullName = 'Ravikumar';

/* UC10 Able to get number of contact person by giving address book type*/
select AddressBookType,Count(*) as 'number of contact' from Address_Book where AddressBookType = 'Friends' group by AddressBookType;
select AddressBookType,Count(*) as 'number of contact' from Address_Book where AddressBookType = 'Family' group by AddressBookType;
select AddressBookType,Count(*) as 'number of contact' from Address_Book where AddressBookType = 'Professional' group by AddressBookType;

/*UC11 Ability to add to both friend and family*/
insert into Address_Book(FullName,Address,City,State,PhoneNumber,Zip,Email,AddressBookName,AddressBookType) 
values('Madhuri','Bowi Nagar','Bangarpet','Gujarat','9966331144','560018','madhuri.mad@gmail.com','FriendsAddressBook','Friends'),
      ('Supriya','BoseNagar','Bangalore','Delhi','8866331144','561018','supriya.supriya@gmail.com','FamilyAddressBook','Family');

/*UC12 Implementing ER-Diagram of address book*/
/*Created person data table*/
create table PersonData(
PersonId int primary key not null identity(1,1),
PersonFullName varchar(200) not null,
PhoneNumber bigint,
Email varchar(50) not null,
);

/*Inserting person data into person data table*/
insert into PersonData values('Sachin','9738440163','sachin.sachin@gmail.com');
insert into PersonData values('Dhoni','973833163','dhoni.dhoni@gmail.com');

/*Created person address table*/
create table PersonAddress(
PersonAddressId int primary key identity(1,1),
PersonAddress varchar(200) not null,
City varchar(20) not null,
State varchar(20) not null,
Zip int not null,
PersonId int foreign key references PersonData(PersonId)
);

/*Inserting address in to person address table*/
insert into PersonAddress values('Amravathi Nagar','bowringpet','Karnataka','563114','1');
insert into PersonAddress values('Deshalli Nagar','Bangarpet','Karnataka','563115','2');

/*Created address book table*/
create table AddressBook(
AddressBookId int primary key identity(1,1),
AddressBookName varchar(20) not null,
AddressBookType varchar(20) not null,
PersonId int foreign key references PersonData(PersonId)
);

/*Inserting name and type of address book into address book table*/
insert into AddressBook values('FriendsAddressBook','Friends','1');
insert into AddressBook values('FamilysAddressBook','Family','2');

/*UC13 Retrieves data from multiple table*/
select * from PersonData;
select * from PersonAddress;
select * from AddressBook;

/*Refactor by UC6*/
/*Retrieve person by giving city*/
select PersonFullName,PhoneNumber,City 
from PersonData inner join PersonAddress
on PersonData.PersonId = PersonAddress.PersonId
where City = 'Bangarpet';

/*Retrieve person by giving state*/
select PersonFullName,PhoneNumber,City 
from PersonData inner join PersonAddress
on PersonData.PersonId = PersonAddress.PersonId
where State = 'Karnataka';

/*Refacto by UC7*/
/*Able to find count by belongs city */
select count(City) as 'Number OF Count'
from PersonData INNER JOIN PersonAddress
on PersonData.PersonId = PersonAddress.PersonId
where City='Bowringpet'
group by City;

/*Able to find count by belongs city */
select count(State) as 'Number OF Count'
from PersonData INNER JOIN PersonAddress
on PersonData.PersonId = PersonAddress.PersonId
where State='Karnataka'
group by State;

/*Refactor by UC8*/
/*Able to retrieve entries sorted alphabetically by names for given city*/
select *  
from PersonData INNER JOIN PersonAddress
on PersonData.PersonId = PersonAddress.PersonId
where City='Bowringpet'
order by PersonFullName;

/*Refactor by UC10*/
/*Able to get number of contact person by giving address book type*/
select count(AddressBookType) as 'Number Of Contact'
from PersonData INNER JOIN AddressBook
on PersonData.PersonId=AddressBook.PersonId
where AddressBookType='Friends'
group by AddressBookType;