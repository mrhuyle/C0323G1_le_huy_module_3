use ss2;
SELECT 
    class.name AS class_name,
    COUNT(student.id) AS number_of_students
FROM
    class
        JOIN
    student ON class.id = student.class_id
GROUP BY class.id;

SELECT class.name AS class_name, MAX(student.point) AS max_point
FROM class JOIN student ON class.id = student.class_id
GROUP BY class.id;

SELECT class.name AS class_name, AVG(student.point) AS avg_point
FROM class JOIN student ON class.id = student.class_id
GROUP BY class.id;

SELECT 'Student' AS type, name, birthday
FROM student
UNION ALL
SELECT 'Instructor' AS type, name, birthday
FROM instructor;

SELECT student.name, student.point, class.name AS class_name
FROM student
JOIN class ON student.class_id = class.id
ORDER BY student.point DESC
LIMIT 3;
