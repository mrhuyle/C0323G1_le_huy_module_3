use furama_database;

-- 2. Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” 
-- và có tối đa 15 kí tự.
SELECT * FROM employee
WHERE employee_name LIKE 'h%' 
OR employee_name LIKE 't%'
OR employee_name LIKE 'k%'
AND (LENGTH(employee_name) <= 15);

-- 3. Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”
SELECT 
    *
FROM
    customer c
WHERE
    (DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), customer_dob)),
            '%Y') + 0) >= 15
        AND (DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), customer_dob)),
            '%Y') + 0) <= 50
        AND customer_address LIKE '%đà nẵng%'
        OR customer_address LIKE '%quảng trị%'

-- 4.Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
-- Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
-- Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.

SELECT 
    customer.customer_code,
    customer.customer_name,
    customer_type.customer_type_name,
    COUNT(service.service_code) AS service_count
FROM
    customer
        JOIN
    contract ON customer.customer_code = contract.customer_code
        JOIN
    service ON contract.service_code = service.service_code
        JOIN
    customer_type ON customer.customer_type = customer_type.customer_type_code
WHERE
    customer_type.customer_type_name = 'Diamond'
GROUP BY customer.customer_code , customer.customer_name
ORDER BY service_count DESC;

-- Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien 
-- (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng. 
-- (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).

SELECT 
    customer.customer_code,
    customer.customer_name,
    customer_type.customer_type_name,
    contract.contract_code,
    service.service_name,
    contract.contract_signed_date,
    contract.contract_end_date,
    CASE
        WHEN details_contract.details_contract_code IS NULL THEN service.service_fee
        ELSE service.service_fee + (details_contract.details_contract_quantity * additional_service.additional_service_price)
    END AS TOTAL
FROM
    customer
        LEFT JOIN
    contract ON customer.customer_code = contract.customer_code
        LEFT JOIN
    service ON contract.service_code = service.service_code
        LEFT JOIN
    customer_type ON customer.customer_type = customer_type.customer_type_code
        LEFT JOIN
    details_contract ON contract.contract_code = details_contract.contract_code
        LEFT JOIN
    additional_service ON details_contract.additional_service_code = additional_service.additional_service_code
ORDER BY TOTAL DESC;

