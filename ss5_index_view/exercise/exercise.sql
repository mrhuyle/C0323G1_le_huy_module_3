use demo;

-- INDEX
CREATE UNIQUE INDEX index_product_code ON products(product_code);

ALTER TABLE products
DROP INDEX index_product_code;

EXPLAIN
SELECT * FROM products
WHERE product_code = 1;

CREATE INDEX composite_index ON products(product_name,product_price);

ALTER TABLE products
DROP INDEX composite_index;

EXPLAIN
SELECT * FROM products
WHERE product_name = 'tiger';

-- VIEW

CREATE VIEW test_view AS 
SELECT product_code,product_name,product_price,product_status
FROM products;

SELECT * FROM test_view;

CREATE OR REPLACE VIEW test_view AS
SELECT product_code,product_name
FROM products;

SELECT * FROM test_view;

DROP VIEW test_view;

-- STORED PROCEDURE

DELIMITER //
CREATE PROCEDURE find_all_products()
BEGIN
	SELECT * FROM products;
END //
DELIMITER ;

CALL find_all_products();

DROP PROCEDURE find_all_products;

DELIMITER //
CREATE PROCEDURE add_new_product 
	(IN p_product_code INT,
    IN p_product_name VARCHAR(45),
    IN p_product_price BIGINT,
    IN p_product_amount INT,
    IN p_product_description VARCHAR(55),
    IN p_product_status BIT)
BEGIN 
	INSERT INTO products (product_code,product_name,product_price,product_amout,product_description,product_status)
    VALUES (p_product_code, p_product_name, p_product_price, p_product_amount, p_product_description, p_product_status);
END //
DELIMITER ;

CALL add_new_product(6,'Larue',12000,50,'Cheap',0);

CALL find_all_products();

DELIMITER //

CREATE PROCEDURE update_product (
    IN p_product_id INT,
    IN p_product_code INT,
    IN p_product_name VARCHAR(45),
    IN p_product_price BIGINT,
    IN p_product_amout INT,
    IN p_product_description VARCHAR(55),
    IN p_product_status BIT
)
BEGIN
    UPDATE products
    SET
        product_code = p_product_code,
        product_name = p_product_name,
        product_price = p_product_price,
        product_amout = p_product_amout,
        product_description = p_product_description,
        product_status = p_product_status
    WHERE
        id = p_product_id;
END //

DELIMITER ;


CALL update_product(6,6,'New Larue',12000,50,'Cheap',0);

DROP PROCEDURE update_product ;

DELIMITER //
CREATE PROCEDURE delete_product (IN p_product_id INT)
BEGIN
	DELETE FROM products
    WHERE id = p_product_id;
END //
DELIMITER ;

CALL delete_product(6);
