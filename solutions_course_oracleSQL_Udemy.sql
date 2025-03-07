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

-- Get job_id, name and salary information for employees whose job id is greater than or equal to 120  and job_id is not equal to IT_PROG. Sort the rows by job_id (ascending order) and name (descending order). 
SELECT job_id, first_name, salary
FROM employees
WHERE job_id >=120 
AND job_id != 'IT_PROG'
ORDER BY job_id, first_name desc

-- Get a list of all employees whose name length is greater than 10.
SELECT *
FROM employees 
WHERE length (first_name)>10

-- Get a list of all employees whose salary is a multiple of 1000.
SELECT * 
FROM employees 
WHERE MOD(salary, 1000) = 0;

-- Display the date of next Friday.
SELECT NEXT_DAY ('27-01-23', 'FRIDAY') 
FROM dual

-- Print the phone number by replacing all '.' in the PHONE_NUMBER value with '-'.
SELECT REPLACE (PHONE_NUMBER,'.','-') 
FROM EMPLOYEES

-- Display information about: the date the employee was hired, the date that was half a year after the employee was hired, the date of the last day in the month the employee was hired.
SELECT hire_date, add_months(hire_date,6),last_day (hire_date) 
FROM employees

--Get a list of workers with 20% salary increases. Show salary in the format: $28,800.00
SELECT first_name, last_name,  TO_CHAR (salary*1.2, '$99,999.00') 
FROM employees

--Display the employee's name, his commission, and information about the presence of bonuses to the salary - whether he has a commission (Yes/No).
SELECT FIRST_NAME, COMMISSION_PCT, NVL2 (COMMISSION_PCT, 'Yes', 'No')  
FROM hr.employees

--Get a report by department_id with minimum and maximum salary, earliest and latest start date and number of employees. Sort by number of employees (descending).
SELECT DEPARTMENT_ID, min (salary), max (salary), max (hire_date), min (hire_date), COUNT (*) 
FROM employees 
GROUP BY DEPARTMENT_ID 
ORDER BY COUNT (*) DESC;

--Display the day of the week and the number of employees hired on that day
SELECT to_char (hire_date, 'DAY'), COUNT (*) 
FROM employees 
GROUP BY to_char (hire_date, 'DAY')

-- Get the IDs of departments that employ more than 30 employees and whose salary is more than 300,000.
SELECT DEPARTMENT_ID, COUNT (*), sum (salary)  
FROM employees 
GROUP BY DEPARTMENT_ID 
HAVING COUNT (*)>30 
AND sum (salary)>300000

--
