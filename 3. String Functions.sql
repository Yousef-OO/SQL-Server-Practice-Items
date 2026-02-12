-- Data Transformation and cleaning
-- (String functions, Number functions, Null functions,
-- Data functions, and case when statements)
-- Single-Row functions and multi-row functions
-- Multi-Row functions (Aggregate, and Window functions)


-- 1) string functions
-- (Manipulation, Calculation, Extraction)
-- (Manipulation      --> a)Concat, b)Upper, c)Lower, d)Trim, e)Replace)
-- (Calculation       --> Len)
-- (String Extraction --> a)Left, b)Right, c)Substring)



SELECT
	first_name, 
	country,
	CONCAT(first_name, '-->', country) AS name_country
FROM customers;



-- Upper & Lower functions


SELECT 
	first_name,
	UPPER(first_name) AS upper,
	LOWER(country) AS lower,
	CONCAT(first_name, ' ', country) AS name_country
FROM customers;



-- TRIM removes leading and the trailing spaces


SELECT 
	first_name,
	TRIM(first_name) AS trimmed,
	LEN(first_name)
FROM customers;


-- Replace function

SELECT
	'123-345-667',
	REPLACE('123-345-667', '-', '');



-- String calculation (Len function)


SELECT 
	first_name,
	LEN(first_name)
FROM customers;



-- LEFT and RIGHT functions

SELECT
	first_name,
	LEFT(TRIM(first_name), 3)
FROM customers;


-- Substring function

SELECT 
	first_name,
	SUBSTRING(LTRIM(first_name), 2, LEN(first_name))
FROM customers;


-- Number functions (ROUND, and ABSOLUTE)

SELECT 
	ROUND(ABS(-23.425235), 2);















