-- Date, Time, and Timestamp functions are very important 
-- In this Script I'm going to practice usig them
-- to Extract or calculate certain pieces of dates or metrics


SELECT 
	OrderID,
	ORderDate,
	ShipDate,
	CreationTime
FROM Sales.Orders;

-- Date & Time Functions:
-- 1) Part Extraction (Day, Month, Year, DatePart, DateName, DateTrunc, EoMonth)
-- 2) Format & Casting (Format, Convert, and Cast)
-- 3) Calculations (DateAdd, DateDiff)
-- 4) Validation (IsDate)



-- Extracting (year, month, or day) --> number

SELECT 
	CreationTime, 
	YEAR(CreationTime) AS Year,
	MONTH(CreationTime) AS Month, 
	DAY(CreationTime) AS Day
FROM Sales.ORders;


-- DatePart (extracts specific part of the date as a number) --> number
-- syntax: DATEPART(part, Date)

SELECT
	CreationTime,
	DATEPART(year, CreationTime) year_dp,
	DATEPART(month, CreationTime) mon_dp,
	DATEPART(day, CreationTime) day_dp,
	DATEPART(Quarter, CreationTime) Q_dp,
	DATEPART(Week, CreationTime) W_dp,
	DATEPART(Hour, CreationTime) H_dp,
	DATEPART(Minute, CreationTime) Min_dp,
	DATEPART(Second, CreationTime) Sec_dp
FROM Sales.Orders;


-- DateName: Returns the name of a specific part of a date
-- number --> Name(string) 

SELECT
	CreationTime,
	DATENAME(MONTH, CreationTime) month_name,
	DATENAME(WEEKDAY, CreationTime) Day_name
FROM Sales.Orders;


-- DATETRUNC(), It truncates the part from a date
-- DATETRUNC(part, date), part(included)

SELECT
	CreationTime,
	DATETRUNC(SECOND, CreationTime) millisec_truncated,
	DATETRUNC(MINUTE, CreationTime) sec_truncated,
	DATETRUNC(HOUR, CreationTime) min_truncated,
	DATETRUNC(DAY, CreationTime) hour_truncated,
	DATETRUNC(MONTH, CreationTime) day_truncated

FROM Sales.Orders;


SELECT 
	CreationTime,
	COUNT(*) AS orders_count
FROM Sales.Orders
GROUP BY CreationTime;

SELECT 
	DATETRUNC(Month, CreationTime) AS creation_month,
	COUNT(*) AS orders_count
FROM Sales.Orders
GROUP BY DATETRUNC(Month, CreationTime);



-- EOMONTH(End Of Month): Returns the last day of the month

SELECT
	CreationTime,
	EOMONTH(CreationTime)
FROM Sales.Orders;




-- Parts Extraction Use Case? Why they are important?
-- 1) Data Aggregations and Reprorts

-- for ex, how to know how many order were placed each year?


SELECT 
	Year(OrderDate) year_ordered,
	COUNT(*) Orders_num
FROM Sales.Orders
GROUP BY Year(OrderDate);


-- How many orderes were places each month?
SELECT 
	DATENAME(MONTH, (OrderDate)) AS Month_ordered,
	COUNT(*) Orders_num
FROM Sales.Orders
GROUP BY DATENAME(MONTH, (OrderDate));



-- These functions are very common in context of filtering the data based
-- on certain part of the time (year, month, day, etc)
-- show all orders that were places in feburary?
SELECT 
	*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2; -- this is best practice

SELECT 
	*,
	DATENAME(Month, OrderDate) AS month
FROM Sales.Orders
WHERE DATENAME(Month, OrderDate) = 'February';



-- Extract Functions results Datatypes?
-- Day, Month, Year, and DatePart --> Integer
-- DateName  --> String value
-- DateTrunc --> DateTime object
-- EOMonth   --> Date object result





-- Formatting & Casting

-- DateTime format is like: 
-- International Standard:yyyy-MM-dd HH:mm:ss

-- Formatting is changing the format of a value to another form
-- maybe we might need to change the date&time format from the ISO standards to the USA standards

-- Casting is the porcess of changing the data type from one to another
-- by using CAST(), and Convert()



-- 1) Format Function syntax:
--    FORMAT(value, format[,culture])

SELECT 
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'dd') int_day,
	FORMAT(CreationTime, 'ddd') abb_day,
	FORMAT(CreationTime, 'dddd') full_day
FROM Sales.Orders;


SELECT 
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'MM') int_month,
	FORMAT(CreationTime, 'MMM') abb_month,
	FORMAT(CreationTime, 'MMMM') full_month
FROM Sales.Orders;


SELECT 
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'dddd-MMMM-yyyy') full_date,
	FORMAT(CreationTime, 'MMM,dd,yyy') full_date_2
FROM Sales.Orders;


SELECT
	FORMAT(OrderDate, 'MMM yyyy') datee,
	COUNT(*) countt
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yyyy');

-- CONVERT() function is used to change the date or time values to a diffenret data type
-- CONVERT(data_type, value [,style])

SELECT
	CONVERT(INT, '123') As str_to_int,
	CONVERT(DATE, '2024-09-12') AS str_to_date



-- CAST() converts a value to a specified data type
-- CAST(value AS data_type)

SELECT 
	CAST('123' AS INT) casted_int







-- Date Calculations (DateADD)
-- it allows us to add or subtract a specific time interval to/from a date.
-- DATEADD(part, interval, date)


SELECT 
	CreationTime,
	DATEADD(YEAR, 2, CreationTime) AS two_years_later,
	DATEADD(day, -1, CreationTime) AS one_day_before
FROM Sales.Orders;


-- DateDiff: allow us to find the difference between two dates
-- DATEDIFF(part, start_date, end_date)

-- Calculate the age of employees

SELECT 
	* 
FROM Sales.Employees;

SELECT
	EmployeeID,
	BirthDate,
	DATEDIFF(year, BirthDate, GETDATE()) Age
FROM Sales.Employees;







-- Date Validation (IsDate function)
-- It checks weather a value is a date or not
-- returns 1 if it's a valid date or 0 if it's not
-- ISDATE(value)

SELECT
	ISDATE('123') Date_check,
	ISDATE('2023-02-12') Date_check_2,
	ISDATE('12-02-2023') Date_check_3,
	ISDATE('2023') Date_check_4,
	ISDATE('08') Date_check_5












