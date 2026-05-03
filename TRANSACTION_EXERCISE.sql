# TCL assignments

# Schema 1: Bank System
 
CREATE DATABASE BANK;
USE BANK;
CREATE TABLE accounts(
account_id INT  PRIMARY KEY,
account_name VARCHAR(20),
balance DECIMAL(8,2) );

INSERT INTO ACCOUNTS VALUES
(1,"alice",5000),
(2,"bob",3000),
(3,"charlie",7000);

#---QUESTIONS-----

#1. Start a transaction and transfer ₹1000 from Alice to Bob.  
START TRANSACTION;
UPDATE ACCOUNTS SET  balance=balance-1000 WHERE account_id=1;
UPDATE ACCOUNTS SET  balance=balance+1000 WHERE account_id=2;
COMMIT;

#2. Perform a transaction where ₹2000 is deducted from Bob, but rollback before commit.  
START TRANSACTION;
UPDATE ACCOUNTS SET balance=balance-2000 WHERE account_id=2;
ROLLBACK;

#3. Transfer ₹500 from Charlie to Alice and commit the transaction.  
START TRANSACTION;
UPDATE ACCOUNTS SET balance=balance-500 WHERE account_id=3;
UPDATE ACCOUNTS SET balance=balance+500 WHERE account_id=1;
COMMIT;

#4. Try transferring ₹10000 from Bob (insufficient balance). Rollback if balance goes negative. 
START TRANSACTION;
UPDATE ACCOUNTS SET balance = balance - 10000 WHERE account_id = 2 AND balance >= 10000;
SELECT* FROM accounts;
ROLLBACK;

#5. Perform multiple transfers in one transaction and rollback all if any one fails.
START TRANSACTION;
SELECT * FROM accounts;
UPDATE ACCOUNTS SET balance=balance+500 WHERE account_id=1;
UPDATE ACCOUNTS SET balance=balance-500 WHERE account_id=3;
UPDATE ACCOUNTS SET balance=balance-10000 WHERE account_id=1 AND balance>=10000;
UPDATE ACCOUNTS SET balance=balance+10000 WHERE account_id=2 AND balance>=10000;
ROLLBACK;

#Schema 2- employee salary update

CREATE TABLE employees(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
salary DECIMAL(8,2));

INSERT INTO employees
VALUES
(1,"john",40000),
(2,"jane",45000),
(3,"mike",50000);

#---QUESTIONS-----

# 1.  Increase salary of all employees by 10% using a transaction.  
START TRANSACTION;
UPDATE EMPLOYEES SET salary = salary * 1.10;
COMMIT;
SELECT*FROM employees;
 
#2.  Update salary of John and Jane, then rollback changes.
START TRANSACTION;
UPDATE EMPLOYEES SET salary=salary+10000 WHERE emp_id=1;
UPDATE EMPLOYEES SET salary=salary+10000 WHERE emp_id=2;
rollback;
 
#3.  Perform multiple updates and commit only after verifying results.
START TRANSACTION;
UPDATE EMPLOYEES SET salary=salary+1000 WHERE emp_id=1;
UPDATE EMPLOYEES SET salary=salary+1000 WHERE emp_id=2;
SELECT*FROM employees WHERE emp_id IN (1,2);
COMMIT;
   
#4 .Use SAVEPOINT to partially rollback salary updates.
START transaction;
UPDATE EMPLOYEES SET salary=salary-2000 WHERE emp_id=1;
UPDATE EMPLOYEES SET salary=salary+2000 WHERE emp_id=2;
SAVEPOINT S1;
     
UPDATE EMPLOYEES SET salary=salary-60000 WHERE emp_id=1;
SELECT*FROM employees;
ROLLBACK to S1;
COMMIT;
   
#5.Create a transaction where one update fails and rollback everything.  
START transaction;
UPDATE EMPLOYEES SET salary=salary-2000 WHERE emp_id=2;
UPDATE EMPLOYEES SET salary=salary+2000 WHERE emp_id=3;
ROLLBACK;

#---ADVANCE QUESTIONS----- 
#Demonstrate use of:  
#• START TRANSACTION  
#• COMMIT  
#• ROLLBACK  

START TRANSACTION;
UPDATE EMPLOYEES SET salary=salary+10000 WHERE emp_id=1;
UPDATE EMPLOYEES SET salary=salary+10000 WHERE emp_id=2;
COMMIT;

START TRANSACTION;
UPDATE EMPLOYEES SET salary=salary+10000 WHERE emp_id=1;
UPDATE EMPLOYEES SET salary=salary+10000 WHERE emp_id=2;
ROLLBACK;
 
# SCHEMA 3- e commerce orders

 CREATE DATABASE e_commerce;
 USE e_commerce;
 CREATE TABLE PRODUCTS(
 product_id INT PRIMARY KEy,
 Product_name VARCHAR(30),
 STOCK INT);
 
 CREATE TABLE ORDERS(
 ORDER_ID INT PRIMARY KEY,
 product_id INT ,
 Qty INT );
 
 INSERT INTO PRODUCTS
 VALUES
 (1,"laptop",10),
 (2,"phone",20);
 SELECT*FROM PRODUCTS;
 
 #---QUESTIONS-----
 
 #1. Start a transaction and place an order for 2 laptops. Reduce stock accordingly.
 START transaction;
 INSERT INTO ORDERS(order_id,product_id,qty)
 values
 (101,1,2);
 UPDATE PRODUCTS SET stock=stock-2 WHERE product_id=1; 
 SELECT*FROM Products;
 COMMIT;
 
#2. Place an order where stock is insufficient. Rollback the transaction.
START TRANSACTION;
UPDATE PRODUCTS SET stock = stock - 25 
WHERE product_id = 2 AND stock >= 25;
SELECT * FROM PRODUCTS;

#3.Insert order and update stock in a single transaction. Commit only if both succeed.  
START transaction;
INSERT INTO ORDERS(order_id,product_id,qty)
VALUES(103,2,5);
UPDATE PRODUCTS SET STOCK=stock-5 WHERE product_id=2;
COMMIT;

#4. Perform bulk order inserts and rollback if any product stock becomes negative. 
START TRANSACTION;
INSERT INTO ORDERS VALUES(104,1,40),(105,2,30);
UPDATE products 
SET stock = stock - 40 
WHERE product_id = 1 AND stock >= 40;
UPDATE products 
SET stock = stock - 30 
WHERE product_id = 2 AND stock >= 30;
ROLLBACK;

#5. Simulate failure after inserting order but before updating stock. Rollback changes. 
START TRANSACTION;
INSERT INTO ORDERS (ORDER_ID, product_id, Qty)
VALUES (105, 1, 2);
UPDATE PRODUCTS SET wrong_column = 10 WHERE product_id = 1;
ROLLBACK;
