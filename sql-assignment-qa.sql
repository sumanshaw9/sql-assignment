/* 1. Create a table called employees with the following structure?
 : emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).
Write the SQL query to create the above table with all constraints. */

create database pw;
use pw;
create table employees 
(emp_id int primary key,
emp_name varchar(30) not null,
age int check(age>=18),
email varchar(30) unique,
salary float default(30000));

select * from employees;

/* 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints. 

sol - Purpose of Constraints in a Database:
Constraints in a database are rules enforced on 
data columns to maintain accuracy, consistency, and integrity of the data. 
They ensure that only valid data is stored in the database, thus helping prevent errors,
duplication, and corruption of information.

How Constraints Help Maintain Data Integrity:
Enforce data validity: Prevents incorrect data entry (e.g., negative age or blank names).

Ensure relationships: Maintains consistent links between tables (e.g., a foreign key ensuring a referenced record exists).

Prevent duplication: Ensures uniqueness in key fields like user ID or email.

Control nullability: Defines whether a field can be left empty.

Restrict actions: Prevents unintended deletes or updates that could compromise data.

Common Types of Constraints with Examples:

Constraint	   |              Description	                           |                 Example
NOT NULL	 | Ensures a column cannot have a NULL value	| Name VARCHAR(50) NOT NULL – name must be provided
UNIQUE	| Ensures all values in a column are unique	 |  Email VARCHAR(100) UNIQUE – no duplicate emails allowed
PRIMARY KEY	| Uniquely identifies each row in a table; combines NOT NULL + UNIQUE	| CustomerID INT PRIMARY KEY
FOREIGN KEY	 | Links one table to another; enforces referential integrity	| Order.CustomerID REFERENCES Customers(CustomerID)
CHECK	| Ensures values meet a specific condition	| Age INT CHECK (Age >= 18)
DEFAULT	| Assigns a default value if none is provided	| Status VARCHAR(10) DEFAULT 'Pending'     */

/* 3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.

sol - The NOT NULL constraint is applied to a column to ensure that a value must always be provided.
It prevents the insertion of NULL (i.e., missing or unknown) values into that column. This is 
important when the column holds critical information, such as names, IDs, or timestamps that 
should never be empty.

For example, if you apply NOT NULL to a "CustomerName" column, it ensures that every customer
has a name recorded in the table.

Regarding Primary Key:
A primary key CANNOT contain NULL values. This is because a primary key is used to uniquely 
identify each row in a table, and NULL represents an unknown or absent value, which violates 
the uniqueness and identity rule of a primary key.

Therefore:
- A column with a primary key is always implicitly NOT NULL.
- Trying to insert a NULL value into a primary key column will result in an error.

Example:
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);
-- Here, CustomerID is the primary key and cannot be NULL.
-- Name is also NOT NULL, so every customer must have a name.
*/

/*4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint.

sol - In SQL, constraints can be added or removed using the ALTER TABLE command.

-- TO ADD A CONSTRAINT:
You use the ALTER TABLE ... ADD CONSTRAINT syntax.
 Syntax (General):
ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column_name);
Example: Adding a UNIQUE constraint to the Email column
ALTER TABLE Customers
ADD CONSTRAINT unique_email UNIQUE (Email);

-- TO REMOVE A CONSTRAINT:
You use the ALTER TABLE ... DROP CONSTRAINT syntax.
(Note: In MySQL, you use DROP INDEX for UNIQUE constraints, and DROP FOREIGN KEY for FK.)
 Example: Removing the UNIQUE constraint on Email (MySQL specific)
ALTER TABLE Customers
DROP INDEX unique_email;
 If it were a FOREIGN KEY:
ALTER TABLE Orders
DROP FOREIGN KEY fk_customer;

Note:
- The exact syntax for dropping a constraint may vary slightly depending on the constraint type.
- In MySQL, PRIMARY KEY and FOREIGN KEY constraints have specific DROP syntax. */

-- Example Table:
CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(100),
  Email VARCHAR(100)
);

-- Add UNIQUE constraint to Email
ALTER TABLE Customers
ADD CONSTRAINT unique_email UNIQUE (Email);
select * from customers;

-- Remove UNIQUE constraint from Email
ALTER TABLE Customers
DROP INDEX unique_email;

/* Q5: Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.

sol - When you try to INSERT, UPDATE, or DELETE data that violates a database constraint, 
the database system will reject the operation and return an error. This protects 
data integrity and prevents invalid data from entering or corrupting the database.

CONSEQUENCES BY CONSTRAINT TYPE:

1. NOT NULL Constraint:
- Trying to insert NULL into a NOT NULL column causes an error.
  Example:
  INSERT INTO Customers (CustomerID, Name) VALUES (1, NULL);
  -- Error: Column 'Name' cannot be null
2. UNIQUE Constraint:
- Inserting a duplicate value in a column with a UNIQUE constraint.
  Example:
  INSERT INTO Customers (CustomerID, Email) VALUES (2, 'john@example.com');
  -- Error: Duplicate entry 'john@example.com' for key 'unique_email'
3. PRIMARY KEY Constraint:
- Inserting a duplicate primary key value.
  Example:
  INSERT INTO Customers (CustomerID, Name) VALUES (1, 'Alice');
  -- Error: Duplicate entry '1' for key 'PRIMARY'
4. FOREIGN KEY Constraint:
- Inserting a value in a child table that doesn't exist in the parent table.
- Or deleting a parent row referenced in a child table.
  Example:
  INSERT INTO Orders (OrderID, CustomerID) VALUES (101, 999);
  -- Error: Cannot add or update a child row: a foreign key constraint fails
5. CHECK Constraint:
- Inserting a value that violates a condition.
  Example:
  INSERT INTO Employees (Name, Age) VALUES ('Raj', -5);
  -- Error: Check constraint 'employees_chk_1' is violated. */

/* 6. You created a products table without constraints as follows: */

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)); 
    
/* Now, you realise that?
: The product_id should be a primary key.
: The price should have a default value of 50.00 

sol - solution using ALTER TABLE: */
-- 1. Add PRIMARY KEY to product_id
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);
-- 2. Set DEFAULT value for price to 50.00
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;
-- NOTE: MySQL syntax for default value:
ALTER TABLE products
MODIFY COLUMN price DECIMAL(10,2) DEFAULT 50.00;

-- Explanation:
-- MODIFY COLUMN is used to change the definition of an existing column in MySQL,
-- including adding a default value.

-- test the changes:
INSERT INTO products (product_id, product_name) VALUES (1, 'Laptop');
-- Since price is not provided, it will default to 50.00
SELECT * FROM products;

-- 7. Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
-- You have two tables:
-- first we have to create class table then students because of class_id is used in students
create table Classes(
class_id int primary key,
class_name varchar(30));
-- insert data into classes
insert into Classes (class_id, class_name)
values (101,'Math'),(102,'Science'),(103,'History');
select * from classes;
-- create students table
create table Students(
student_id int primary key,
student_name varchar(30),
class_id int, foreign key (class_id) references Classes(class_id)
);

insert into Students(student_id, student_name, class_id)
values (1, 'Alice', 101),(2, 'Bob', 102),(3, 'Charlie',101);
select * from students;
-- sol - inner join query
select s.student_name, c.class_name from Students s 
inner join Classes c on s.class_id = c.class_id;

/* 8. Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order.*/
-- create given three table
-- Step 1: Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);
-- Step 2: Insert sample data into Customers
INSERT INTO Customers (customer_id, customer_name)
VALUES (101, 'Alice'),(102, 'Bob');
-- Step 3: Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- Step 4: Insert sample data into Orders
INSERT INTO Orders (order_id, order_date, customer_id)
VALUES (1, '2024-01-01', 101),(2, '2024-01-03', 102);
-- Step 5: Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
-- Step 6: Insert sample data into Products
INSERT INTO Products (product_id, product_name, order_id)
VALUES (1, 'Laptop', 1),(2, 'Phone', NULL);
-- Step 7: Final query (LEFT JOIN + INNER JOIN)
SELECT 
    o.order_id,
    c.customer_name,
    p.product_name
FROM 
    Products p
LEFT JOIN 
    Orders o ON p.order_id = o.order_id
left JOIN 
    Customers c ON o.customer_id = c.customer_id;
/* 9. Given the following tables:
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function. */
-- create tables
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    amount INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- insert data into these tables
INSERT INTO Products (product_id, product_name)
VALUES (101, 'Laptop'),(102, 'Phone');

INSERT INTO Sales (sale_id, product_id, amount)
VALUES (1, 101, 500),(2, 102, 300),(3, 101, 700);

select * from products;
select * from sales;
-- Query to Find Total Sales Amount for Each Product
SELECT p.product_name,SUM(s.amount) AS total_sales FROM Sales s
INNER JOIN 
Products p ON s.product_id = p.product_id
GROUP BY p.product_name;

/* 10. Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables. given tables */
-- Create Customers table
CREATE TABLE Customers (
    customer_id INT,
    customer_name VARCHAR(50)
);
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Alice'),(2, 'Bob');
-- Create Orders table
CREATE TABLE Orders (
    order_id INT,
    order_date DATE,
    customer_id INT
);
INSERT INTO Orders (order_id, order_date, customer_id) VALUES (1, '2024-01-02', 1),(2, '2024-01-05', 2);
-- Create Order_Details table
CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT
);
INSERT INTO Order_Details (order_id, product_id, quantity) VALUES(1, 101, 2),(1, 102, 1),(2, 101, 3);
-- Query
select o.order_id, c.customer_name, od.quantity from Orders o 
INNER JOIN
Customers c ON o.customer_id = c.customer_id
INNER JOIN
Order_Details od ON o.order_id = od.order_id;