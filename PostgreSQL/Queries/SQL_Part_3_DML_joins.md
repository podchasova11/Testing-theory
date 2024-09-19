# Part 3 Joins
## 1. Show all workers names and their salary 
+ 'INNER JOIN' is equal to 'JOIN'
+ [INNER] JOIN (default) - A join that displays only the rows that have a match in both joined tables :
```
SELECT employee_name AS workers, monthly_salary
FROM employees e
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id;
```
### or with clause `WHERE`:
```
SELECT employee_name AS workers, monthly_salary
FROM employees e, salary s, employee_salary es
WHERE e.id = es.employee_id
AND s.id = es.salary_id;
```
## 2. Show all workers names and their salary where salary <2000 
```
SELECT employee_name AS workers, monthly_salary
FROM employees e
JOIN employee_salary es
ON e.id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE monthly_salary < '2000';
```

### or with clause `WHERE`:
```
SELECT employee_name AS workers, monthly_salary
FROM employees e, salary s, employee_salary es
WHERE e.id = es.employee_id
AND s.id = es.salary_id
AND monthly_salary < '2000';
```
### THEORY:
```
OUTER JOIN - A join that includes rows even if they do not have related rows in the joined table. There are 3 types of outer (unmatched rows to be included) joins:
LEFT [OUTER] JOIN  show all matched rows of left and right tables (as in inner join) and leftovers of left table (where there is no value would be null).
RIGHT [OUTER] JOIN show all matched rows of left and right tables (as in inner join) and leftovers of right table (where there is no value would be null)
FULL [OUTER] JOIN show all rows of right and left tables (as in inner join) and leftovers of both tables (where there is no value would be null) 
CROSS JOIN - A join whose result set includes one row for each possible pairing of rows from the two tables. 
```
## 3. show null workers where salary exists
```
SELECT employee_id, employee_name AS workers, monthly_salary 
FROM 
employee_salary es LEFT JOIN employees e
ON es.employee_id = e.id
JOIN salary s
ON es.salary_id = s.id
WHERE employee_name IS NULL;
```
or
```
SELECT employee_name, employee_id, monthly_salary
FROM 
employees e  RIGHT JOIN employee_salary es
ON es.employee_id = e.id
JOIN salary s
ON es.salary_id = s.id
WHERE employee_name IS NULL;
```

## 4 Show null roles where salary exists and salary is less 2000
```
SELECT employee_id, employee_name AS workers, monthly_salary 
FROM 
employee_salary es LEFT JOIN employees e 
ON es.employee_id = e.id
JOIN salary s 
ON es.salary_id = s.id
WHERE employee_name IS NULL
AND monthly_salary < 2000;
```
## 5. Show all workers who doesn't have salary
```
SELECT employee_name AS workers, salary_id 
FROM employees e
LEFT JOIN  employee_salary es
ON es.employee_id = e.id
WHERE salary_id IS NULL;
```
## 6. Show all workers with their roles
```
SELECT employee_id, employee_name AS workers, role_name
FROM employees e
JOIN roles_employee  re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id;
```
## 7. Show names, roles only for Java developers
```
SELECT employee_name, role_name
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
WHERE role_name LIKE '%Java developer%';
```
## 8. Show names, roles only for Python developers
```
SELECT employee_name, role_name
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
WHERE role_name LIKE '%Python%';
```
## 9. Show names, roles only for QA engineers
```
SELECT employee_name, role_name
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
WHERE role_name LIKE '%QA engineer%';

```
## 10. Show names, roles only for Manual QA engineers
```
SELECT employee_name, role_name
FROM employees e 
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
WHERE role_name LIKE '%Manual QA%';
```
## 11. Show names, roles only for Automation QA engineers
```
SELECT employee_name, role_name
FROM employees e
JOIN roles_employee re
ON e.id = re.employee_id
JOIN roles r
ON r.id = re.role_id
WHERE role_name LIKE '%Automation QA%';
```
## 12. Show names, roles, salary only for Junior specialists
```
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
```
## 13. Show names, roles, salary only for Middle specialists
```
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
```
## 14. Show names, roles, salary only for Senior specialists
```
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
```
## 15. Show  roles, salary only for Java developers
```
SELECT  role_name, monthly_salary
FROM  roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Java developer%';
```
## 16. Show  roles, salary only for Python developers
```
SELECT  role_name, monthly_salary
FROM  roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Python developer%';
```
## 17. Show  names, roles, salary  for Junior Python developers
```
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
```
## 18. Show  names, roles, salary  for Middle JavaScript developers
```
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
```
## 19. Show  names, roles, salary  for Senior Java developers
```
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
```
## 20. Show  roles, salary  for Junior QA engineers
```
SELECT  role_name, monthly_salary
FROM  roles r
JOIN roles_employee re
ON r.id = re.role_id
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Junior%QA%';
```
## 21. Show  average salary  for all Junior specialists
### Opt.1.
```
SELECT AVG(monthly_salary) AS average_salary
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%Junior%' ;
```
### Opt.2 Show  average salary  for every  Junior category of specialists
```
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
```
## 22. Show  summ salary  of all JavaScript developers
```
SELECT SUM(monthly_salary) AS sum_salary
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%JavaScript%' ;
``` 
## 23. Show minimum salary of QA engineers
```
SELECT MIN(monthly_salary) AS min_salary
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%QA%' ;
``` 
## 24. Show maximum salary of QA engineers
```
SELECT MAX(monthly_salary) AS max_salary
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE  role_name LIKE '%QA%' ;
```

## 25. Show the number of all QA engineers
```
SELECT COUNT(*) AS number_of_QA_specialists
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employees e
ON e.id = re.employee_id
WHERE role_name LIKE '%QA%' ;
```
### Checking:
```
select * from roles_employee re where re.role_id in (10,11,12,18,19,20);
```
## 26. Show the number of Middle specialists
```
SELECT COUNT(*) AS number_of_middle_specialists
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employees e
ON e.id = re.employee_id
WHERE role_name LIKE '%Middle%' ;
```
### Checking:
```
select * from roles_employee re where re.role_id in (2,5,8,11,19);
```

## 27. Show the number of developers
```
SELECT COUNT(*) AS number_of_developers
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employees   e   
ON e.id = re.employee_id
WHERE role_name LIKE '%developer%' ;
```
### Checking:
```
select * from roles_employee re where re.role_id in (1,2,3,4,5,6,7,8,9);
```
## 28. Show  summ salary  of all  developers
```
SELECT SUM(monthly_salary) AS sum_salary_developers
FROM roles r
JOIN roles_employee re
ON r.id = re.role_id 
JOIN employee_salary es
ON re.employee_id = es.employee_id
JOIN salary s
ON s.id = es.salary_id
WHERE role_name LIKE '%developer%' ;
```
## 29. Show names, roles and salary of all specialists in ascending order
```
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
```
## 30. Show names, roles and salary of all specialists in ascending order for wokers with salary from 1700 to 2300
```
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
```

## 31. Show names, roles and salary of all specialists in ascending order for workers with salary less than 2300
```
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
```
## 32. Show names, roles and salary of all specialists in ascending order for workers with salary equal to 1100, 1500, 2000
```
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
