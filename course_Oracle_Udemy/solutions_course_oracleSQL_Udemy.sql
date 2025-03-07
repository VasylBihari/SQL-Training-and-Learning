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

--Display job_id information and rounded average salary
SELECT JOB_ID, round (avg (salary)) 
FROM employees 
GROUP BY JOB_ID

--Get a list of manager_ids whose average salary of all of his non-commission subordinates is between 6000 and 9000.
SELECT MANAGER_ID, avg (salary) 
FROM employees  
WHERE commission_pct IS NULL 
GROUP BY MANAGER_ID 
HAVING avg (salary) BETWEEN 6000 AND 9000

--Display detailed information about each employee: first name, last name, department name, job_id, address, country and region (used in query "join")
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, job_id, STREET_ADDRESS, COUNTRY_NAME, REGION_NAME 
FROM countries c
JOIN regions r ON (r.REGION_ID=c.REGION_ID)
JOIN locations l ON (c.COUNTRY_ID=l.COUNTRY_ID)
JOIN departments d ON (l.LOCATION_ID=d.LOCATION_ID)
JOIN employees e ON (e.DEPARTMENT_ID=d.DEPARTMENT_ID)

--Display information about the names of managers who have more than 6 employees under their control, and also display the number of employees who report to them ((used in query "join" from different tables)
SELECT e1.first_name manager_name, COUNT(*) 
FROM employees e1
JOIN employees e2 ON (e1.employee_id=e2.manager_id) 
GROUP BY e1.first_name 
HAVING COUNT (*)>6

--Print the names of all departments that do not have a single employee
SELECT department_name 
FROM departments d 
LEFT OUTER JOIN employees e ON (d.department_id=e.department_id)
WHERE first_name IS NULL
