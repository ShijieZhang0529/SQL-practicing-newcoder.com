31.
EXPLAIN SELECT * FROM employees


32.
SELECT last_name||" "||first_name AS Name
FROM employees


33. 
CREATE TABLE actor(
	actor_id smallint(5) NOT NULL PRIMARY KEY,
	first_name varchar(45) NOT NULL,
	last_name varchar(45) NOT NULL,
	last_update timestamp NOT NULL DEFAULT (datetime('now','localtime'))
)


34.
INSERT INTO actor 
VALUES (1,'PENELOPE','GUINESS','2006-02-15 12:34:33'),
       (2, 'NICK', 'WAHLBERG', '2006-02-15 12:34:33')


35.
INSERT OR IGNORE INTO actor
VALUES (3,'ED','CHASE','2006-02-15 12:34:33')


36.
CREATE TABLE actor_name
(
first_name varchar(45) NOT NULL,
last_name varchar(45) NOT NULL
);
INSERT INTO actor_name (first_name,last_name)
SELECT first_name, last_name FROM actor;


37.
CREATE UNIQUE INDEX uniq_idx_firstname ON actor(first_name);
CREATE INDEX idx_lastname ON actor(last_name);


38.
CREATE VIEW actor_name_view AS
SELECT first_name AS first_name_v,last_name AS last_name_v
FROM actor

39.
SELECT * FROM salaries
INDEXED BY idx_emp_no
WHERE emp_no='10005'


40.
ALTER TABLE actor
ADD COLUMN create_date datetime NOT NULL DEFAULT '0000-00-00 00:00:00'