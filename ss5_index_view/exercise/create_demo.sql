CREATE DATABASE demo;

USE demo;

CREATE TABLE products (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_code INT NOT NULL,
    product_name VARCHAR(45),
    product_price BIGINT,
    product_amout INT,
    product_description VARCHAR(55),
    product_status bit);
    
insert into products (product_code,product_name,product_price,product_amout,product_description,product_status)
values
(1,'Coke',10000,24,'Good',1),
(2,'Pepsi',10000,20,'Very good',1),
(3,'Tiger',20000,30,'Bad',0),
(4,'Heineken',25000,24,'Expensive',1),
(5,'Huda',15000,40,'Reasonable',1);