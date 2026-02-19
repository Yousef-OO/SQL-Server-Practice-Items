-- Nulls and how to handle them
-- Null is nothing, or unknown! It's not zero, not an empty string, not a blank space

-- 1) ISNULL(Replaces a NULL with a specific value)
-- 2) COALESCE (Returns the first non-null value from a list)
-- 3) NULLIF (replace values with NULLs)
-- 4) IS NULL & IS NOT NULL (check for NULLs)



-- 1) ISNULL(Replaces a NULL with a specific value)
-- Syntax: ISNULL(value, replacement_value)

-- 2) COALESCE (Returns the first non-null value from a list)
-- syntax: COALESCE(value1, value2, value3, ...)


--------------------------------------------------------------------------------------

-- Handling Nulls 
-- Aggregation functions like: MIN, MAX, and AVG don't consider the NULL values 
-- While (COUNT(*)) counts the non-Null and Null values




SELECT 
	customerID,
	score,
	COALESCE(Score, 0) avgscore2,
	AVG(score) OVER () avgScore1,
	AVG(COALESCE(Score, 0)) OVER() avgscore2
FROM Sales.Customers;



-- For any operation if one value is NULL, the result will be Null as well

SELECT
	customerID,
	FirstName,
	LastName,
	Score,
	FirstName + ' ' + LastName AS FullName
FROM Sales.Customers;



SELECT
	customerID,
	FirstName,
	LastName,
	Score,
	Score + 10 AS bonus_score
FROM Sales.Customers;


SELECT
	customerID,
	FirstName,
	LastName,
	Score,
	ISNULL(Score, 0) + 10 AS bonus_score
FROM Sales.Customers;




-- Handling nulls to sort the data



SELECT
	customerID,
	Score,
	CASE WHEN Score IS NULL THEN 1 ELSE 0 END AS flag
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score;




-- NULLIF(): Compares two expressions to check if a value is unusual in a column, returns:
-- 1) NULL, if they are equal
-- 2) First value, if they aren't the same
-- syntax: NULLIF(value1, value2)



-- A use case using NULLIF to make sure we're not dividing by zero
SELECT
	OrderID,
	Sales,
	Quantity,
	Sales/ NULLIF(Quantity, 0) AS Price
FROM Sales.Orders;




-- IS NULL (check if the value is null or not (IS NOT NULL))
-- Returns TRUE or FALSE depending on the value we're checking

-- Identify the customers who have null scores

SELECT
	*
FROM Sales.Customers
WHERE Score IS NULL;



SELECT
	*
FROM Sales.Customers
WHERE Score IS NOT NULL;




-- Very important considerations when dealing with data that has nulls
-- Data Policy: Set of rules that defines how data should be handled
-- 1) Only use NULLs and empty strings, but avoid blank spaces(Use Trim functions).
-- 2) Only Use Nulls and avoid both(convert values to nulls using IFNULL function).
-- 3) Use a default value (for instance Unknown or zero) and avoid all of them(Coalesce function is suitable here).









