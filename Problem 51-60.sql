51.
SELECT length('10,A,B') - length(replace('10,A,B',",",""))


52.
SELECT first_name
FROM employees
ORDER BY SUBSTR(first_name, length(first_name)-1, 2)


53.
SELECT dept_no, group_concat(emp_no) AS employees
FROM dept_emp
GROUP BY dept_no


54.
SELECT AVG(salary) AS avg_salary
FROM salaries
WHERE to_date = '9999-01-01'
AND salary NOT IN ( SELECT MAX(salary) FROM salaries)
AND salary NOT IN ( SELECT MIN(salary) FROM salaries)


55.
SELECT *
FROM employees
LIMIT 5,5


56.
SELECT a.emp_no, a.dept_no, b.btype, b.recevied
FROM dept_emp a
LEFT JOIN emp_bonus b
ON a.emp_no = b.emp_no 


57.
SELECT *
FROM employees
WHERE NOT EXISTS ( SELECT *
                   FROM dept_emp
                   WHERE dept_emp.emp_no = employees.emp_no
                 )


58.
SELECT a.*
FROM emp_v a
JOIN employees b
ON a.emp_no = b.emp_no


59.
SELECT c.emp_no, c.first_name, c.last_name, c.btype, d.salary,
CASE WHEN c.btype = 1 THEN d.salary*0.1
     WHEN c.btype = 2 THEN d.salary*0.2
     ELSE d.salary*0.3
END AS bonus
FROM ( SELECT * 
       FROM employees a
       JOIN emp_bonus b
       ON a.emp_no = b.emp_no ) c
JOIN salaries d
ON c.emp_no = d.emp_no
WHERE d.to_date = '9999-01-01'


60.
SELECT a.emp_no, a.salary,
(  
   SELECT SUM(b.salary)
   FROM salaries b
   WHERE b.emp_no <= a.emp_no
   AND b.to_date = '9999-01-01'
) AS running_total
FROM salaries a
WHERE a.to_date = '9999-01-01'
ORDER BY a.emp_no


61.
SELECT c.first_name FROM
( SELECT first_name,
  (  
     SELECT COUNT(*)
     FROM employees b
     WHERE b.first_name <= a.first_name
  ) AS rownum
  FROM employees a
) c
WHERE c.rownum % 2 = 1