-- Case statemtn: Evaluate a list of conditions and returns a value when a condition is met
-- Syntax: CASE WHEN Condition1 THEN Result WHEN Condition2 THEN Result ELSE Default_Result END AS Alias

-- Uses:
-- 1) CASE statements are essential in data transformation (by deriving additional information)
-- 2) Used to group the data into different categories based on certain conditions
-- 3) Used in mapping the data: Transforming the values from one form to another!
-- 4) Handling Nulls and replacing them with certain values
-- 5) Doing Conditional Aggregations

-- Rule:
--1) An important rule here is that the results of the case statement must be of the same data type

----------------------------------------------------------------------------------------------------------

-- Practice

SELECT
	Sales,
	CASE WHEN Sales >= 50 THEN 'Hight' 
	ELSE 'LOW'
	END AS Categories
FROM Sales.Orders;


-- Aggregations

SELECT 
	Categories,
	SUM(Sales) AS total_sales
FROM (SELECT
	Sales,
	CASE WHEN Sales >= 50 THEN 'Hight' 
	ELSE 'LOW'
	END AS Categories
FROM Sales.Orders) AS subtable
GROUP BY Categories
ORDER BY SUM(Sales) DESC;


-- mapping

SELECT
	EmployeeID,
	FirstName,
	LastName,
	Gender, 
	CASE 
		WHEN Gender = 'F' THEN 'Female'
		WHEN Gender = 'M' THEN 'Male'
		ELSE 'Other'
	END AS Gender_mapped

FROM Sales.Employees;



-- Conditional Aggregation
-- count how many times each customer has made an order with sales greater than 30

SELECT
	CustomerID,
	SUM(CASE
			WHEN Sales > 30 THEN 1
			ELSE 0
		END) AS orders_abobe_30
FROM Sales.Orders
GROUP BY CustomerID;




