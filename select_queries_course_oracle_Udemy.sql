-- Get a list of all employees named David.
SELECT * 
FROM employees 
WHERE first_name = 'David'

-- Display information about the name, surname, salary and department number for employees from the 50th department with a salary greater than 4000.
SELECT first_name, last_name, salary, department_id 
FROM employees
WHERE department_id='50' 
AND salary > 4000 

-- Get a list of all employees whose second and last letter in their name is 'a'
SELECT * 
FROM employees 
WHERE first_name like '_a%a'

-- Get a list of all employees whose name contains the '%' character
SELECT * 
FROM employees 
WHERE first_name LIKE '%\%%' ESCAPE '\'

-- Display job_id, name and salary information for employees whose job id is greater than or equal to 120  and job_id is not equal to IT_PROG. Sort the rows by job_id (ascending order) and name (descending order) 
SELECT job_id, first_name, salary 
FROM employees
WHERE job_id >=120 
AND job_id != 'IT_PROG'
ORDER BY job_id, first_name desc

