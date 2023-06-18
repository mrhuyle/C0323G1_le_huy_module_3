USE furama_database;

-- 6. Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu 
-- của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).

SELECT service.service_code, service.service_name, service.service_area, service.service_fee, service_type.service_type_name, contract.contract_signed_date
FROM service
LEFT JOIN contract ON service.service_code = contract.service_code
LEFT JOIN service_type ON service.service_type_code = service_type.service_type_code
WHERE contract.contract_signed_date IS NULL 
OR contract.contract_signed_date
NOT BETWEEN '2021-01-01' AND '2021-03-31';

-- 7. Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu 
-- của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020 
-- nhưng chưa từng được khách hàng đặt phòng trong năm 2021.

SELECT service.service_code, service.service_name, service.service_area, service.service_occupancy, service.service_fee, service_type.service_type_name, contract.contract_signed_date
FROM service
LEFT JOIN contract ON service.service_code = contract.service_code
LEFT JOIN service_type ON service.service_type_code = service_type.service_type_code
WHERE YEAR(contract.contract_signed_date) = 2020
  AND service.service_code NOT IN (
    SELECT contract.service_code
    FROM contract
    WHERE YEAR(contract.contract_signed_date) = 2021
  );
  
-- 8. Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.

SELECT DISTINCT customer_name
FROM customer;

-- 9. Thực hiện thống kê doanh thu theo tháng, 
-- nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.

SELECT
    MONTH(contract.contract_end_date) AS month,
    SUM(service.service_fee) AS revenue,
    COUNT(DISTINCT contract.customer_code) AS number_of_customers
FROM
    contract
JOIN
    service ON contract.service_code = service.service_code
WHERE
    YEAR(contract.contract_end_date) = 2021
GROUP BY
    MONTH(contract.contract_end_date);
    
-- 10. Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. 
-- Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).

SELECT contract.contract_code, contract.contract_signed_date, contract.contract_end_date, contract.contract_deposit, SUM(details_contract.details_contract_quantity) AS number_of_additional_service
FROM contract
RIGHT JOIN details_contract ON contract.contract_code = details_contract.contract_code
GROUP BY contract.contract_code;