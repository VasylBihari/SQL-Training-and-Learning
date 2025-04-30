/*Схема таблиць : 
Таблиця Students:
Назва стовпця	Тип даних	Опис
StudentID	INT	Унікальний ідентифікатор студента (первинний ключ)
FirstName	VARCHAR(50)	Ім'я студента
LastName	VARCHAR(50)	Прізвище студента
City	VARCHAR(50)	Місто проживання студента
EnrollmentYear	INT	Рік вступу до університету

Таблиця Courses:
Назва стовпця	Тип даних	Опис
CourseID	INT	Унікальний ідентифікатор курсу (первинний ключ)
CourseName	VARCHAR(100)	Назва курсу
Credits	INT	Кількість кредитів курсу
DepartmentID	INT	Ідентифікатор факультету (зовнішній ключ, посилається на Departments)

Таблиця Enrollments:
Назва стовпця	Тип даних	Опис
EnrollmentID	INT	Унікальний ідентифікатор запису (первинний ключ)
StudentID	INT	Ідентифікатор студента (зовнішній ключ, посилається на Students)
CourseID	INT	Ідентифікатор курсу (зовнішній ключ, посилається на Courses)
EnrollmentDate	DATE	Дата зарахування на курс
Grade	DECIMAL(3, 2)	Оцінка студента за курс

Таблиця Departments:
Назва стовпця	Тип даних	Опис
DepartmentID	INT	Унікальний ідентифікатор факультету (первинний ключ)
DepartmentName	VARCHAR(100)	Назва факультету
*/


/*Напишіть SQL-запит, щоб знайти імена та прізвища студентів, які вступили до університету у 2023 році та проживають у місті 'Львів'.*/

SELECT 
	  firstname
	, lastname
FROM students
WHERE city = 'Lviv'
AND enrollmentyear = 2023;

/*Напишіть SQL-запит, щоб вивести назви курсів та кількість студентів, зарахованих на кожен курс, відсортованих за кількістю студентів у спадному порядку.*/

SELECT 
    c.coursename 
    ,COUNT(studentid) AS student_count
FROM courses c
LEFT JOIN enrollments en ON c.courseid = en.courseid
GROUP BY coursename
ORDER BY student_count DESC;

/*Напишіть SQL-запит, щоб знайти студентів, які мають середній бал вище середнього балу всіх студентів. Виведіть їхні імена, прізвища та середній бал.*/

SELECT 
	firstname
	, lastname
	, ROUND(AVG (grade),2) as avg_grades
FROM students s
LEFT JOIN enrollments en ON s.studentid = en.studentid
GROUP BY s.studentid, s.firstname, s.lastname
HAVING AVG(grade)>(
	SELECT AVG (grade)
	FROM enrollments
);

/*Напишіть SQL-запит, використовуючи віконну функцію, щоб для кожного студента вивести його ім'я, 
прізвище та середній бал серед усіх курсів, на які він зарахований, а також загальний середній бал по всіх студентах.*/

SELECT 
    s.firstname,
    s.lastname,
    ROUND(AVG(en.grade),2) AS avg_student_grade,
    ROUND(AVG(AVG(en.grade)) OVER (),2) AS overall_avg_grade
FROM students s
LEFT JOIN enrollments en ON s.studentid = en.studentid
GROUP BY s.studentid, s.firstname, s.lastname;

/*Напишіть SQL-запит, щоб знайти назви факультетів, на яких немає жодного курсу з кількістю кредитів менше ніж 3.*/

SELECT 
	DepartmentName
FROM Departments d
LEFT JOIN courses c ON d.DepartmentID=c.DepartmentID
GROUP BY DepartmentName
HAVING MIN(c.credits) >= 3 OR MIN(c.credits) IS NULL;

/*Напишіть SQL-запит, щоб знайти двох студентів з найвищими середніми балами. Виведіть їхні імена, прізвища та середні бали.*/

SELECT 
	firstname
	,lastname
	, ROUND(AVG (grade),2) AS avg_grades
FROM students s
LEFT JOIN Enrollments en ON s.studentid = en.studentid
GROUP BY s.firstname, s.lastname
ORDER BY avg_grades DESC
LIMIT 2;

/*Напишіть SQL-запит, щоб для кожного курсу знайти студента з найвищою оцінкою на цьому курсі. 
Виведіть назву курсу, ім'я та прізвище студента, а також його оцінку. (У випадку однакових найвищих оцінок, виведіть одного з них).*/

SELECT
	CourseName
	, FirstName
	, LastName
	, Grade
FROM Enrollments en
JOIN Students s ON en.studentid = s.studentid
JOIN Courses c ON en.courseid = c.courseid
WHERE (en.courseid, en.grade) IN (
    SELECT courseid, MAX(grade)
    FROM Enrollments
    GROUP BY courseid
);

/*Напишіть SQL-запит, щоб оновити рік вступу для всіх студентів, які проживають у місті 'Харків', на 2024.*/

UPDATE students
SET EnrollmentYear = 2024
WHERE 	City = 'Kharkiv';

/*Напишіть SQL-запит, щоб видалити всі курси, на які не зараховано жодного студента.*/

DELETE FROM courses
WHERE courseid NOT IN (
    SELECT DISTINCT courseid
    FROM enrollments
);

/*Напишіть SQL-запит, щоб створити представлення (VIEW) під назвою StudentCourseGrades, яке відображає імена та прізвища студентів, назви курсів та їхні оцінки.*/

CREATE VIEW StudentCourseGrades AS
SELECT 
    s.firstname,
    s.lastname,
    c.coursename,
    en.grade
FROM Enrollments en
JOIN Students s ON en.studentid = s.studentid
JOIN Courses c ON en.courseid = c.courseid;
