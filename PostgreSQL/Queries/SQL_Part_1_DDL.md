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
