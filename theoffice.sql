CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
); -- here the employee table is created stil the foreign keys are not created because this first table and it will throw error

CREATE TABLE  branch
(
    branch_id INT PRIMARY KEY ,
    branch_name VARCHAR(20),
    magr_id INT ,
    magr_date DATE,
    FOREIGN KEY(magr_id) REFERENCES employee(emp_id) ON DELETE SET NULL -- here the foreign key is created and it referenced to the employee table to emp_id

);
-- to create the branch_id as the foreign key
ALTER TABLE  employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

-- to create the super_id as the foreign key 
ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client --table is created for the client table 
(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(20),
    branch_id INT ,
    FOREIGN KEY(branch_id) references branch(branch_id)  ON DELETE SET NULL 
       
);


CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);
CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
-- the reason to insert the corporate first is because stil i haven't inserted anything in any table 
--now insert the branch because the employee table has the foreign key referenced to the branch table
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');
-- now update the foreign key 
UPDATE employee
SET branch_id=1
WHERE emp_id=100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- NOW WE HAVE TO INSERT SCRANTON BRANCH FIRST INSERT THE BRANCH SUPERVISOR THAN INSERT THE OTHER EMPLOYEES
-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);
INSERT INTO branch VALUES(2, 'scranton', 102, '1992-04-06');

--now update the branch id 
UPDATE employee
SET branch_id=2
WHERE emp_id=102;
--now inserting the employees 
INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- repeating the same procedure like above 
-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

--client
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

SELECT * FROM employee;
-- select all the employees and orderby salary
SELECT *
FROM employee
ORDER BY  salary DESC ;  -- ordering the desending 

-- select all the employees ordered by sex and name 
SELECT *
FROM employee 
ORDER BY sex,first_name,last_namee; 

-- find the first 5 emloyees in the table 
SELECT *
FROM employee
LIMIT 5;
-- find the first and last name of the employees
SELECT first_name,last_namee
FROM employee;

-- find the forename and surnames of the all employees
-- since the columns are named as the first_name and last_name i need to use the AS 
SELECT first_name AS forename , last_namee AS surname -- what this is doing is it is changing the column name by using the AS 
FROM employee;

-- find all the different genders in the table 
SELECT DISTINCT branch_name     -- this is telling all the different branch_name in the branch table by using the DISTINCT 
FROM branch; 

--------------------------------- SQL -- FUNCTIONS -------------------------------------------------------------------
-- function is a piece of code 
-- sql has different functions just like other programming languages 

-- find the number of employees
SELECT COUNT(emp_id) 
FROM employee; -- here the count is sql function and it calculating the number ofemployees using the emp_id


-- find the female employees born after 1970 
SELECT COUNT(emp_id)
FROM employee
WHERE sex='f' AND birth_date>'1970-01-01';

SELECT COUNT(emp_id) 
FROM employee
WHERE sex='m' AND birth_date>'1970-01-01';-- for male employees

-- find the averages of all the employees salary 
SELECT AVG(salary) 
FROM employee; -- this is finding the average of all the employees through AVG()

-- find the averages of all the employees salary male employees
SELECT AVG(salary) 
FROM employee
WHERE sex='m';


-- find the sum of all employees
SELECT SUM(salary) 
FROM employee;

-- find out how many male and female workers are there 
-- in the first line it will first print the count and second sex is written for showing sex column
select COUNT(sex) , sex
FROM employee
GROUP BY(sex); -- group by saying that it should grouped by sex 

-- find the total sales of each salesman     
-- here in the below line extra emp_id is written to print the emp_id  
SELECT emp_id, SUM(total_sales) 
FROM works_with
GROUP BY(emp_id); -- this gonna tell how much each employee has sold totally

-- find total amount each client has spend 
SELECT client_id, SUM(total_sales) 
FROM works_with
GROUP BY(client_id); -- this is showing how each client has spent 

SELECT first_name, branch_id 
FROM employee
GROUP BY(first_name);

----- patterns using the like 
SELECT *
FROM employee
WHERE last_namee LIKE '%d'; -- this is giving only the last name whose ends with d and there may any number of characters before d 

SELECT *
FROM employee
WHERE last_namee LIKE '%d%';
 -- this is giving all the last_names who have d in their last_names irrespective where it is 

SELECT *
FROM employee
WHERE last_namee LIKE 'm%'; -- this is giving all the last_name which starts with the m 

SELECT *
FROM employee
WHERE last_namee LIKE '_____n'; 
-- this will strictly only see the last names with 2 characters and that ends with y 
-- if 5 underscore were given than it will search for 6 character last_name which ends with y

SELECT *
FROM employee
WHERE last_namee NOT LIKE 'm%'; -- not it will give all the last names without m starting    

-- we can use the regular expression 
SELECT * 
FROM employee 
WHERE last_namee REGEXP '^m';
-- ^ indicate the begining of the string 
-- $ indicate the end of the string 
-- | pipe this is used to search for multiple words or characters 
-- [abcdfg] 
-- [a-g] represent the range 
SELECT * 
FROM employee 
WHERE last_namee REGEXP 'd$'; -- this is showing all the last names which ends with d 

SELECT * 
FROM employee 
WHERE last_namee REGEXP 'a|d|r';	-- this is showing all the last names either which a or d 

SELECT * 
FROM employee 
WHERE last_namee REGEXP '[raf]d'; -- this will try match all the last names like rd , ad , fd        since bernard has ad so 