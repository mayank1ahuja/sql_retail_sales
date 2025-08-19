--SQL Retail Sales Analysis - P1

-- Creating a Table
CREATE TABLE retail_sales
		(
		   transactions_id INT PRIMARY KEY, 
		   sale_date DATE,	
		   sale_time TIME,	
		   customer_id INT, 
		   gender VARCHAR(15),
		   age INT, 	
		   category VARCHAR(15), 	
		   quantiy INT, 	
		   price_per_unit FLOAT,	
		   cogs	FLOAT, 
		   total_sale FLOAT
		);

-- Data Cleaning Step
-- Checking for Null Value
SELECT * FROM retail_sales
WHERE
		transactions_id IS NULL
		OR 
		sale_date IS NULL
		OR 
		sale_time IS NULL
		OR 
		customer_id IS NULL
		OR 
		gender IS NULL
		OR 
		category IS NULL
		OR 
		quantiy IS NULL
		OR 
		price_per_unit IS NULL
		OR 
		cogs IS NULL
		OR 
		total_sale IS NULL;

-- Deleting the found Null Values
DELETE FROM retail_sales
WHERE
		transactions_id IS NULL
		OR 
		sale_date IS NULL
		OR 
		sale_time IS NULL
		OR 
		customer_id IS NULL
		OR 
		gender IS NULL
		OR 
		category IS NULL
		OR 
		quantiy IS NULL
		OR 
		price_per_unit IS NULL
		OR 
		cogs IS NULL
		OR 
		total_sale IS NULL;

-- Data Exploration
-- How many sales occured?
SELECT COUNT (*) AS total_sale FROM retail_sales

-- How many unique customers are present?
SELECT COUNT (DISTINCT customer_id) AS total_sale FROM retail_sales

-- What are the categories present?
SELECT DISTINCT category FROM retail_sales

-- Data Analysis and Key Business Problems
--Q.1 Write an SQL query to retrieve all columns for sales made on '2022-11-05'. 
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';  

--Q.2 Write an SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more that 4 in the month of Nov-2022.
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	AND
	TO_CHAR (sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4;

--Q.3 Write an SQL query to calculate the total sales for each category.
SELECT category,	
	 SUM(total_sale) as net_sale,
	 COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

--Q.4 Write an SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT category,
	 ROUND(AVG(age), 2) as average_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;

--Q.5 Write an SQL query to find all transactions where the total_sale s greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

--Q.6 Write an SQL query to find the total number of transactions made by each gender in each category.
SELECT category,
	   gender,
	   COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category,
		 gender;

--Q.7 Write an SQL query to calculate the average sale for each month. Find out the best selling month in each year.
SELECT
	 year,
	 month,
	 avg_sale
FROM
(
SELECT 
	 EXTRACT(YEAR FROM sale_date) as year,
	 EXTRACT(MONTH FROM sale_date) as month,
	 AVG(total_sale) as avg_sale,
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1;
--ORDER BY 1, 3 DESC

--Q.8 Write an SQL query to find the top customers based on the highest total sales.
SELECT 
	 customer_id, 
	 SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5; 

--Q.9 Write an SQL query to find the number of unique customers who purchased items from each category.
SELECT
	  category,
	  COUNT(DISTINCT customer_id) as ctg_unique_cst
FROM retail_sales
GROUP BY category;

--Q.10 Write an SQL query to create each shift and number of orders(Example: Morning <=12, Afternoon between 12 and 17, and Evening > 17).
WITH hourly_sale
AS
(
SELECT *,
	   CASE
		   WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'		   
		   ELSE 'Evening'
	   END AS shift
FROM retail_sales
)
SELECT 
	 COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift

--END OF PROJECT.