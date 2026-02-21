-- When it comes to combining the tables by appending the rows we can use the set operators

-- Rules and restrictions:
-- Order by clause is used and allowed but only once at the end of the query when using the set operators
-- The number of columns of the two tables must be the SAME
-- The data types must match as well
-- the order of columns in the query must be the same also
-- the first is responsible for the alias or the name of the resulting table


-----------------------------------------------------------------------------------------------------------

-- 1) UNION: Returns all districs rows from both queries, and it removes duplicate rwos from the result, unlike UNION.


SELECT
	FirstName,
	LastName
FROM Sales.Customers
UNION ALL
SELECT
	FirstName,
	LastName
FROM Sales.Employees;


---------------------------

-- 2) UNION ALL: Combines all rows from both quereis including duplicates


SELECT
	FirstName,
	LastName
FROM Sales.Customers
UNION
SELECT
	FirstName,
	LastName
FROM Sales.Employees;


---------------------------

-- 3) EXCEPT: Returns all rows from the first query that are not found in the second query

-- customers who are not employees

SELECT
	FirstName,
	LastName
FROM Sales.Customers
EXCEPT
SELECT
	FirstName,
	LastName
FROM Sales.Employees;


---------------------------

-- 4) INTERSECT: It returns the rows existing in both quereis

SELECT
	FirstName,
	LastName
FROM Sales.Customers
INTERSECT
SELECT
	FirstName,
	LastName
FROM Sales.Employees;

---------------------------

-- 5) UNION ALL: 


SELECT
	FirstName,
	LastName
FROM Sales.Customers
UNION
SELECT
	FirstName,
	LastName
FROM Sales.Employees;















