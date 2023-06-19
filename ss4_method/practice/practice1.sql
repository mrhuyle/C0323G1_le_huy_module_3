USE quan_ly_sinh_vien;

-- 1. Hien thi so luong sinh vien o tung noi
SELECT 
    address, COUNT(address) AS 'number_of_student_at_here'
FROM
    student
GROUP BY address;

-- 2. Tinh dien trung binh cua cac mon hoc cua moi sinh vien

SELECT 
    subject.sub_id, subject.subject_name, AVG(mark.mark)
FROM
    subject
        RIGHT JOIN
    mark ON subject.sub_id = mark.sub_id
GROUP BY subject.sub_id;

-- 3. Hien thi hoc vien co diem trung binh lon hon 15

SELECT 
    student.student_id,
    student.student_name,
    AVG(mark.mark) AS avg_mark
FROM
    student
        RIGHT JOIN
    mark ON student.student_id = mark.student_id
GROUP BY student.student_id
HAVING AVG(mark.mark) > 15;

-- 4. Hien thi hoc vien co diem trung binh lon nhat

SELECT 
    student.student_id, student.student_name, AVG(mark.mark)
FROM
    student
        RIGHT JOIN
    mark ON student.student_id = mark.student_id
GROUP BY student.student_id
HAVING AVG(mark.mark) >= ALL (SELECT 
        AVG(mark.mark)
    FROM
        mark
    GROUP BY mark.student_id);

