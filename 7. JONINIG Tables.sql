-- SQL Joins
-- Combining tables is essential and that can be done by using Union, Union all, and joins
-- These two types of joining are dependent on the way of joining (columns or rows?)
-- If we want to join tables by adding columns we use Joins (we're getting wider table)
-- and if we want to append new rows to the table we use the SET operators (we're getting longer table)



--------------------------------------------------------------------------------------------------------

-- 1) No Join: Returns Data from tables without combining them

SELECT *
FROM customers;

SELECT *
FROM orders;



---------------------

-- 2) Inner JOIN: Returns Only matching rows between tables

SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id;



---------------------

-- 3) Left JOIN: Returns all rows from the left table and only the matching from the right one

SELECT
	*
FROM customers AS c
LEFT JOIN orders o
ON c.id = o.customer_id;



---------------------

-- 4) Right JOIN: Returns all rows from the right table and only the matching from the left one

SELECT
	*
FROM customers AS c
RIGHT JOIN orders o
ON c.id = o.customer_id;



---------------------

-- 5) Full Join: Returns all rows from both tables

SELECT 
	*
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id;



---------------------

-- 6) LEFT ANTI Join: Returns rows from the left table that has no match in the right table
-- customers who didn't order anything?

SELECT 
	*
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL;



---------------------

-- 7) RIGHT ANTI Join: Returns rows from the Right table that has no match in the left table
-- similar to LEFT Anti JOIN


---------------------

-- 8) FULL ANTI Join: Returns rows that don't match from either table
-- customers without orders and orders without customers?

SELECT 
	*
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL OR c.id IS NULL;


-----------------------

-- 9) Cross Join: combines every row from left with every row from the right (all possible combinations)

SELECT 
	*
FROM customers
CROSS JOIN orders;


