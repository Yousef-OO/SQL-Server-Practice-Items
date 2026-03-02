-- How to clean and filter your data?

-- Where operators are: 1)comparison (e.g. =, >, etc), 
-- 2) logical (And, or, Not), 3) Range (Between),
-- 4) Membership (In, Not IN), 
-- 5) Searching (Like)


-- 1) Comparison Operators

SELECT *
FROM customers
WHERE country = 'Germany';


SELECT *
FROM customers
WHERE country <> 'Germany';


SELECT * 
FROM customers
WHERE score >= 500;



-- 2) Logical Operators (AND, OR, and NOT)

SELECT *
FROM customers
WHERE country = 'USA' AND score > 200;


SELECT * 
FROM customers
WHERE country = 'Germany' OR score > 500;



SELECT *
FROM customers
WHERE NOT(score < 500); 




-- 3) Range operator (Between)

SELECT *
FROM customers
WHERE score BETWEEN 100 AND 800;




-- 4) Membership (IN, and Not IN)

SELECT *
FROM customers
WHERE country IN ('USA', 'Germany');



SELECT *
FROM customers
WHERE country NOT IN ('USA');




-- 5) Search operator (Like)

SELECT *
FROM customers
WHERE score LIKE '5%';



SELECT *
FROM customers
WHERE country NOT LIKE 'US_';


SELECT *
FROM customers
WHERE score LIKE '_0_';
















