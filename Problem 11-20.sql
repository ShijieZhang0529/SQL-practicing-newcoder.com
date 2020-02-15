11.
SELECT a.emp_no, b.emp_no AS manager_no
FROM dept_emp a 
LEFT JOIN dept_manager b 
ON a.dept_no = b.dept_no
WHERE a.emp_no != b.emp_no
AND a.to_date = '9999-01-01' 
AND b.to_date = '9999-01-01' 

12.
SELECT c.dept_no, c.emp_no, c.salary
FROM 
     (
	      SELECT a.emp_no, a.dept_no, b.salary
	      FROM dept_emp a 
	      LEFT JOIN salaries b 
	      ON a.emp_no = b.emp_no
	      WHERE a.to_date='9999-01-01' AND b.to_date='9999-01-01'
      ) c
JOIN 
     (
	      SELECT d.dept_no, MAX(d.salary) AS max_salary
	      FROM 
	      (
		       SELECT a.emp_no, a.dept_no, b.salary
		       FROM dept_emp a 
		       LEFT JOIN salaries b 
		       ON a.emp_no = b.emp_no
		       WHERE a.to_date='9999-01-01' AND b.to_date='9999-01-01'
	      ) d
	      GROUP BY d.dept_no 
     ) e
ON c.dept_no = e.dept_no AND c.salary = e.max_salary
ORDER BY c.dept_no


13.
SELECT title, COUNT(*) AS t
FROM titles 
GROUP BY title
HAVING COUNT(*) >= 2 


14.
SELECT title, COUNT(DISTINCT emp_no) AS t
FROM titles 
GROUP BY title
HAVING COUNT(DISTINCT emp_no) >= 2 


15.
SELECT *
FROM employees
WHERE emp_no % 2 = 1 AND last_name != 'Mary'
ORDER BY hire_date DESC 


16.
SELECT b.title, AVG(b.salary) AS avg
FROM salaries a
JOIN titles b
ON a.emp_no = b.emp_no AND a.to_date='9999-01-01' AND b.to_date='9999-01-01'
GROUP BY b.title


17.
SELECT emp_no, salary
FROM salaries
WHERE to_date='9999-01-01'
AND salary = (SELECT DISTINCT salary
               FROM salaries
               ORDER BY salary DESC LIMIT 1,1)


18.
SELECT a.emp_no, MAX(b.salary) as salary, a.last_name, a.first_name
FROM employees a
JOIN salaries b 
ON a.emp_no = b.emp_no
WHERE b.to_date = '9999-01-01'
AND b.salary NOT IN (SELECT MAX(salary)
                     FROM salaries
                     WHERE to_date = '9999-01-01')


19.
SELECT c.last_name, c.first_name, d.dept_name
FROM (
        SELECT *
        FROM employees a
        LEFT JOIN dept_emp b
        ON a.emp_no = b.emp_no
      ) c
      LEFT JOIN 
      departments d
      ON c.dept_no = d.dept_no


20.
SELECT MAX(salary) - MIN(salary) AS growth
FORM salaries
WHERE emp_no = 10001