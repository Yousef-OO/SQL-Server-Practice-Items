-- Window Ranking Fucntions
-- 1) Top/Bottom N Analysis functions: ROW_NUMBER(), RANK(), DENSE_RANK(), and NTILE()
-- 2) Distribution Analysis functions: CUME_DIST(), and PERCENT_RANK()

-- Syntax of rank functions: RANK() OVER(PARTITION BY something ORDER BY something) the order by clause is required


---------------------------------------------------------

-- 1) ROW_NUMBER(): assign a unique number to each row


-- rank orders based on sales

SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS rank_num -- order by is a must here
FROM Sales.Orders;


------------------------------------------------------

-- 2) RANK(): assign a unique number to each row.
-- but it differs from the row_number funciton where it can handle the ties or the similar values and give them the same rank
-- and therfore it leaves gabs or skipping ranks (e.g. 1,2,2,4,5)


-- rank orders based on sales

SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS rank_num,
	RANK() OVER(ORDER BY Sales DESC) AS rank_num_rank -- order by is a must here
FROM Sales.Orders;


------------------------------------------------------

-- 3) DENSE_RANK(): same as rank function but it doesn't leave any gabs or skip any values



SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS rank_num,
	RANK() OVER(ORDER BY Sales DESC) AS rank_num_rank, -- order by is a must here
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS rank_dense
FROM Sales.Orders;


---------------------------------------------------
-- ROW_NUMBER() function is heavily used in real projects to analyze top/bottom sales or whatever it might be



-- find the top highest sales for each product

SELECT 
	*
FROM (
		SELECT
			OrderID,
			ProductID,
			Sales,
			ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) Rank_by_product
		FROM Sales.Orders) t
WHERE Rank_by_product = 1;


-- generate unique ids for the table orderArchive


SELECT
	ROW_NUMBER() OVER(ORDER BY OrderID) AS Unique_id,
	*
FROM Sales.OrdersArchive;


-- Paginating: breaking down large data into smaller, more manageable chunks
-- Identify duplicates using row_number()


SELECT
	*
FROM (
		SELECT
			ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
			*
		FROM Sales.OrdersArchive) t
WHERE rn = 1;



-- So to summarize: ROW_NUMBER() is used in many cases like: 1) top N analysis 2) bottom N analysis 3) assigning unique ids and 4) identifying duplicates




----------------------------------------------------


-- 4) CUME_DIST(): it stands for cumulative distribution and it calculates the distribution of data points within a window
--                 if there's a shared value or a tie. It takes last occurance 


-- 5) PERCENT_RANK(): it calculates the relative postion of each row in each window
--                    if there's a shared value or a tie. It takes the first occurance




-- the products that fall within the highest 40% of the prices

SELECT 
	*
FROM (
		SELECT
			Product,
			Price,
			CUME_DIST() OVER(ORDER BY PRICE DESC) dist_rank
		FROM Sales.Products) t
WHERE dist_rank <= 0.4;




-------------------------------------------------------------

-- 6) NTILE: divides the rows into a specified number of approximately equal groups or bukets
--           in case the bucket numbers are odd, the larger groups come first

-- use cases: data segmentation (diviing a dataset into subsets based on certain criteria)




SELECT
	OrderID,
	Sales,
	NTILE(3) OVER(ORDER BY Sales DESC) buket_3
FROM Sales.Orders;




-- divide all orders into 3 categories

SELECT
	*,
	CASE 
		WHEN buckets_3 = 1 THEN 'high'
		WHEN buckets_3 = 2 THEN 'Medium'
		WHEN buckets_3 = 3 THEN 'Low'
	END AS customers_segmentaion
FROM (
		SELECT
			OrderID,
			Sales,
			NTILE(3) OVER(ORDER BY Sales DESC) buckets_3
		FROM Sales.Orders) t;



