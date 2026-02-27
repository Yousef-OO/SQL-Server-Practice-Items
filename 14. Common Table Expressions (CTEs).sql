-- Common Table Expressions (CTEs)

-- They are temporary, named result set (virtual table), that can be used multipe times within a query
-- to simplify and organize complex queries

-- the concept looks a bit like subqueries but there's more than one differnece:
-- the way we write CTEs differ (from top to bottom), on the other hand the subquereies are written from bottom to top
-- and the CTEs can be used multiple times in the main query 
-- using CTEs can reduce redundency, enhances readability, and reusability

-- CTE types:
-- 1) non-recursive CTE (standalone or nested CTEs) and it executed only one time witout any repetition
-- 2) Recursive CTE

-- One rule about CTEs is that you can use any type of clause inside it but not the ORDER BY clause

-- best practice:
-- Try not to overuse CTEs (don't use more than 5 in a query)

-----------------------------------------------------------------------


-- Standalone CTE (Non-recursive): Defined and used independntly. Runs independntly and self-contained and doesn't rely on other CTEs or queries.
-- Syntax: WITH CTE_Name AS (SELECT ..... FROM .... WHERE ....)  SELECT.... FROM CTE_Name WHERE ....


-- total sales per customer


WITH CTE_total_sales AS(
SELECT
	CustomerID,
	SUM(Sales) AS total_sales
FROM Sales.Orders
GROUP BY CustomerID)
-- main query
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.total_sales
FROM Sales.Customers c
INNER JOIN CTE_total_sales cts
ON cts.CustomerID = c.CustomerID;

--------------------------

-- multiple standalone CTEs


-- find the last order date for each customer

WITH CTE_total_sales AS(
SELECT
	CustomerID,
	SUM(Sales) AS total_sales
FROM Sales.Orders
GROUP BY CustomerID),
CTE_Last_Order AS (
SELECT
	CustomerID,
	MAX(OrderDate) Last_order
FROM Sales.Orders
GROUP BY CustomerID)
-- main query
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.total_sales,
	clo.Last_Order
FROM Sales.Customers c
INNER JOIN CTE_total_sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_last_order clo
ON clo.CustomerID = c.CustomerID;




-------------------------------------

-- Nested CTEs: CTE inside anohter CTE (it uses the result of another CTE, so it can't run idnependntly)


-- Also rank customers based on total sales per customers, and segment them based on their total sales

WITH CTE_total_sales AS(
SELECT
	CustomerID,
	SUM(Sales) AS total_sales
FROM Sales.Orders
GROUP BY CustomerID),
CTE_Last_Order AS (
SELECT
	CustomerID,
	MAX(OrderDate) Last_order
FROM Sales.Orders
GROUP BY CustomerID),
CTE_Customer_Rank AS (
SELECT
	CustomerID,
	total_sales,
	RANK() OVER(ORDER BY total_sales DESC) AS Rank_of_sales
FROM CTE_total_sales),
CTE_Customer_Segment AS(
SELECT
	CustomerID,
	CASE
		WHEN total_sales > 100 THEN 'Hight'
		WHEN total_sales > 50 THEN 'Medium'
		ELSE 'Low'
	END AS Customer_Segment
FROM CTE_total_sales)
-- main query
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.total_sales,
	clo.Last_Order,
	ccr.Rank_of_sales,
	ctss.Customer_Segment
FROM Sales.Customers c
INNER JOIN CTE_total_sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_last_order clo
ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank AS ccr
ON ccr.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segment AS ctss
ON ctss.CustomerID = c.CustomerID;



----------------------------------------------


-- Recursive CTE: is a self-referencing query that repeatedly processes data until a specific condition is met


-- anchor query
WITH Series AS(
SELECT 
	1 AS num
UNION ALL
-- recursive query
SELECT 
	num + 1 AS next_num
FROM Series
WHERE num < 1000
)
SELECT 
	*
FROM Series
OPTION (MAXRECURSION 1000)


-- show employees hirearchy

-- Anchor query
WITH CTE_Emp_hirearchy AS (
SELECT
	EmployeeID,
	FirstName,
	ManagerID,
	1 AS Level
FROM Sales.Employees
WHERE ManagerID IS NULL
UNION ALL
-- recursive query
SELECT 
	EmployeeID,
	FirstName,
	ManagerID,
	2 AS Level
FROM Sales.Employees)


SELECT 
*
FROM CTE_Emp_hirearchy

































