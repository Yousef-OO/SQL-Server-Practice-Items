-- How to retrieve the information from your database?

SELECT *
FROM customers;


SELECT *
FROM orders;

SELECT 
	first_name,
	country,
	score
FROM customers;



-- Filtering the data

SELECT *
FROM customers
WHERE score != 0;

SELECT *
FROM customers
WHERE country = 'Germany';



-- Order by clause

SELECT *
FROM customers
ORDER BY score ASC;

SELECT *
FROM customers
ORDER BY country ASC, score DESC;


-- GROUP BY Clause

-- total score by country

SELECT 
	country,
	SUM(score) AS total_score -- aliasing
FROM customers
GROUP BY country;

-- Find the total score and the total number of customers for each country

SELECT 
	country,
	COUNT(score) AS total_score,
	COUNT(id) AS total_customers
FROM customers
GROUP BY country;




-- Having clause (Filtering the data after the aggregations happen, ulike where clause)

SELECT 
	country,
	SUM(score)
FROM customers
WHERE score > 400
GROUP BY country
HAVING SUM(score) > 800;




-- Distinct keyword

SELECT 
	DISTINCT country
FROM customers;


-- TOP or LIMIT to limit the rows returned

SELECT TOP 3 *
FROM customers;


