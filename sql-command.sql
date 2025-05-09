-- ---------------------------------------------------------------------
##SQL Commands 
##using mavenmovies dataset
 ##1-Identify the primary keys and foreign keys in maven movies db. 
 ##Discuss the differences 
 /*
--------------------------------------------------------------------------------
PRIMARY & FOREIGN KEYS IN MAVEN MOVIES DATABASE
--------------------------------------------------------------------------------
1. PRIMARY KEYS
A Primary Key uniquely identifies each record in a table.
Examples in the Maven Movies database:
- customer         → customer_id
- film             → film_id
- rental           → rental_id
- inventory        → inventory_id
- payment          → payment_id

2. FOREIGN KEYS
A Foreign Key establishes a link between two tables and refers to the Primary Key of another table.
Examples in the Maven Movies database:
- customer.store_id        → store.store_id
- customer.address_id      → address.address_id
- rental.customer_id       → customer.customer_id
- rental.inventory_id      → inventory.inventory_id
- rental.staff_id          → staff.staff_id
- payment.customer_id      → customer.customer_id
- payment.staff_id         → staff.staff_id
- payment.rental_id        → rental.rental_id
- inventory.film_id        → film.film_id
- inventory.store_id       → store.store_id

3. DIFFERENCE BETWEEN PRIMARY KEY & FOREIGN KEY
| Feature         | Primary Key                        | Foreign Key                                |
|----------------|------------------------------------|--------------------------------------------|
| Role            | Uniquely identifies a row          | Refers to a primary key in another table    |
| Uniqueness      | Must be unique                     | Can have duplicates                         |
| NULL Values     | Not allowed                        | Allowed (depends on design)                 |
| Main Purpose    | Ensures row uniqueness             | Enforces referential integrity              |
--------------------------------------------------------------------------------
*/
## 2 -List all details of actors
use mavenmovies;
select * from actor;

## 3 -List all customer information from DB
select * from customer;

## 4 -List different countries.
select distinct country from country;

## 5 -Display all active customers
select * from customer;
select * from customer 
where active = 1;

## 6 -List of all rental IDs for customer with ID 1.
select * from rental;
select * from rental 
where customer_id = 1;

## 7 - Display all the films whose rental duration is greater than 5 .
select * from film;
select * from film 
where rental_duration > 5;

## 8 - List the total number of films 
## whose replacement cost is greater than $15 and less than $20
select count(*) as total_films
from film 
where replacement_cost > 15 and replacement_cost < 20; 

## 9 - Display the count of unique first names of actors
select count(distinct first_name) as unique_fn from actor;

## 10- Display the first 10 records from the customer table .
select * from customer limit 10;
select * from customer order by customer_id limit 10;

#Retrive table
select * from category;
select * from customer;
select * from film;
select * from city;
select * from actor;
select * from inventory;

##11 -Display the first 3 records from the customer table whose first name starts with ‘b’.
select * from customer
where first_name like 'b%'
limit 3;

## 12 -Display the names of the first 5 movies which are rated as ‘G’.
select title, rating from film where rating = 'G' limit 5;

##13-Find all customers whose first name starts with "a".
select * from customer where first_name like 'a%';

##14- Find all customers whose first name ends with "a".
select * from customer where first_name like '%a';

##15- Display the list of first 4 cities which start and end with ‘a’ .
select city from city where city like 'a%a' limit 4;

##16- Find all customers whose first name have "NI" in any position.
select first_name from customer where first_name like '%NI%';

##17- Find all customers whose first name have "r" in the second position .
select first_name from customer where first_name like '_r%';

##18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
select first_name from customer where first_name like 'a____';

##19- Find all customers whose first name starts with "a" and ends with "o".
select first_name from customer where first_name like 'a%o';

##20 - Get the films with pg and pg-13 rating using IN operator.
select title, rating from film where rating in ('PG','PG-13');

##21 - Get the films with length between 50 to 100 using between operator.
select title, length from film where length between 50 AND 100;

##22 - Get the top 50 actors using limit operator.
select first_name, last_name from actor limit 50;

##23 - Get the distinct film ids from inventory table
select distinct film_id, store_id from inventory;