use ss2;
SELECT * FROM student
WHERE class_id IS NOT NULL;

SELECT * FROM student;

SELECT * FROM student
WHERE `name` LIKE '%hai' OR `name` LIKE '%huynh';

SELECT * FROM student
WHERE point > 5;

SELECT * FROM student
WHERE `name` LIKE 'nguyen%';

SELECT 
    GROUP_CONCAT(name) AS student_names, `point`
FROM
    student
GROUP BY `point`;

SELECT 
    GROUP_CONCAT(name) AS student_names, `point`
FROM
    student
WHERE point > 5
GROUP BY `point`;

SELECT COUNT(*) AS num_students, GROUP_CONCAT(name) AS student_names, `point`
FROM student
WHERE `point` > 5
GROUP BY `point`
HAVING COUNT(*) >= 2;

SELECT id, name, class_id
FROM student
WHERE class_id = (SELECT id FROM class WHERE name = 'c1121g1')
ORDER BY name ASC;

