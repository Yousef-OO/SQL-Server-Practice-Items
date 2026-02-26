-- Window Value Functions
-- LAG, LEAD, FIRST_VALUE, and LAST_VALUE

-- LEAD, and LAG functions:
-- They are very useful in time series analysis (e.g. MoM or YoY analysis)
-- useful in customer retention analysis (measures customers' behavior and loyalty)




--------------------------------------------------------

-- 1) LEAD(): access a value from the next row within a window
-- 2) LAG(): access a value from the previous row within a window


SELECT
	*,
	ROUND(CAST((CurrentMSales - MonthBefore) AS FLOAT) / MonthBefore * 100, 2) AS MoM_Sales
FROM (
		SELECT
			MONTH(OrderDate) OrderMonth,
			SUM(Sales) CurrentMSales,
			LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) AS MonthBefore
		FROM Sales.Orders
		GROUP BY MONTH(OrderDate)) t



-- Checking customer loyality (customer retention analysis)

SELECT
	CustomerID,
	AVG(D_Till_NextOrder) Avg_Days,
	RANK() OVER(ORDER BY COALESCE(AVG(D_Till_NextOrder), 99999)) RankAvg
FROM (
		SELECT
			OrderID,
			CustomerID,
			OrderDate CurrentOrder,
			LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) Next_Order,
			DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) D_Till_NextOrder
		FROM Sales.Orders) t
GROUP BY CustomerID;


-- Time Gab Analysis (Number of days between orders)

SELECT
	OrderID,
	OrderDate AS CurrentOrderDate,
	LAG(OrderDate) OVER(ORDER BY OrderDate) AS PreviousOrderDate,
	DATEDIFF(DAY, LAG(OrderDate) OVER(ORDER BY OrderDate), OrderDate) AS NrOfDays 
FROM Sales.Orders;



-------------------------------------------

-- 3) FIRST_VALUE: access a value from the first row within a window
-- 4) LAST_VALUE:  access a value from the last row within a window



SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) lowes_sales,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) highest_sales
FROM Sales.Orders




