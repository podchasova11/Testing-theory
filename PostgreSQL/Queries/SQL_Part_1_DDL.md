# Part 1 DDL
## 1. Create table "employees" with following DDL:
 ```
 id, serial,  primary key,
 employee_name, Varchar(50), not null
```
Result:

```
CREATE TABLE employees(
ID SERIAL PRIMARY KEY,
employee_name VARCHAR(50) NOT NOOL
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
