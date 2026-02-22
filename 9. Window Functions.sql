-- Data Aggregations isn't done just by using aggregate functions but also we can use the Window functions to do that

-- Rules:
-- 1) Window functions can only be used in the SELECT and ORDER BY clauses
-- 2) Nesting widnow functions is NOT allowed
-- 3) SQL executes window functions AFTER where clause
-- 4) window functions can be used with GROUP BY in the same query, only if the same columns are used
------------------------------------- 

-- 1) Aggregate Functions (Count, Sum, Min, Max, and Avg)

SELECT
	COUNT(*) total_nr_orders,
	SUM(sales) AS total_sales,
	AVG(sales) AS avg_sales, 
	MIN(sales) AS lowest_sales,
	MAX(sales) AS highest_sales
FROM Sales.Orders;

------------------------------------- 

-- 2) Window Functions: perform calculations (e.g.aggregarion) on a specific subset of data, witout losing the level of details
-- Window Functions: 1- Aggregate (Count, Sum, Min, Max, Avg), 2- Rank(Row_Number(), Rank(), Dense_Rank(), Cume_Dist(), Percent_Rank(), and NTILE(n))
-- 3- Value (Lead, Lag, First_value, Last_value)



SELECT
	SUM(Sales) Toatal_sales
FROM Sales.Orders;



SELECT
	ProductID,
	SUM(Sales) Toatal_sales
FROM Sales.Orders
GROUP BY ProductID;



SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) AS total_sales
FROM Sales.Orders;


---------------------------

-- Syntax: (Window function - Over clause(partition, order, frame))
-- Over clause: tells sql that the function used is a window function and it defines a window or subset of data


-- Partition by --> window function (expr) Over(partition by category) 
-- It divides the result set into partitions


SELECT
	OrderID,
	OrderDate,
	SUM(Sales) OVER()
FROM Sales.Orders;



SELECT
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(Sales) OVER() total_sales,
	SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) divided_sales
FROM Sales.Orders;

---------------------------------

-- ORDER by clause is required when using the rank and value functions but optional when using the aggregate functions
-- unlike partition by clause it's optional in all cases

SELECT
	OrderID,
	OrderDate,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders;



-----------------------------------

-- Window Frame: Defines a subset of rows within each window that is relevant for the calculation
-- Frame clause can only be used together with order by clause
-- lower value must be before the higher value
-- Syntax: frame type (rows, range) BETWEEN (lower frame boundary) AND (Higher Frame Boundary)


SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders;




SELECT
	CustomerID,
	SUM(Sales) TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID;