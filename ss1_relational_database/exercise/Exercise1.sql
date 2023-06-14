CREATE DATABASE `student_management`;
USE `student_management`;
CREATE TABLE Student (
StudentID INT NOT NULL auto_increment,
Name VARCHAR(45) NULL,
Age INT NULL,
Country VARCHAR(45) NULL,
PRIMARY KEY (StudentID));

select *
from Student;

insert into Student (Name, Age, Country)
value ("Le Huy", 18, "VN"),("Louis", 21, "US");

create table Class(
ClassID int not null auto_increment,
Name varchar(255),
primary key (ClassID));

insert into Class(Name)
value ("CO323G1");

select *
from Class;

create table Teacher (
TeacherID int not null auto_increment,
Name varchar(255),
Age int,
Country varchar(255),
primary key (TeacherID));

insert into Teacher (Name, Age, Country)
value ("Hai TT",27,"VN"),("Trung TVH", 25, "USA");

select *
from Teacher;