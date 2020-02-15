21.
SELECT c.emp_no, (c.salary - d.salary) AS growth
FROM (
        SELECT a.emp_no, b.salary
        FROM employees a
        JOIN salaries b
        ON a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
     ) c
JOIN 
     ( 
     	SELECT a.emp_no, b.salary
     	FROM employees a 
     	JOIN salaries b
     	ON a.emp_no = b.emp_no
     	AND b.from_date = a.hire_date
     ) d
ON c.emp_no = d.emp_no
ORDER BY  growth


22.
SELECT c.dept_no, d.dept_name, COUNT(*) AS sum 
FROM 
	( SELECT *
	  FROM salaries a 
	  JOIN dept_emp b
	  ON a.emp_no = b.emo_no
	) c
JOIN 
    departments d
ON c.dept_no = d.dept_no
GROUP BY c.dept_no


23.




24.
SELECT a.dept_no, a.emp_no, b.salary
FROM dept_emp a
JOIN salaries b
ON a.emp_no = b.emp_no
AND a.to_date = '9999-01-01' AND b.to_date = '9999-01-01'
WHERE a.emp_no NOT IN ( SELECT emp_no
                        FROM dept_manager
                        WHERE to_date = '9999-01-01')


25.
SELECT c.emp_no, d.emp_no AS manager_no, c.salary, d.salary AS manager_salary
FROM ( SELECT a.emp_no, a.dept_no, b.salary
	   FROM dept_emp a
	   JOIN salaries b
	   ON a.emp_no = b.emp_no
	   WHERE a.to_date = '9999-01-01' AND b.to_date = '9999-01-01'
      ) c
LEFT JOIN 
      ( SELECT a.emp_no, a.dept_no, b.salary
	    FROM dept_manager a
	    JOIN salaries b
	    ON a.emp_no = b.emp_no
	    WHERE a.to_date = '9999-01-01' AND b.to_date = '9999-01-01'
      ) d
ON c.dept_no = d.dept_no
WHERE c.salary > d.salary


26.
SELECT d.dept_no, d.dept_name, c.title, COUNT(c.title) AS count
FROM ( SELECT a.emp_no, a.dept_no, b.title
	   FROM dept_emp a
	   JOIN titles b
	   ON a.emp_no = b.emp_no
	   WHERE a.to_date = '9999-01-01' AND b.to_date = '9999-01-01'
      ) c
JOIN departments d
ON c.dept_no = d.dept_no
GROUP BY c.dept_no, c.title


27.
SELECT a.emp_no, a.from_date, (a.salary - b.salary) AS salary_growth
FROM salaries a
JOIN salaries b
ON a.emp_no = b.emp_no
AND (a.salary - b.salary) > 5000
AND (strftime('%Y', a.to_date) - strftime('%Y', b.to_date) = 1 OR
     strftime('%Y', b.to_date) - strftime('%Y', a.to_date) = 1)
ORDER BY salary_growth DESC


28.
SELECT c.name, COUNT(c.name)
FROM ( SELECT a.film_id, a.category_id, b.name
       FROM film_category a
       JOIN category b
       ON a.category_id = b.category_id 
     ) c
     JOIN film d
     ON c.film_id = d.film_id
WHERE d.description LIKE '%robot%'
GROUP BY c.name
HAVING COUNT(c.name) >= 5


SELECT c.name, COUNT(d.film_id) AS amount
FROM(
	    ( 
		   SELECT film_id, category_id, COUNT(film_id) AS counts
	       FROM film_category
	       GROUP BY category_id
	       HAVING COUNT(film_id) >= 5 
	     ) a
	      LEFT JOIN category b
	      ON a.category_id = b.category_id
	  ) c
      LEFT JOIN film d
      ON c.film_id = d.film_id
WHERE d.description LIKE '%robot%'
GROUP BY c.name


29.
SELECT a.film_id, a.title
FROM film a
LEFT JOIN film_category b
ON a.film_id = b.film_id
WHERE b.category_id IS NULL


30.
SELECT a.title, a.description
FROM film a
JOIN film_category b
ON a.film_id = b.film_id
WHERE b.category_id IN (SELECT category_id
                        FROM category
                        WHERE name = 'Action')