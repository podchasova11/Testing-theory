--create 'employee' table
CREATE TABLE employees (
id SERIAL  PRIMARY KEY,
employee_name VARCHAR(50) NOT NULL
);

-- insert 70 records
-- insert 70 records 
INSERT INTO employees (employee_name)
SELECT UNNEST (array['Jaden','Gunner','Wilson', 'Calvin', 'Philipp','Colt','Jasper','Roger','William','Daniel','Kade','Simon','Gabriel', 'Myles','Dawson', 'Rose','Ethan','Finley','June','Anastasia','Manuel','Madison','Angela','Stephen','Sloan','Sadie','Baker','Amy','Autumn','Brianna','Donovan','Reynold','Arnold','Leo','Kane','Jacob','Robin','Peter', 'Shirley','Cruz','Gale','John','Mark','Nico','Newton','Harrison','Andrew','Greyson','Katherine','Jasmine','Thompson','Ellie','Hazel','Rachel','Warner','Alyssa','Diamond','Sofia','Lane','Freya','Kayla','Avery','Lukas','King','Nate','Gideon','Tobias','Sheldon','Huxley','Harris']);

SELECT * FROM employees; 
--create table 'salary'

CREATE TABLE salary (
id SERIAL  PRIMARY KEY,
monthly_salary INT NOT NULL);

--insert 16 records
DO $$
BEGIN
-- in range from 10 to 25 for i
	FOR i IN 10..25 
	LOOP
		INSERT INTO salary(monthly_salary)
-- multiplying each loop value by 100 and inserting this value to monthly_salary
		VALUES (i*100);
	END LOOP;
END $$;
--Opt.2.
--insert into salary (monthly_salary)
--values  (1000),
--		(1100),
--		(1200),
--		(1300),
--		(1400),
--		(1500),
--		(1600),
--		(1700),
--		(1800),
--		(1900),
--		(2000),
--		(2100),
--		(2200),
--		(2300),
--		(2400),
--		(2500);

SELECT * FROM salary;

--create table 'employee_salary'
CREATE TABLE employee_salary (
id SERIAL  PRIMARY KEY,
employee_id INT NOT NULL UNIQUE,
salary_id INT NOT NULL);

--insert values in employee_salary table
DO $$
DECLARE
-- declare that variable 'var_row' in table 'employees' is a record 
	var_row record; 
-- declare that variable 'var_max salary id' is an integer	
        var_max_salary_id int; 
BEGIN
-- searched for a maximum salary_id to send to the random()
	SELECT max(id)
	INTO var_max_salary_id
	FROM salary; 
-- looping 30 records from 'employees' table	
        FOR var_row IN SELECT * FROM employees LIMIT 30 
	LOOP
-- send the IDs from 'employee' and 'salary'
		INSERT INTO employee_salary(employee_id, salary_id) VALUES (var_row.id, floor(random() * var_max_salary_id + 1)); 
	END LOOP;
END $$;
-- insert the rest 10 records:
INSERT INTO employee_salary(employee_id, salary_id) VALUES(generate_series(100, 109), 5);

SELECT * FROM employee_salary;


--create table 'roles'
CREATE TABLE roles (
id  serial  PRIMARY KEY,
role_name int NOT NULL UNIQUE
);
--change type of role_name
ALTER TABLE roles
ALTER COLUMN role_name type varchar(30);

-- insert values
INSERT INTO roles(role_name)
SELECT UNNEST (array['Junior Python developer', 'Middle Python developer', 'Senior Python developer', 'Junior Java developer', 'Middle Java developer', 'Senior Java developer', 'Junior JavaScript developer', 'Middle JavaScript developer', 'Senior JavaScript developer', 'Junior Manual QA engineer', 'Middle Manual QA engineer', 'Senior Manual QA engineer', 'Project Manager', 'Designer', 'HR', 'CEO', 'Sales manager', 'Junior Automation QA engineer', 'Middle Automation QA engineer', 'Senior Automation QA engineer']);



--opt.2.
--insert into roles (role_name)
--values ('Junior Python developer'),
--('Middle Python developer'),
--('Senior Python developer'),
--('Junior Java developer'),
--('Middle Java developer'),
--('Senior Java developer'),
--('Junior JavaScript developer'),
--('Middle JavaScript developer'),
--('Senior JavaScript developer'),
--('Junior Manual QA engineer'),
--('Middle Manual QA engineer'),
--('Senior Manual QA engineer'),
--('Project Manager'),
--('Designer'),
--('HR'),
--('CEO'),
--('Sales manager'),
--('Junior Automation QA engineer'),
--('Middle Automation QA engineer'),
--('Senior Automation QA engineer');

SELECT * FROM roles;

--create table 'roles_employee'

CREATE TABLE roles_employee(
id SERIAL PRIMARY KEY,
employee_id INT NOT NULL UNIQUE,
role_id INT NOT NULL,
FOREIGN KEY (employee_id) REFERENCES employees(id),
FOREIGN KEY (role_id) REFERENCES roles(id)
);



--insert 40 records
DO $$
DECLARE
-- declare that variable 'var_row' in table 'employees' is a record 
	var_row record; 
-- declare that variable 'max role id' is an integer
	var_max_role_id int; 
BEGIN
-- searching for a maximum role_id to pass to the random()
	SELECT MAX(id)
	INTO var_max_role_id
	FROM roles; 
-- looping 40 records from 'employees' table
	FOR var_row IN SELECT * FROM employees LIMIT 40 
	LOOP
-- send the IDs from 'employee' and 'roles'
		INSERT INTO roles_employee(employee_id, role_id) VALUES (var_row.id, floor(random() * var_max_role_id + 1)); 
	END LOOP;
END $$;

--Opt.2.
--insert into roles_employee (employee_id, role_id)
--values (1,2),
--(3,3),
--(5,5),
--(7,7),
--(9,9),
--(11,11),
--(13,13),
--(15,15),
--(17,17),
--(19,19),
--(21,2),
--(23,4),
--(25,6),
--(27,8),
--(29,10),
--(31,12),
--(33,14),
--(35,16),
--(37,18),
--(39,20),
--(41,19),
--(43,17),
--(45,15),
--(47,13),
--(49,11),
--(51,9),
--(53,7),
--(55,5),
--(57,3),
--(59,1),
--(61,18),
--(63,16),
--(65,14),
--(67,12),
--(69,10),
--(70,8),
--(68,6),
--(66,4),
--(64,2),
--(62,2);

SELECT * FROM roles_employee;

_________________________________

CREATE TABLE public.students (
	id SERIAL4 NOT NULL,
	"name" VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	"password" VARCHAR(50) NOT NULL,
	created_on TIMESTAMP NOT NULL,
	CONSTRAINT students_email_key UNIQUE (email),
	CONSTRAINT students_pkey PRIMARY KEY (id)
);

-- Show all information in the table 'Students'
SELECT * FROM students;

--Show all students of the table 'Students'
SELECT name FROM students;

--Show ids of the table 'Students'
SELECT id FROM students;

--Show all names of the table 'Students'
SELECT name FROM students;

--Show all emails of the table 'Students'
SELECT email FROM students;

--Show all names and emails of the table 'Students'
SELECT name, email FROM students;

--Show all ids, names, emails, dates of creation of the table 'Students'
SELECT id, name, email, created_on  FROM students;

--Show all users of the table 'Students' with password 12333
SELECT id
FROM students
WHERE password = '12333';

--Show all users of the table 'Students' which were created on 2021-03-26 00:00:00
SELECT id, name
FROM students
WHERE created_on = '2021-03-26 00:00:00';

--Show all users of the table 'Students'  which  names contain "Anna" 
SELECT id, name
FROM students
WHERE name   LIKE '%Anna%';

--Show all users of the table 'Students' which names contain "8" in the end of the name
SELECT id, name
FROM students
WHERE name   LIKE '%8';

--Show all users of the table 'Students' which names contain "a" 
SELECT id, name
FROM students
WHERE name   LIKE '%a%';


--Show all users of the table 'Students' which were created on 2021-07-12 00:00:00
SELECT id, name
FROM students
WHERE created_on = '2021-07-12 00:00:00';

--Show all users of the table 'Students' which were created on 2021-07-12 00:00:00 and have password 1m313
SELECT id, name
FROM students
WHERE created_on = '2021-07-12 00:00:00'
AND password = '1m313';

--Show all users of the table 'Students' which were created on 2021-07-12 00:00:00 and name contained "Andrey"
SELECT id, name
FROM students
WHERE created_on = '2021-07-12 00:00:00'
AND name   LIKE '%Andrey%';

--Show all users of the table 'Students' which were created on 2021-07-12 00:00:00 and name contained "8"
SELECT id, name
FROM students
WHERE created_on = '2021-07-12 00:00:00'
AND name   LIKE '%8%';

--Show user of the table 'Students' which have id = 110
SELECT id, name
FROM students
WHERE id = 110;

--Show user of the table 'Students' which have id = 153
SELECT id, name
FROM students
WHERE id = 153;

--Show users of the table 'Students' which have id > 140
SELECT id, name
FROM students
WHERE id > 140;

--Show users of the table 'Students' which have id < 130
SELECT id, name
FROM students
WHERE id < 130;

--Show users of the table 'Students' which have id < 127 or > 188
SELECT id, name
FROM students
WHERE id < 127
OR id > 188 ;

--Show users of the table 'Students' which have id <= 137
SELECT id, name
FROM students
WHERE id <= 137;

--Show users of the table 'Students' which have id >= 137
SELECT id, name
FROM students
WHERE id >= 137;

--Show users of the table 'Students' which have id more than 180 and less than 190
SELECT id, name
FROM students
WHERE id BETWEEN 180 AND 190;

--Show users of the table 'Students' which have id between 180 and 190
SELECT id, name
FROM students
WHERE id BETWEEN 180 AND 190;

--Show users of the table 'Students' which have password in range 12333, 1m313, 123313
SELECT id, name, password
FROM students
WHERE password  IN ('12333', '1m313', '123313');

--Show users of the table 'Students' which were created in range 2020-10-03 00:00:00, 2021-05-19 00:00:00, 2021-03-26 00:00:00
 
SELECT id, name, created_on
FROM students
WHERE created_on  IN ('2020-10-03 00:00:00', '2021-05-19 00:00:00', '2021-03-26 00:00:00');

--Show minimum id of the table 'Students'
SELECT Min(id)
FROM students;

--Show maximum id of the table 'Students'
SELECT Max(id)
FROM students;

--Show number of users of the table 'Students'
SELECT count(id) AS number_of_users
FROM students;

--Show all names of the table 'Students' order by creation  date ascending order
SELECT id, name, created_on
FROM students
ORDER BY created_on;

--Show all names of the table 'Students' order by creation  date descending order
SELECT id, name, created_on
FROM students
order BY created_on DESC;


________________________________

--1. Show all workers names and their salary 
-- 'INNER JOIN' is equal to 'JOIN'
--[Inner] JOIN (default) - A join that displays only the rows that have a match in both joined tables :
SELECT employee_name AS workers, monthly_salary
FROM employees e
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id;

--or with clause 'WHERE':

SELECT employee_name AS workers, monthly_salary
FROM employees e, salary s, employee_salary es
WHERE e.id = es.employee_id
AND s.id = es.salary_id;

--2. Show all workers names and their salary where salary <2000 

SELECT employee_name AS workers, monthly_salary
FROM employees e
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE monthly_salary < '2000';


--or with clause 'WHERE':

SELECT employee_name AS workers, monthly_salary
FROM employees e, salary s, employee_salary es
WHERE e.id = es.employee_id
AND s.id = es.salary_id
AND monthly_salary < '2000';





--OUTER JOIN - A join that includes rows even if they do not have related rows in the joined table. There are 3 types of outer (unmatched rows to be included) joins:
--– LEFT [OUTER] JOIN  show all matched rows of left and right tables (as in inner join) and leftovers of left table (where there is no value would be null).
--– RIGHT [OUTER] JOIN show all matched rows of left and right tables (as in inner join) and leftovers of right table (where there is no value would be null)
--– FULL [OUTER] JOIN show all rows of right and left tables (as in inner join) and leftovers of both tables (where there is no value would be null)

--CROSS JOIN - A join whose result set includes one row for each possible pairing of rows from the two tables. 

--3. show null workers where salary exists

SELECT employee_id, employee_name AS workers, monthly_salary 
FROM 
employee_salary es LEFT JOIN employees e
ON es.employee_id = e.id
JOIN salary s
ON es.salary_id = s.id
WHERE employee_name IS NULL;

-- or

SELECT employee_name, employee_id, monthly_salary
FROM 
employees e  RIGHT JOIN employee_salary es
ON es.employee_id = e.id
JOIN salary s
ON es.salary_id = s.id
WHERE employee_name IS NULL;


--4 Show null roles where salary exists and salary is less 2000
SELECT employee_id, employee_name AS workers, monthly_salary 
FROM 
employee_salary es LEFT JOIN employees e 
ON es.employee_id = e.id
JOIN salary s 
ON es.salary_id = s.id
WHERE employee_name IS NULL
AND monthly_salary < 2000;

--5. Show all workers who doesn't have salary
SELECT employee_name AS workers, salary_id 
FROM employees e
LEFT JOIN  employee_salary es
ON es.employee_id = e.id
WHERE salary_id IS NULL;

--6. Show all workers with their roles
SELECT employee_id, employee_name AS workers, role_name
FROM employees e
JOIN roles_employee  re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id;

--7. Show names, roles only for Java developers
SELECT employee_name, role_name
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
WHERE role_name LIKE '%Java developer%';

--8. Show names, roles only for Python developers
SELECT employee_name, role_name
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
WHERE role_name LIKE '%Python%';

--9. Show names, roles only for QA engineers
SELECT employee_name, role_name
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
WHERE role_name LIKE '%QA engineer%';

--10. Show names, roles only for Manual QA engineers
SELECT employee_name, role_name
FROM employees e 
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
WHERE role_name LIKE '%Manual QA%';

--11. Show names, roles only for Automation QA engineers
SELECT employee_name, role_name
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
WHERE role_name LIKE '%Automation QA%';

--12. Show names, roles, salary only for Junior specialists
SELECT employee_name, role_name, monthly_salary
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Junior%';

--13. Show names, roles, salary only for Middle specialists
SELECT employee_name, role_name, monthly_salary
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Middle%';

--14. Show names, roles, salary only for Senior specialists
SELECT employee_name, role_name, monthly_salary
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Senior%';

--15. Show  roles, salary only for Java developers
SELECT  role_name, monthly_salary
FROM  roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Java developer%';

--16. Show  roles, salary only for Python developers
SELECT  role_name, monthly_salary
FROM  roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Python developer%';

--17. Show  names, roles, salary  for Junior Python developers
SELECT  employee_name, role_name, monthly_salary
FROM  employees e
JOIN roles_employee re
ON e.id = re.employee_id 
JOIN roles r
ON r.id = re.role_id
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Junior Python%'

--18. Show  names, roles, salary  for Middle JavaScript developers
SELECT  employee_name, role_name, monthly_salary
FROM  employees e
JOIN roles_employee re
ON e.id = re.employee_id 
JOIN roles r
ON r.id = re.role_id
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Middle JavaScript developer%';

--19. Show  names, roles, salary  for Senior Java developers
SELECT  employee_name, role_name, monthly_salary
FROM  employees e
JOIN roles_employee re
ON e.id = re.employee_id 
JOIN roles r
ON r.id = re.role_id
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Senior Java developer%';

--20. Show  roles, salary  for Junior QA engineers
SELECT  role_name, monthly_salary
FROM  roles r
JOIN roles_employee re
ON r.id = re.role_id
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Junior%QA%';

--21. Show  average salary  for all Junior specialists
--Opt.1.
SELECT AVG(monthly_salary) AS average_salary
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Junior%' ;

--Opt.2
--Show  average salary  for every  Junior category of specialists
SELECT AVG(monthly_salary) AS average_salary, role_name
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Junior%' 
GROUP BY role_name;

--22. Show  summ salary  of all JavaScript developers
SELECT SUM(monthly_salary) AS sum_salary
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%JavaScript%' ;
 
--23. Show minimum salary of QA engineers
SELECT MIN(monthly_salary) AS min_salary
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%QA%' ;
 
--24. Show maximum salary of QA engineers
SELECT MAX(monthly_salary) AS max_salary
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE  role_name LIKE '%QA%' ;


--25. Show the number of all QA engineers
SELECT COUNT(*) AS number_of_QA_specialists
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employees e
ON e.id = re.employee_id
WHERE role_name LIKE '%QA%' ;

--Checking:
select * from roles_employee re where re.role_id in (10,11,12,18,19,20);

--26. Show the number of Middle specialists
SELECT COUNT(*) AS number_of_middle_specialists
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employees e
ON e.id = re.employee_id
WHERE role_name LIKE '%Middle%' ;

--Checking:
select * from roles_employee re where re.role_id in (2,5,8,11,19);


--27. Show the number of developers
SELECT COUNT(*) AS number_of_developers
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employees   e   
ON e.id = re.employee_id
WHERE role_name LIKE '%developer%' ;

--Checking:
select * from roles_employee re where re.role_id in (1,2,3,4,5,6,7,8,9);

--28. Show  summ salary  of all  developers
SELECT SUM(monthly_salary) AS sum_salary_developers
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%developer%' ;

--29. Show names, roles and salary of all specialists in ascending order
SELECT employee_name, role_name, monthly_salary
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
ORDER BY monthly_salary ;

--30. Show names, roles and salary of all specialists in ascending order for workers with salary from 1700 to 2300
SELECT employee_name, role_name, monthly_salary
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE monthly_salary BETWEEN 1700 AND 2300
ORDER BY monthly_salary ;


--31. Show names, roles and salary of all specialists in ascending order for workers with salary less than 2300
SELECT employee_name, role_name, monthly_salary
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE monthly_salary < 2300
ORDER BY monthly_salary ;

--32. Show names, roles and salary of all specialists in ascending order for workers with salary equal to 1100, 1500, 2000
SELECT employee_name, role_name, monthly_salary
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE monthly_salary IN (1100, 1500, 2000)
ORDER BY monthly_salary ;


































































