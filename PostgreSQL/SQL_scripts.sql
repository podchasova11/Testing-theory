--create 'employee' table

CREATE TABLE employees (
id SERIAL  PRIMARY KEY,
employee_name VARCHAR(50) NOT NULL
);

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


