1.
SELECT * 
FROM employees 
WHERE hire_date = (SELECT MAX(hire_date) FROM employees)


2.
SELECT *
FROM employees
WHERE hire_date = (SELECT DISTINCT hire_date
                   FROM employees 
                   ORDER BY hire_date DESC 
                   LIMIT 2,1)


3.
SELECT salaries.*, dept_manager.dept_no
FROM dept_manager
JOIN salaries 
ON dept_manager.emp_no = salaries.emp_no
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'


4.
SELECT a.last_name, a.first_name, b.dept_no
FROM employees a
JOIN dept_emp b
ON a.emp_no = b.emp_no


5. 
SELECT a.last_name, a.first_name, b.dept_no
FROM employees a
LEFT JOIN dept_emp b
ON a.emp_no = b.emp_no


6.
SELECT a.emp_no, b.salary
FROM employees a 
JOIN salaries b
ON a.emp_no = b.emp_no
AND a.hire_date = b.from_date
ORDER BY a.emp_no DESC


7.
SELECT emp_no, COUNT(*) AS t
FROM salaries
GROUP BY emp_no
HAVING COUNT(*) > 15


8.
SELECT DISTINCT salary
FROM salaries
WHERE to_date = '9999-01-01'
ORDER BY salary DESC


SELECT salary
FROM salaries
WHERE to_date = '9999-01-01'
GROUP BY salary
ORDER BY salary DESC


9.
SELECT a.dept_no, a.emp_no, b.salary
FROM dept_manager a
JOIN salaries b
ON a.emp_no = b.emp_no
AND a.to_date='9999-01-01' AND b.to_date='9999-01-01'


10.
SELECT emp_no
FROM employees
WHERE emp_no NOT IN (SELECT emp_no 
                     FROM dept_manager)