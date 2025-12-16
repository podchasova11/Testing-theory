## Part 1 DDL
### 1. Create table "employees" with following DDL:
 ```
 id, serial,  primary key,
 employee_name, Varchar(50), not null
```
Result:
```
CREATE TABLE employees (
id SERIAL  PRIMARY KEY,
employee_name VARCHAR(50) NOT NULL
);
```
## 2 Insert 70 values in the table
How I did it:
1. First of all I generated and collected data from special site that generates names for games.
2. I insert all the names into google doc file
3. I use regexp to find and replace space to needed combination of characters and added the rest needed characters
4. I inputed all the result into an array and added into  select with 'unnest' command
```
INSERT INTO employees (employee_name)
SELECT UNNEST (array['Jaden','Gunner','Wilson', 'Calvin', 'Philipp','Colt','Jasper','Roger','William','Daniel','Kade','Simon','Gabriel', 'Myles','Dawson', 'Rose','Ethan','Finley','June','Anastasia','Manuel','Madison','Angela','Stephen','Sloan','Sadie','Baker','Amy','Autumn','Brianna','Donovan','Reynold','Arnold','Leo','Kane','Jacob','Robin','Peter', 'Shirley','Cruz','Gale','John','Mark','Nico','Newton','Harrison','Andrew','Greyson','Katherine','Jasmine','Thompson','Ellie','Hazel','Rachel','Warner','Alyssa','Diamond','Sofia','Lane','Freya','Kayla','Avery','Lukas','King','Nate','Gideon','Tobias','Sheldon','Huxley','Harris']);

SELECT * FROM employees; 
```
## 3. Create table 'salary' with following DDL:
```
 id, Serial  primary key,
 monthly_salary, Int, not null
```
Result:
```
CREATE TABLE salary (
id SERIAL  PRIMARY KEY,
monthly_salary INT NOT NULL);
```
## 4. Insert 16 records
Opt.1
I used the loop to insert values in the table. In the loop I multiplied each value by 100 and insert this value to monthly_salary.
```
DO $$
BEGIN
	FOR i IN 10..25 -- in range from 10 to 25 for i
	LOOP
		INSERT INTO salary(monthly_salary)
		VALUES (i*100); 
	END LOOP;
END $$;
SELECT * FROM salary;
```
Opt.2.
Also you can simply  write following query instead Opt.1
```
insert into salary (monthly_salary)
values  (1000),
		(1100),
		(1200),
		(1300),
		(1400),
		(1500),
		(1600),
		(1700),
		(1800),
		(1900),
		(2000),
		(2100),
		(2200),
		(2300),
		(2400),
		(2500);
```
## 5. Create table 'employee_salary' with following DDL:
```
id. Serial  primary key,
employee_id. Int, not null, unique
salary_id. Int, not null
```
Result:
```
CREATE TABLE employee_salary (
id SERIAL  PRIMARY KEY,
employee_id INT NOT NULL UNIQUE,
salary_id INT NOT NULL);
```
## 6. Insert values in 'employee_salary' table
Here I used a loop to insert values in the table. I declared two variables. 
1. I declared that variable 'var_row' in the table 'employees' is a record
2. I declared that variable 'var_max salary id' is an integer
3. I searched for a maximum salary_id to send to the random()
4. I looped 30 records from 'employees' table
5. I sended the IDs from 'employee' and 'salary'
6. Eventually I inserted the rest 10 records
```
DO $$
DECLARE
	var_row record;
	var_max_salary_id int; 
BEGIN
	SELECT max(id)
	INTO var_max_salary_id
	FROM salary; 

        FOR var_row IN SELECT * FROM employees LIMIT 30 
	LOOP

		INSERT INTO employee_salary(employee_id, salary_id) VALUES (var_row.id, floor(random() * var_max_salary_id + 1)); 
	END LOOP;
END $$;

INSERT INTO employee_salary(employee_id, salary_id) VALUES(generate_series(100, 109), 5);

SELECT * FROM employee_salary;
```
## 7. Create table 'roles'  with following DDL:
```
id. Serial  primary key,
role_name. int, not null, unique
```
Result:
```
CREATE TABLE roles (
id  serial  PRIMARY KEY,
role_name int NOT NULL UNIQUE
);
```
## 8. Change type of role_name
```
ALTER TABLE roles
ALTER COLUMN role_name type VARCHAR(30);
```
## 9. Insert values in the table 'roles'
Opt.1 I used method like in #2
```
INSERT INTO roles(role_name)
SELECT UNNEST (array['Junior Python developer', 'Middle Python developer', 'Senior Python developer', 'Junior Java developer', 'Middle Java developer', 'Senior Java developer', 'Junior JavaScript developer', 'Middle JavaScript developer', 'Senior JavaScript developer', 'Junior Manual QA engineer', 'Middle Manual QA engineer', 'Senior Manual QA engineer', 'Project Manager', 'Designer', 'HR', 'CEO', 'Sales manager', 'Junior Automation QA engineer', 'Middle Automation QA engineer', 'Senior Automation QA engineer']);
```
Opt.2. You can simply write like this:
```
insert into roles (role_name)
values ('Junior Python developer'),
('Middle Python developer'),
('Senior Python developer'),
('Junior Java developer'),
('Middle Java developer'),
('Senior Java developer'),
('Junior JavaScript developer'),
('Middle JavaScript developer'),
('Senior JavaScript developer'),
('Junior Manual QA engineer'),
('Middle Manual QA engineer'),
('Senior Manual QA engineer'),
('Project Manager'),
('Designer'),
('HR'),
('CEO'),
('Sales manager'),
('Junior Automation QA engineer'),
('Middle Automation QA engineer'),
('Senior Automation QA engineer');

SELECT * FROM roles;
```
## 10. Create table 'roles_employee' with following DDL:
```
id. Serial  primary key,
- employee_id. Int, not null, unique (outer key for table employees, field id)
- role_id. Int, not null (outer key for table roles, field id)
```
Result:
```
CREATE TABLE roles_employee(
id SERIAL PRIMARY KEY,
employee_id INT NOT NULL UNIQUE,
role_id INT NOT NULL,
FOREIGN KEY (employee_id) REFERENCES employees(id),
FOREIGN KEY (role_id) REFERENCES roles(id)
);
```
## 11. Insert 40 records into table 'roles_employee'
Opt.1
Here I used a loop to insert values in the table. I declared two variables. 
1. I declared that variable 'var_row' in the table 'employees' is a record
2. I declared that variable 'var_max salary id' is an integer
3. I searched for a maximum role_id to pass to the random()
4. I looped 40 records from 'employees' table
5. I sended the IDs from 'employee' and 'roles'
```
DO $$
DECLARE
	var_row record; 
	var_max_role_id int; 
BEGIN
	SELECT MAX(id)
	INTO var_max_role_id
	FROM roles; 
	FOR var_row IN SELECT * FROM employees LIMIT 40 
	LOOP
		INSERT INTO roles_employee(employee_id, role_id) VALUES (var_row.id, floor(random() * var_max_role_id + 1)); 
	END LOOP;
END $$;
```
--Opt.2.
```
insert into roles_employee (employee_id, role_id)
values (1,2),
(3,3),
(5,5),
(7,7),
(9,9),
(11,11),
(13,13),
(15,15),
(17,17),
(19,19),
(21,2),
(23,4),
(25,6),
(27,8),
(29,10),
(31,12),
(33,14),
(35,16),
(37,18),
(39,20),
(41,19),
(43,17),
(45,15),
(47,13),
(49,11),
(51,9),
(53,7),
(55,5),
(57,3),
(59,1),
(61,18),
(63,16),
(65,14),
(67,12),
(69,10),
(70,8),
(68,6),
(66,4),
(64,2),
(62,2);

SELECT * FROM roles_employee;
```
