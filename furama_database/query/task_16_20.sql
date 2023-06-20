use furama_database;

-- 16. Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.
DELETE FROM employee
WHERE employee.employee_code 
NOT IN (
		SELECT	contract.employee_code
		FROM	contract
		WHERE	contract.contract_signed_date BETWEEN '2019-01-01' AND '2021-12-31'
		GROUP BY contract.employee_code);

-- 17. Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond, 
-- chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.

-- UPDATE

UPDATE		customer
SET			customer.customer_type = 1
WHERE		customer.customer_type = 2
	AND		
    customer.customer_code IN 
	(SELECT	abc.code
	FROM	(SELECT		
			contract.contract_code,
			contract.contract_deposit,
			contract.customer_code AS code,
            customer.customer_name,
            customer_type.customer_type_code,
            details_contract.additional_service_code,
            details_contract.details_contract_quantity,
            additional_service.additional_service_price,
            (details_contract.details_contract_quantity * additional_service.additional_service_price) AS sum_add_service,
            service.service_fee,
            ((details_contract.details_contract_quantity * additional_service.additional_service_price) + service.service_fee - contract.contract_deposit) AS TOTAL,
            contract.contract_end_date
FROM		contract
LEFT JOIN	details_contract ON details_contract.contract_code = contract.contract_code
JOIN		additional_service ON details_contract.additional_service_code = additional_service.additional_service_code
JOIN		service ON service.service_code = contract.service_code
JOIN		customer ON customer.customer_code = contract.customer_code
JOIN		customer_type ON customer_type.customer_type_code = customer.customer_type
HAVING		YEAR(contract.contract_end_date) = 2021
	AND		TOTAL >= 10000000) abc);
    
-- 18. Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).

-- SHOW CREATE TABLE details_contract;

-- ALTER TABLE details_contract
-- DROP FOREIGN KEY details_contract_ibfk_1;

-- ALTER TABLE details_contract
-- ADD CONSTRAINT details_contract_ibfk_1
-- FOREIGN KEY (contract_code)
-- REFERENCES `contract` (`contract_code`)
-- ON DELETE CASCADE;


DELETE FROM customer
WHERE customer.customer_code
		IN (SELECT		contract.customer_code
			FROM		contract
			WHERE		YEAR(contract.contract_signed_date) < 2021
			GROUP BY	contract.customer_code);

SELECT		contract.customer_code
FROM		contract
WHERE		YEAR(contract.contract_signed_date) < 2021
GROUP BY	contract.customer_code;

-- 19. Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.

SELECT		details_contract.additional_service_code,
            additional_service.additional_service_name
FROM		(SELECT		contract.contract_code as code
			FROM		contract
			WHERE		YEAR(contract_end_date) = 2020) abc
LEFT JOIN 	details_contract ON abc.code = details_contract.contract_code
JOIN		additional_service ON additional_service.additional_service_code = details_contract.additional_service_code
GROUP BY	details_contract.additional_service_code
HAVING		sum(details_contract.details_contract_quantity) > 10;

SELECT		contract.contract_code
FROM		contract
WHERE		YEAR(contract_end_date) = 2020;


-- 20. Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, 
-- thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.
SELECT 	employee.employee_code, employee.employee_name, employee.employee_email, employee.employee_phone, employee.employee_dob, employee.employee_address, 'employee' as type
FROM	employee
UNION ALL
SELECT	customer.customer_code, customer.customer_name, customer.customer_email, customer.customer_phone, customer.customer_dob, customer.customer_address, 'customer'
FROM	customer;
