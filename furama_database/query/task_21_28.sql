USE furama_database;

-- 21. Tạo khung nhìn có tên là v_nhan_vien để lấy được thông tin của tất cả các nhân viên có địa chỉ là “Đà Nẵng” 
-- và đã từng lập hợp đồng cho một hoặc nhiều khách hàng bất kì với ngày lập hợp đồng trong năm 2021.

CREATE VIEW v_nhan_vien AS
SELECT * FROM employee e
WHERE 	e.employee_code IN 
		(SELECT 	c.employee_code
		FROM	contract c
		WHERE	YEAR(c.contract_signed_date) = 2021
		GROUP BY c.employee_code
        )
	AND e.employee_address like '%đà nẵng%';

-- 22. Thông qua khung nhìn v_nhan_vien thực hiện cập nhật địa chỉ thành “Liên Chiểu” 
-- đối với tất cả các nhân viên được nhìn thấy bởi khung nhìn này.

UPDATE v_nhan_vien v
SET v.employee_address = 'Liên Chiểu';

SELECT * FROM employee;

-- 23. Tạo Stored Procedure sp_xoa_khach_hang dùng để xóa thông tin của một khách hàng nào đó
--  với ma_khach_hang được truyền vào như là 1 tham số của sp_xoa_khach_hang.

DELIMITER //
CREATE PROCEDURE delete_customer (IN c_code INT)
BEGIN
	DELETE FROM customer c
    WHERE c.customer_code = c_code;
END //
DELIMITER ;

-- 24. Tạo Stored Procedure sp_them_moi_hop_dong dùng để thêm mới vào bảng hop_dong 
-- với yêu cầu sp_them_moi_hop_dong phải thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung, 
-- với nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.

SHOW CREATE TABLE contract;

DELIMITER //
CREATE PROCEDURE add_contract
	(IN c_code INT,
    IN c_signed_date DATETIME,
    IN c_end_date DATETIME,
    IN c_deposit DOUBLE,
    IN e_code INT,
    IN cus_code INT,
    IN se_code INT)
BEGIN
	INSERT INTO contract
	VALUES (c_code, c_signed_date,c_end_date,c_deposit,e_code,cus_code,se_code);
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddContract(
    IN p_contract_code INT,
    IN p_contract_signed_date DATETIME,
    IN p_contract_end_date DATETIME,
    IN p_contract_deposit DOUBLE,
    IN p_employee_code INT,
    IN p_customer_code INT,
    IN p_service_code INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle any exception or error that occurs during the execution
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Check if the contract code already exists
    IF EXISTS (SELECT * FROM contract WHERE contract_code = p_contract_code) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Contract code already exists.';
    END IF;

    -- Check if the employee code exists in the employee table
    IF NOT EXISTS (SELECT * FROM employee WHERE employee_code = p_employee_code) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid employee code.';
    END IF;

    -- Check if the customer code exists in the customer table
    IF NOT EXISTS (SELECT * FROM customer WHERE customer_code = p_customer_code) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid customer code.';
    END IF;

    -- Check if the service code exists in the service table
    IF NOT EXISTS (SELECT * FROM service WHERE service_code = p_service_code) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid service code.';
    END IF;

    -- Insert the new contract
    INSERT INTO contract (contract_code, contract_signed_date, contract_end_date, contract_deposit, employee_code, customer_code, service_code)
    VALUES (p_contract_code, p_contract_signed_date, p_contract_end_date, p_contract_deposit, p_employee_code, p_customer_code, p_service_code);

    COMMIT;
END //

DELIMITER ;

