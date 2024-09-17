
-- this is a comment 
/* this is a multimline comment 
    this is the second line
*/
/*
SELECT is the most common operation in SQL, called "the query". 
SELECT retrieves data from one or more tables, or expressions. 
Standard SELECT statements have no persistent effects on the database.
*/
SELECT 1+1; -- this is a comment till the end of the line
SELECT 1+1; # this is a comment
SELECT 1+1; /* this is a comment */
SELECT 1+1; /* this is a comment
that can extend to mutliple lines
*/
SELECT 1 + /* this can also be an in-line comment */ 1;


SELECT 'Hello, SQL'; -- single quotes for strings

SELECT "Hello, SQL"; -- double quotes for strings but the preferred way is to use single quotess

SELECT "My", "name", "is", "Ahmed"; -- select multiple values

SELECT 1, "Test"; -- select different data types

SELECT 'Hello, SQL' AS greeting; -- alias

SELECT "'This is a quoted text'"; -- embed different qoutes

-- another way is to use the backslash as an escape character
SELECT "\'This is a quoted text\'";
SELECT "Line 1\nLine 2\nLine 3";
SELECT "This is a path in windows C:\\my\\folder\\path";

-- arithmetic
SELECT 1 + 2;

SELECT 5 % 2;

-- boolean
-- = is for exact matches, while LIKE is for pattern matching.
-- LIKE is generally slower than = due to the pattern matching process.
-- LIKE is more flexible for searching for similar values.
SELECT 1 = 2;

SELECT 1 <> 2; -- not equal = != you can use both of them

SELECT 'Hello, SQL' = 'Hello, SQL';

SELECT 'hello, sql' = 'Hello, SQL'; #True

SELECT 'Hello, SQL' LIKE 'hello, SQL'; #True

-- SQL Wildcards:**
-- % : Matches any number of characters (zero or more).
-- _ : Matches exactly one character.

SELECT 'Hello, SQL' LIKE 'Hello, %';



-- charactersets and collations
SELECT 'a' =  'ä';
SELECT 'a' LIKE 'ä';

SELECT 'a' =  'ä' COLLATE utf8mb4_german2_ci;
SELECT 'a' LIKE 'ä' COLLATE utf8mb4_german2_ci;

SELECT 'a' like  'ä' COLLATE utf8mb4_cs_0900_as_cs;

-- built-in functions and operators 
-- https://dev.mysql.com/doc/refman/8.0/en/built-in-function-reference.html

SELECT ABS(-5); -- absolute values
SELECT ASCII('a'), ASCII('ä');
SELECT ASCII('ab');
SELECT CHAR(57);
SELECT CHAR(ASCII('d'));

-- date and time functions
SELECT ADDDATE('2022-12-08', 24); # will add 24 days to the mentioned date
SELECT 
    ADDDATE('2022-12-08', 24),
    DAY('2022-12-08'),
    DAYNAME('2022-12-08'),
    MONTH('2022-12-08'),
    MONTHNAME('2022-12-08');
SELECT CURDATE();

-- string functions
SELECT CONCAT('my', 'name', 'is', 'prince');

# CONCAT_WS(specifier, stream of strings)
SELECT CONCAT_WS(', ', 'my', 'name', 'is', 'prince'); #CONCAT_WS MEANS CONCATINATE WITH SPECIFIER WHICH IN THIS CASE = ', '

SELECT LENGTH('ahmed');
SELECT LENGTH(CONCAT_WS(' ', 'my', 'name', 'is', 'prince')); 
SELECT LOWER('AHMED');

#LEFT/RIGHT(STRING, NUMBER OF CHARS FROM LEFT/RIGHT);
SELECT LEFT('This is the a text', 10);
SELECT RIGHT('This is the a text', 10);

#SUBSTR(string, start_position, length) //// start_position is 1-based
SELECT SUBSTR('This is a long text', 7, 10);
SELECT SUBSTR('This is a long text', 6, 10);

SELECT TRIM('  bar   ');
SELECT TRIM(LEADING 'x' FROM 'xbarx'); 
SELECT TRIM(TRAILING 'x' FROM 'xbarx');
SELECT TRIM(BOTH 'x' FROM 'xbarx');


SELECT TRUE, FALSE;
SELECT 'b' IN ('a' , 'b', 'c', 'd', 'e', 'f');
SELECT 'b' NOT IN ('a' , 'b', 'c', 'd', 'e', 'f');

/*
Function: INSTR(str, substr)
Purpose: This function returns the position "1-based" of the first occurrence of the substring substr within the string str. 
	If the substring is not found, it returns 0.
*/
SELECT INSTR("abcdefg", "f") IS TRUE;
SELECT INSTR("abcdefg", "x") IS TRUE;
SELECT ISNULL(NULL);
SELECT ISNULL(1/0); # is null
SELECT ISNULL(''); # it's not null which is the opposite of what in python.

SELECT 5 between 1 AND 10; # IF 5 IS BETWEEN 1 AND 10 OR NOT

SELECT IF(5 > 4, "TRUE", "FALSE"); # RETURN TRUE IF 5>4 AND FALSE IF ISN'T.

-- assignment operator SET using := and = 
-- assignment operator SELECT using :=
SET @var5 := 5;
SET @vara = 'a';
SELECT @var5, @vara, @var10 := 10;

# See the following example: 

SET @VAR_1 = 5;
SET @VAR_1 = @VAR_1 + 1; 
SELECT @VAR_1; -- @VAR_1 = 6

SELECT @var11 = 11; -- null because = is not an assignment operator with SELECT

--  select from tables
--
SELECT actor_id FROM sakila.actor; -- means get all data from column actor_id which in table actor and display it on the o/p
SELECT count(actor_id) FROM sakila.actor; -- how many rows in actor_id column

-- to remove duplicate values from first_name column
SELECT COUNT(actor.first_name) FROM sakila.actor;
SELECT COUNT(Distinct actor.first_name) FROM sakila.actor;
SELECT DISTINCT actor.first_name from sakila.actor;

SELECT actor_id, first_name FROM sakila.actor;
USE sakila;
SELECT actor_id, first_name FROM actor;
SELECT actor_id, first_name FROM actor LIMIT 5;
SELECT actor_id, first_name FROM actor LIMIT 5, 10;
SELECT actor_id, first_name, 'dummy text' FROM actor LIMIT 5;
SELECT actor_id, first_name, curdate() FROM actor LIMIT 5;
SELECT actor_id, first_name, last_update FROM actor LIMIT 5;
SELECT * FROM actor;

-- table stmt
TABLE actor; -- similar to SELECT * FROM actor;

SELECT 
    actor_id  AS "Actor ID",
    CONCAT(LOWER(first_name), ' ', LOWER(last_name)) AS "Actor Full Name",
    last_update AS "Last updated"
FROM
    actor; -- use built-in functions

-- sorting 
--
SELECT actor_id, first_name, last_name, last_update FROM actor;
SELECT actor_id, first_name, last_name, last_update FROM actor ORDER BY first_name;
SELECT actor_id, first_name, last_name, last_update FROM actor ORDER BY last_name;
SELECT rental_id, rental_date FROM rental ORDER BY rental_date;
SELECT actor_id, first_name, last_name, last_update FROM actor ORDER BY first_name, last_name;

-- union
--
SELECT actor_id, first_name FROM actor LIMIT 5, 10;
SELECT actor_id, first_name FROM actor LIMIT 50, 10;

(SELECT actor_id, first_name FROM actor LIMIT 5, 10)
UNION 
(SELECT actor_id, first_name FROM actor LIMIT 50 , 10);

-- where clause
SELECT * FROM film_text;
SELECT * FROM film_text WHERE film_id < 10;
SELECT * FROM film_text WHERE film_id between 16 and 90;
SELECT * FROM film_text WHERE length(title) < 10;
SELECT * FROM film_text WHERE title LIKE "Ar%";
SELECT * FROM film_text WHERE title LIKE "Ar%" and film_id > 38;
SELECT * FROM film_text WHERE locate("drama", description);
SELECT *, locate("drama", description) FROM film_text WHERE locate("drama", description);

-- prepare and execute
--
SELECT * FROM film_text WHERE title LIKE "Ar%" and film_id > 38;

PREPARE sql_stmt FROM 'SELECT * FROM film_text WHERE title LIKE "Ar%" and film_id > ?';
SET @id := 38;
EXECUTE sql_stmt USING @id;

PREPARE sql_stmt FROM 'SELECT * FROM film_text WHERE title LIKE ? and film_id > ?';
SET @text := "Ar%";
SET @id := 38;
EXECUTE sql_stmt USING @text, @id;

DROP PREPARE sql_stmt;
DEALLOCATE PREPARE sql_stmt; -- IS A STANDARD QUERY FOR ALL DIFFERENT DATABASES NOT LIKE 'DROP PREPARE' WHICH IS SPECIFIC FOR MYSQL AND SOME OTHER DB

-- group by
--
SELECT * FROM rental;
SELECT customer_id, rental_id FROM rental;
SELECT customer_id, count(rental_id) FROM rental GROUP BY customer_id;
SELECT customer_id, count(rental_id) FROM rental GROUP BY customer_id ORDER BY customer_id DESC;
SELECT customer_id, count(rental_id) FROM rental GROUP BY customer_id ORDER BY count(rental_id) DESC;

SELECT customer_id, sum(amount) FROM payment GROUP BY customer_id ORDER BY sum(amount) DESC;
-- having
--
SELECT customer_id, sum(amount) FROM payment GROUP BY customer_id WHERE  sum(amount) > 150 ORDER BY sum(amount) DESC; -- error!
SELECT customer_id, sum(amount) FROM payment GROUP BY customer_id HAVING sum(amount) > 150 ORDER BY sum(amount) DESC; 
-- SEE THIS PROPLEM https://leetcode.com/problems/consecutive-numbers/?envType=problem-list-v2&envId=e97a9e5m 
-- joins
--
SELECT category_id, name FROM category;
SELECT film_id, category_id  FROM film_category;

SELECT film_category.film_id, category.category_id, category.name FROM category
INNER JOIN film_category
ON film_category.category_id  = category.category_id;

SELECT fc.film_id, c.category_id, c.name FROM category AS c
INNER JOIN film_category AS fc
ON fc.category_id  = c.category_id;

SELECT fc.film_id, c.category_id, c.name FROM category AS c
INNER JOIN film_category AS fc
USING (category_id);

SELECT fc.film_id, c.category_id, c.name FROM category AS c
LEFT JOIN film_category AS fc
USING (category_id);

SELECT fc.film_id, c.category_id, c.name FROM category AS c
RIGHT JOIN film_category AS fc
USING (category_id);
-- see this proplem very important: https://leetcode.com/problems/employees-with-missing-information/description/
-- join 3 tables
--
SELECT fc.film_id, f.title, c.category_id, c.name FROM category AS c
INNER JOIN film_category AS fc
ON fc.category_id  = c.category_id
INNER JOIN film AS f
ON f.film_id = fc.film_id;

SELECT fc.film_id, f.title AS "Film Name", c.name AS "Genre" FROM category AS c
INNER JOIN film_category AS fc
ON fc.category_id  = c.category_id
INNER JOIN film AS f
ON f.film_id = fc.film_id;

-- ---
-- complete join example
-- ---
create database testdb;
use testdb;
create table tbl1 (id int, name varchar(20));
create table tbl2 (id int, title varchar(20));

insert into tbl1 values (1, 'ahmed'), (2, 'aya'), (3, 'wegz'), (4, 'marwan');

insert into tbl2 values (2, 'engineer'), (3, 'writer'), (4, 'rapper'), (5, 'doctor');

SELECT * FROM testdb.tbl1;
SELECT * FROM testdb.tbl2;

select tbl1.*, tbl2.* from tbl1 inner join tbl2 using (id);
select tbl1.*, tbl2.* from tbl1 left join tbl2 using (id);
select tbl1.*, tbl2.* from tbl1 right join tbl2 using (id);
select tbl1.*, tbl2.* from tbl1 cross join tbl2;
-- --

-- views
--
CREATE VIEW vw_file_genre
AS
SELECT fc.film_id, f.title AS "Film Name", c.name AS "Genre" FROM category AS c
INNER JOIN film_category AS fc
ON fc.category_id  = c.category_id
INNER JOIN film AS f
ON f.film_id = fc.film_id;
-- it's very important to review the importance of views which is circuled around the abstraction of the table structure
