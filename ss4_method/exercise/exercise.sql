USE quan_ly_sinh_vien;

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.

SELECT 
    *
FROM
    `subject`
WHERE
    credit = (SELECT 
            MAX(credit)
        FROM
            `subject`);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.

SELECT 
    subject.sub_id,
    subject.subject_name,
    subject.credit,
    subject.status,
    mark.mark
FROM
    subject
        JOIN
    mark ON subject.sub_id = mark.sub_id
WHERE
    mark.mark = (SELECT 
            MAX(mark)
        FROM
            mark);
            
-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần

SELECT 
    student.student_id, student.student_name, AVG(mark.mark)
FROM
    student
        JOIN
    mark ON student.student_id = mark.student_id
GROUP BY student.student_id
ORDER BY AVG(mark.mark) DESC;