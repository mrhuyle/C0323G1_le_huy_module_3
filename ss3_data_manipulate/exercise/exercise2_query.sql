use sale_management;

-- QUERY --
-- 1. display order_id, order_date, order_total_price of all orders in order table:
select order_id, order_date, order_total_price from `order`;

-- 2. display a list of customers who had bought product and a list of products that had been bought:
select customer_name from customer c
right join `order` o
on c.customer_id = o.customer_id
group by c.customer_id;

select product_name as 'has been bought' from product p
right join order_detail od
on p.product_id = od.product_id
group by p.product_id;

-- 3. display a list of customers that did not buy any product
select customer_name as 'did not buy any' , o.order_id from customer c
left join `order` o
on c.customer_id = o.customer_id
where order_id is null;

-- 4. Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT o.order_id, o.order_date, result.mySum AS TOTAL
FROM `order` o
INNER JOIN
(SELECT d.order_id AS order_id, SUM(p.product_price * d.oder_quantity) AS mySum
FROM order_detail d
INNER JOIN product p ON d.product_id = p.product_id
GROUP BY d.order_id) result
ON o.order_id = result.order_id;
