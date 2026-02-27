-- Subqueries: A query inside anohter query

-- Subqueries Categories:
-- based on the result type:       Scalar subqueries, multiple-rows subqueries, and table subquereis
-- based on the subquery location: It might exist in different clauses such as: 1) FROM clause, 2) SELECT, 3) JOIN, and 4) WHERE


-- Subqueries uses:
-- 1) create temporary result sets
-- 2) prepare data before joining tables
-- 3) dynamic & complex filtering
-- 4) check the existence of rows from another table (EXISTS)
-- 5) Row by row comparison - correlated subquereis--


---------------------------------------------------------------------

-- based on the result type: 1) Scalar query

SELECT
	AVG(Sales) Avg_Sales
FROM Sales.Orders;



-----------------------

-- based on the result type: 2) multiple-rows query

SELECT 
	DISTINCT CustomerID
FROM Sales.Customers;


-----------------------

-- based on the result type: 3) table query

SELECT
	OrderID,
	OrderDate
FROM Sales.Orders;


---------------------------------------------------------------------


-- based on the subquery location: 1) inside the FROM Clause


-- products with higher than average price?



SELECT
	*
FROM (
-- subquery
	SELECT 
		ProductID,
		Price,
		AVG(Price) OVER() Avg_price
	FROM Sales.Products) AS sub
WHERE Price > Avg_price;



-- rank customers based on their total sales

SELECT
	*,
	RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
FROM (
	SELECT	
		CustomerID,
		SUM(Sales) total_sales
	FROM Sales.Orders
	GROUP BY CustomerID) AS sub2;




-----------------------

-- based on the subquery location: 2) inside the SELECT Clause (used to aggregate data side by side with the main query's data, allowing for direct comparison)
-- Only scalar value must be retrieved from that subquery


-- example

SELECT
	ProductID,
	Product,
	Price,
	(SELECT COUNT(*) FROM Sales.Orders) AS total_orders
FROM Sales.Products;




-----------------------


-- based on the subquery location: 3) inside the JOIN clause(used to prepare the data before joining it with other tables)
-- It's like you're building a new table inside the join and then joining it with the main table



SELECT
	*
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.customerID = o.CustomerID;


SELECT
	c.*,
	o.total_orders
FROM Sales.Customers c
LEFT JOIN(
		SELECT 
			CustomerID,
			COUNT(*) total_orders
		FROM Sales.Orders
		GROUP BY CustomerID) o
ON c.customerID = o.CustomerID;




-----------------------

-- based on the subquery location: 4) inside the WHERE clause (used for complex filtering)
-- Must return a scalar value. Wheather by comparing (comparison operators >, =, etc), Or by using operators like (IN, ALL, EXISTS, ANY)



-- products with higher than average

SELECT
	ProductID,
	Price,
	(SELECT AVG(Price) FROM Sales.Products) avg_price
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products);



-----------------------

-- The IN operator (check if a value mathces a list of values)

-- show details of customers from Germany



SELECT
	*
FROM Sales.Customers
WHERE Country = 'Germany';


SELECT
	*
FROM Sales.Orders
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country = 'Germany');



-----------------------

-- ANY (at least a value is equal one value from the list) operator


-- find female employees whose salaries are greater than the salaries of *any* male employee


SELECT
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM Sales.Employees
WHERE Gender = 'F';


SELECT
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM Sales.Employees
WHERE Gender = 'M';


SELECT
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM Sales.Employees
WHERE Gender = 'F' AND
Salary > ANY(SELECT Salary FROM Sales.Employees WHERE Gender = 'M');


SELECT
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM Sales.Employees
WHERE Gender = 'F' AND
Salary > (SELECT MIN(Salary) FROM Sales.Employees WHERE Gender = 'M');


-----------------------

-- ALL operator (checks if a value mathces all values in a list)


-- salaries of males that are greater than *all* female employees?


SELECT
	EmployeeID,
	FirstName,
	Gender,
	Salary
FROM Sales.Employees
WHERE Gender = 'M' AND
Salary > ALL(SELECT Salary FROM Sales.Employees WHERE Gender = 'F');



---------------------------------------------------------------------

-- quereis depedence: (non correlated and correlated subquereis)
-- non correlated: runs independently from the main query (executed once; the subquery first then the main one)
-- correlated    : relies on values from the main query (row by row comparison, dynamic filtering)



-- correlated (it runs and executes row by row to check the condition hand in hand with the main query)

SELECT
	*,
	(SELECT COUNT(*) FROM Sales.Orders o WHERE o.CustomerID = c.CustomerID) AS total_orders
FROM Sales.Customers c




-----------------------

-- The operator EXISTS: Check if a subquerey returns any rows

-- show the details made by customers in Germany

SELECT
	*
FROM Sales.Orders;

SELECT
	*
FROM Sales.Orders o
WHERE EXISTS (
					SELECT 1
					FROM Sales.Customers c
					WHERE Country = 'Germany'
					AND c.CustomerID = o.CustomerID)




