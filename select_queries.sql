# Get a list of all employees named David.
SELECT * 
FROM employees 
WHERE first_name = 'David'

# Display information about the name, surname, salary and department number for employees from the 50th department with a salary greater than 4000.
SELECT first_name, last_name, salary, department_id 
FROM employees
WHERE department_id='50' 
AND salary > 4000 