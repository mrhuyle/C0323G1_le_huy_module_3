USE furama_database;

-- 11. Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” 
-- và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.

SELECT additional_service.additional_service_code, additional_service.additional_service_name FROM additional_service
JOIN details_contract ON additional_service.additional_service_code = details_contract.additional_service_code
JOIN contract ON contract.contract_code = details_contract.contract_code
JOIN customer ON contract.customer_code = customer.customer_code
JOIN customer_type ON customer.customer_type = customer_type.customer_type_code
WHERE customer_type.customer_type_name = 'Diamond'
AND customer.customer_address like '%Vinh%' or customer.customer_address like '%Quảng Ngãi';

-- 12. Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), 
-- ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), 
-- tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.

SELECT 	contract.contract_code,
		employee.employee_name,
        customer.customer_name,
        customer.customer_phone,
        service.service_name,
        SUM(details_contract.additional_service_code),
        contract.contract_deposit
FROM	contract
JOIN	employee ON contract.employee_code = employee.employee_code
JOIN	customer ON customer.customer_code = contract.customer_code
JOIN	service ON service.service_code = contract.service_code
LEFT JOIN	details_contract ON details_contract.contract_code = contract.contract_code
WHERE 	contract.contract_signed_date BETWEEN '2020-10-01' AND '2020-12-31'
AND 	contract.contract_signed_date NOT BETWEEN '2021-01-01' AND '2021-06-30'
GROUP BY contract.contract_code;

-- 13. Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. 
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau)
SELECT	additional_service.additional_service_code,
        additional_service.additional_service_name,
        sum(details_contract.details_contract_quantity) AS ABC
FROM	details_contract
JOIN	contract ON contract.contract_code = details_contract.details_contract_code
JOIN	additional_service ON additional_service.additional_service_code = details_contract.additional_service_code
GROUP BY details_contract.additional_service_code
HAVING	ABC
		= 
(SELECT MAX(result.sum)
FROM details_contract
JOIN
(
SELECT sum(details_contract.details_contract_quantity) AS sum, details_contract.additional_service_code AS code
FROM details_contract
GROUP BY details_contract.additional_service_code
) result
ON details_contract.details_contract_code = result.code);

-- 14. Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. 
-- Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).

SELECT	contract.contract_code,
		service_type.service_type_name,
        result.name,
        result.count
FROM	
(SELECT	additional_service.additional_service_name AS name,
        additional_service.additional_service_code AS code,
        count(distinct additional_service.additional_service_code) AS count
FROM	details_contract
JOIN	additional_service ON details_contract.additional_service_code = additional_service.additional_service_code
GROUP BY
    additional_service.additional_service_code
HAVING
    COUNT(additional_service.additional_service_code) = 1) result
JOIN	details_contract ON details_contract.additional_service_code = result.code
JOIN	contract ON contract.contract_code = details_contract.contract_code
JOIN	service_type ON contract.service_code = service_type.service_type_code;

-- 15. Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan, so_dien_thoai, 
-- dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.

SELECT	result.code,
		employee.employee_name,
        education_level.education_level_name,
        department.department_name,
        employee.employee_phone,
        employee.employee_address
FROM 	employee
RIGHT JOIN (
		SELECT	employee_code AS code,
				count(employee_code)
        FROM	contract
        GROUP BY employee_code
        HAVING 	count(contract.employee_code) = 1) result
        ON result.code = employee.employee_code
JOIN	education_level ON education_level.education_level_code = employee.education_level_code
JOIN	department ON department.department_code = employee.department_code;