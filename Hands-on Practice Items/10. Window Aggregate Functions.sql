-- window aggregate functions syntax: AGG(exp) OVER( PARTIION BY somthing ORDER BY something)
-- aggregate functions: COUNT(), SUM(), AVG(), MIN(), and MAX()
-- the regular aggregate functions outside the scope of window functions used to return quick summary or snapshot of the entire dataset
-- but the window aggregate fucntions return a more specific without losing details or information (Group-wise analysis, to understand patterns within differnet categories)
-- If we wnat to not ignore the null or deal with them as zeros we have to replace them first using COALESCE and then calcualting the aggregation
-- Running & Rolling totals (tracking current sales with target sales for example and trend analysis also)


-----------------------------------------------------------------------------

-- 1) Window function COUNT: returns the number of row within each window
-- COUNT(*)                 --> nulls are not ignored (they are counted)
-- COUNT(specific variable) --> Counts the non-null values in that variable (to check the quality of the data)
-- Count common uses are: 1) overall analysis, 2) category analysis, 3) quality checks(Identifying Nulls), and 4)quality checks(Identifying duplicates)
SELECT 
	OrderID, 
	OrderDate,
	COUNT(*) OVER() Total_Orders
FROM Sales.Orders;


SELECT 
	OrderID, 
	OrderDate,
	CustomerID,
	COUNT(*) OVER() Total_Orders,
	COUNT(*) OVER(PARTITION BY CustomerID) orders_by_customer
FROM Sales.Orders;



SELECT
	*,
	COUNT(*) OVER() total_customers,
	COUNT(Score) OVER() total_scores
FROM Sales.Customers;


-- checking duplicates

SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) checkPK
FROM Sales.Orders;


SELECT
	*
FROM(
SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) checkPK
FROM Sales.OrdersArchive) t
WHERE checkPK >1;




--------------------------------

-- 2) Window function SUM: returns the sum of all values within each window
-- Window function sum common uses: 1) quick summary and snapshot about the data, 2) group-wise analysis, to understand patterns of differnet categories, and 3) part to whole analysis




SELECT
	OrderID,
	OrderDate,
	Sales,
	SUM(Sales) OVER() total_sales
FROM Sales.Orders;


SELECT
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	SUM(Sales) OVER() total_sales,
	SUM(Sales) OVER(PARTITION BY ProductID) total_sales_by_productID
FROM Sales.Orders;

-- find the percentage contribution of each product's sales to the total sales


SELECT
	OrderID,
	OrderDate,
	Sales,
	CAST((SUM(Sales) OVER(PARTITION BY ProductID)) AS FLOAT) / (SUM(Sales) OVER()) * 100 AS sales_percent
FROM Sales.Orders;



--------------------------------

-- 3) Window function AVG: returns the avg of each window
-- It ignores the null values entirely
-- Window function avg common uses: 1) quick summary and snapshot about the data, 2) group-wise analysis, to understand patterns of differnet categories,
-- and 3) comparison with the average (helps to evaluate whether a value is above or below the average)



SELECT
	OrderID,
	OrderDate,
	Sales,
	AVG(Sales) OVER() AVGSales,
	AVG(Sales) OVER(PARTITION BY ProductID) AVGSAlesByProducts
FROM Sales.Orders;



SELECT
	CustomerID,
	LastName,
	Score,
	COALESCE(Score, 0) CustomerScore,
	AVG(Score) OVER() AVGScore,
	AVG(COALESCE(Score, 0)) OVER() AVGScoreWithNull
FROM Sales.Customers;



SELECT
	*
FROM(
	SELECT
		OrderID,
		ProductID,
		Sales,
		AVG(Sales) OVER() AVGSales
	FROM Sales.Orders) t
WHERE Sales > AVGSales;



--------------------------------

-- 3) Window function MIN and Max: return the min and max values of each window
-- the lowest value will be Null if found so they should be handled first
-- Good use of min and max functions is they help to evaluate how well a value is performing relative to the extremes

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER(PARTITION BY ProductID) HighestSales,
	MIN(Sales) OVER(PARTITION BY ProductID) LowestSales
FROM Sales.Orders;


-- highest salaries?


SELECT
	*
FROM  (
	SELECT 
		*,
		MAX(Salary) OVER() highestSalary
	FROM Sales.Employees) t
WHERE Salary = highestSalary;




SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER() HighestSales,
	MIN(Sales) OVER() LowestSales,
	Sales - MIN(Sales) OVER() AS deviationFromMin,
	MAX(Sales) OVER() - Sales deviationFromMax

FROM Sales.Orders;



-- Calculate the moving average of sales of each product


SELECT 
	OrderID,
	ProductID,
	OrderDate,
	SAles,
	AVG(Sales) OVER(PARTITION BY ProductID) AS AVG_by_product,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) AS moving_average,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN  CURRENT ROW AND 1 FOLLOWING) AS Rolling_avg
FROM Sales.Orders;















