CREATE DATABASE compnay_db;
USE company_db;

CREATE TABLE employees(
emp_id INT PRIMARY KEY auto_increment,
name VARCHAR(20),
department VARCHAR(30),
salary DECIMAL(8,2),
AGE INT,
city VARCHAR(30),
joining_date DATE);

INSERT INTO employees(name,department,salary,age,city,joining_date)
VALUES
('Amit', 'IT', 60000, 28, 'Delhi', '2022-03-15'), 
('Riya', 'HR', 45000, 25, 'Mumbai', '2021-06-10'), 
('John', 'IT', 75000, 32, 'Bangalore', '2020-01-20'), 
('Sara', 'Finance', 50000, 29, 'Delhi', '2023-02-12'), 
('David', 'IT', 80000, 35, 'Mumbai', '2019-11-05'), 
('Neha', 'HR', 47000, 27, 'Delhi', '2022-07-19'), 
('Raj', 'Finance', 52000, 31, 'Bangalore', '2021-09-23'), 
('Priya', 'IT', 62000, 26, 'Delhi', '2023-01-01');

# BASIC SELECT AND WHERE 

# 1. Display all employee details  
SELECT * FROM employees;

#2. Show only employee names and salaries  
SELECT name,salary FROM employees;

# 3. Find employees with salary > 60000  
SELECT name,salary FROM employees WHERE salary>60000;

#4.  Find employees from Delhi  
SELECT name ,city FROM employees WHERE city="delhi";

#5. Find employees aged between 25 and 30  
SELECT name,age FROM employees WHERE age between 25 and 30;

# ORDER BY

#6.  Sort employees by salary (ascending) 
SELECT * FROM employees ORDER  BY salary ;

#7. Sort employees by age (descending)
SELECT * FROM employees ORDER by age DESC;

#8.  Show employees sorted by department, then salary  
SELECT * FROM employees ORDER  BY  DEPARTMENT,SALARY;

# DISTINCT

#9 .  List unique departments  
SELECT DISTINCT DEPARTMENT FROM employees;

#10.  List unique cities  
SELECT DISTINCT city FROM employees;

# LIMIT

#11. Show top 3 highest paid employees 
SELECT name ,salary  FROM employees ORDER  BY salary DESC LIMIT 3;

#12.  Show 2 youngest employees 
SELECT name ,age FROM employees ORDER BY age LIMIT 2;

# AGGREGATE FUNCTION

#13. Find total number of employees  
SELECT count(emp_id) FROM employees;

#14.  Find average salary 
SELECT avg(salary) FROM employees;

#15. Find maximum salary  
SELECT max(salary) FROM employees;

#16.Find minimum salary 
SELECT min(salary) FROM employees;

#17. Find total salary of all employees  
SELECT sum(salary) FROM employees;

# GROUP BY

#18. Count employees in each department  
SELECT department, count(*) FROM employees
GROUP BY department;

#19. Find average salary per department
SELECT department,avg(salary)  FROM employees GROUP BY department ;

#20 .Find total salary per city  
SELECT city,sum(salary) FROM employees GROUP BY city;

# HAVING

#21.. Show departments with more than 2 employees  
SELECT department, COUNT(*) FROM employees GROUP BY department HAVING COUNT(*) > 2;

#22. Show departments where average salary > 60000  
SELECT department FROM employees GROUP By department HAVING AVG(salary) > 60000;

#  LIKE Operator

#23.  Find employees whose name starts with 'A
SELECT name FROM employees WHERE name LIKE "A%" ;

#24. Find employees whose name ends with 'a'
SELECT name FROM employees WHERE name LIKE "%a";

#25. Find employees whose name contains 'i'
SELECT name FROM employees WHERE NAME LIKE "%i%";

#IN / NOT IN 

#26.  Find employees from Delhi or Mumbai 
SELECT NAME  FROM employees WHERE city IN ('Delhi','Mumbai');

#27.  Find employees NOT in IT department 
SELECT name FROM employees WHERE department NOT IN ("IT");

#BETWEEN

#28.  Find employees with salary between 50000 and 70000
SELECT name FROM employees
 WHERE salary BETWEEN 50000 AND 70000;
 
#29. Find employees who joined between 2021 and 2023 
SELECT name FROM employees WHERE joining_date BETWEEN 2021 and 2023;

#UPDATE

#30. Increase salary of all IT employees by 10%  
UPDATE  employees SET salary=salary+salary*0.10 WHERE department="IT";

#DELETE

#31. Delete employees with salary < 45000  
DELETE  FROM employees WHERE salary<45000;

#CASE Statement

#32. Categorize employees:  
#• Salary > 70000 → 'High'  
#• 50000–70000 → 'Medium'  
#• < 50000 → 'Low'

SELECT name,salary,
CASE 
	WHEN salary<50000 THEN "LOW salary"
	WHEN salary BETWEEN  50000 AND 70000  THEN "MEDIUM"
	ELSE  "HIGH"
END AS salary_category
FROM employees;
