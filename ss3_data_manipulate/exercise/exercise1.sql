use quan_ly_sinh_vien;

SELECT 
    *
FROM
    student
WHERE
    student_name LIKE 'h%';

SELECT 
    *
FROM
    class
WHERE
    MONTH(start_date) = 12;

SELECT 
    *
FROM
    subject
WHERE
    credit >= 3 AND credit <= 5;

UPDATE student 
SET 
    class_id = 2
WHERE
    student_id = 1;

SELECT 
    stu.student_name, su.subject_name, m.mark
FROM
    student stu
        INNER JOIN
    mark m ON stu.student_id = m.student_id
        INNER JOIN
    subject su ON m.sub_id = su.sub_id
ORDER BY m.mark ASC , stu.student_name ASC;