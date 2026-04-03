#DDL Practical Questions 
/*1. Create a table Student with columns: 
o student_id (Primary Key) 
o name 
o age 
o email (unique)*/

CREATE DATABASE clg;
USE clg;
CREATE TABLE student(
student_id INT PRIMARY KEY AUTO_INCREMENT, 
student_name VARCHAR(30) NOT NULL,
student_age INT,
student_email VARCHAR(30) UNIQUE NOT NULL
);

/*2. Create a table Course with: 
o course_id 
o course_name 
o duration */

CREATE TABLE course(
course_id INT PRIMARY KEY , 
course_name VARCHAR(15) NOT NULL,
course_duration INT
);

#3. Add a column phone_number to the Student table.

ALTER TABLE student ADD COLUMN phone_number VARCHAR(13);

#4. Change the datatype of age from INT to SMALLINT. 

ALTER TABLE student MODIFY student_age SMALLINT;

#5. Rename the table Student to Students. 

ALTER TABLE student RENAME students;

#6. Drop the column duration from the Course table. 

ALTER TABLE course DROP COLUMN  course_duration ;

#7. Add a CHECK constraint to ensure age >= 18.

ALTER TABLE students ADD CONSTRAINT chk_age CHECK (student_age >= 18);  
 
#8. Create a table Employee with a foreign key referencing Course(course_id).

CREATE TABLE employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(30),
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);
 
#9. Remove the foreign key constraint from the Employee table. 

SHOW CREATE TABLE employee;
ALTER TABLE employee DROP FOREIGN KEY employee_ibfk_1;

#10. Delete all rows from Employee without deleting its structure.

TRUNCATE TABLE employee;


# Practical Questions 
#1. Insert 5 records into the Students table.

INSERT INTO students VALUE(101,"Mansi",23,"mansi344@gmail.com",'9234567898');
INSERT INTO students (student_name,student_age,student_email,phone_number)VALUES
("Ram",20,"ram344@gmail.com",'6789567897'),
("Ramish",18,"ramish344@gmail.com",'9789856789'),
("Mohan",27,"mohan344@gmail.com",'9675674389'),
("Shyam",26,"shyam344@gmail.com",'9879562789');

#2. Insert multiple records into Course using a single query. 

INSERT INTO course (course_id,course_name)VALUES
(1,"DA"),
(2,'FULL STACK'),
(3,'DSA'),
(4,'JAVA');

#3. Display all records from Students.

SELECT * FROM students;
 
#4. Display only name and email from Students.
 
 SELECT student_name,student_email FROM students;
 
#5. Update the email of a student whose student_id = 103.

UPDATE students SET student_email = 'ramish789@gmail.com' WHERE student_id = 103;
 
#6. Increase age of all students by 1 year.

SET SQL_SAFE_UPDATES = 0;
UPDATE students SET student_age = student_age + 1;
 
#7. Delete a student record where student_id = 5. 

DELETE FROM students WHERE student_id =105;

#8. Display students whose age is greater than 20. 

SELECT * FROM students WHERE student_age >20;

#9. Display students sorted by age in descending order. 

SELECT * FROM students ORDER BY student_age DESC;

#10. Display only the first 3 records from Students.

SELECT * FROM students LIMIT 3;
