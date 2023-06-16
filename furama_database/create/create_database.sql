CREATE DATABASE furama_database;
USE furama_database;

CREATE TABLE role (
    role_code INT NOT NULL PRIMARY KEY,
    role_name VARCHAR(45)
);

CREATE TABLE education_level (
    education_level_code INT NOT NULL PRIMARY KEY,
    education_level_name VARCHAR(45)
);

CREATE TABLE department (
    department_code INT NOT NULL PRIMARY KEY,
    department_name VARCHAR(45)
);

CREATE TABLE employee (
    employee_code INT NOT NULL PRIMARY KEY,
    employee_name VARCHAR(45) NOT NULL,
    employee_dob DATE NOT NULL,
    employee_id VARCHAR(45) NOT NULL,
    employee_salary DOUBLE NOT NULL,
    employee_phone VARCHAR(45) NOT NULL,
    employee_email VARCHAR(45),
    employee_address VARCHAR(45),
    role_code INT,
    education_level_code INT,
    department_code INT,
    FOREIGN KEY (role_code)
        REFERENCES role (role_code),
    FOREIGN KEY (education_level_code)
        REFERENCES education_level (education_level_code),
    FOREIGN KEY (department_code)
        REFERENCES department (department_code)
);

CREATE TABLE customer_type (
    customer_type_code INT NOT NULL PRIMARY KEY,
    customer_type_name VARCHAR(45)
);

CREATE TABLE customer (
    customer_code INT NOT NULL PRIMARY KEY,
    customer_name VARCHAR(45) NOT NULL,
    customer_dob DATE NOT NULL,
    customer_gender BIT(1) NOT NULL,
    customer_id VARCHAR(45) NOT NULL,
    customer_phone VARCHAR(45) NOT NULL,
    customer_email VARCHAR(45),
    customer_address VARCHAR(45),
	customer_type INT,
    FOREIGN KEY (customer_type)
        REFERENCES customer_type (customer_type_code)
);

CREATE TABLE rent_type (
    rent_type_code INT NOT NULL PRIMARY KEY,
    rent_type_name VARCHAR(45)
);

CREATE TABLE service_type (
    service_type_code INT NOT NULL PRIMARY KEY,
    service_type_name VARCHAR(45)
);

CREATE TABLE service (
    service_code INT NOT NULL PRIMARY KEY,
    service_name VARCHAR(45) NOT NULL,
    service_area INT,
    service_fee DOUBLE NOT NULL,
    service_occupancy INT,
    service_standard VARCHAR(45),
    service_another_description VARCHAR(45),
    service_pool_area DOUBLE,
    service_floor_number INT,
    rent_type_code INT,
    FOREIGN KEY (rent_type_code)
        REFERENCES rent_type (rent_type_code),
    service_type_code INT,
    FOREIGN KEY (service_type_code)
        REFERENCES service_type (service_type_code)
);

CREATE TABLE additional_service (
    additional_service_code INT NOT NULL PRIMARY KEY,
    additional_service_name VARCHAR(45) NOT NULL,
    additional_service_price DOUBLE NOT NULL,
    additional_service_unit VARCHAR(10) NOT NULL,
    additional_service_status VARCHAR(45)
);

CREATE TABLE contract (
    contract_code INT NOT NULL PRIMARY KEY,
    contract_signed_date DATETIME NOT NULL,
    contract_end_date DATETIME NOT NULL,
    contract_deposit DOUBLE NOT NULL,
    employee_code INT,
    FOREIGN KEY (employee_code)
        REFERENCES employee (employee_code),
    customer_code INT,
    FOREIGN KEY (customer_code)
        REFERENCES customer (customer_code),
    service_code INT,
    FOREIGN KEY (service_code)
        REFERENCES service (service_code)
);

CREATE TABLE details_contract (
    details_contract_code INT NOT NULL PRIMARY KEY,
	details_contract_quantity INT NOT NULL,
    contract_code INT,
    FOREIGN KEY (contract_code)
        REFERENCES contract (contract_code),
    additional_service_code INT,
    FOREIGN KEY (additional_service_code)
        REFERENCES additional_service (additional_service_code)
);

