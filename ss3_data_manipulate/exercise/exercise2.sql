use sale_management;

-- INSERT INTO --
-- insert database into customer
insert into customer (customer_name, customer_age)
values ('Minh Quan', 10), ('Ngoc Oanh', 20), ('Hong Ha',50);

-- insert database into order
insert into `order` (customer_id, order_date, order_total_price)
values (1, '2006-03-21',null),(2, '2006-03-23',null),(1, '2006-03-16',null);

-- insert database into product
insert into product (product_name, product_price)
values ('May Giat', 3), ('Tu Lanh', 5), ('Dieu Hoa',7), ('Quat', 1), ('Bep Dien', 2);

-- insert database into order detail
insert into order_detail
values (1,1,3), (1,3,7), (1,4,2), (2,1,1), (3,1,8), (2,5,4), (2,3,3);
