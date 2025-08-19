# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Cleaning

- **Check for Null values**: Check for any null values in the dataset.
```sql
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
```
- **Delete Null values**: Delete records with missing data.
```sql
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
```
### 3. Data Exploration
- **Check the number of sales.**
```sql
SELECT COUNT (*) AS total_sale FROM retail_sales
```

- **Check the number of unique customers.**
```sql
SELECT COUNT (DISTINCT customer_id) AS total_sale FROM retail_sales
```

- **Check the number of categories.**
```sql
SELECT DISTINCT category FROM retail_sales
```

### 4. Data Analysis and Business Problems

The following SQL queries answer specific business questions:

1. **Write an SQL query to retrieve all columns for sales made on '2022-11-05'.**
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'; 
```

2. **Write an SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more that 4 in the month of Nov-2022.**
```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	AND
	TO_CHAR (sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4;
```

3. **Write an SQL query to calculate the total sales for each category.**
```sql
SELECT category,	
	 SUM(total_sale) as net_sale,
	 COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

4. **Write an SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
```sql
SELECT category,
	 ROUND(AVG(age), 2) as average_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;
```

5. **Write an SQL query to find all transactions where the total_sale s greater than 1000.**
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

6. **Write an SQL query to find the total number of transactions made by each gender in each category.**
```sql
SELECT category,
	   gender,
	   COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category,
		 gender;
```

7. **Write an SQL query to calculate the average sale for each month. Find out the best selling month in each year.**
```sql
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
```

8. **Write an SQL query to find the top customers based on the highest total sales.**
```sql
SELECT 
	 customer_id, 
	 SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5; 
```

9. **Write an SQL query to find the number of unique customers who purchased items from each category.**
```sql
SELECT
	  category,
	  COUNT(DISTINCT customer_id) as ctg_unique_cst
FROM retail_sales
GROUP BY category;
```

10. **Write an SQL query to create each shift and number of orders(Example: Morning <=12, Afternoon between 12 and 17, and Evening > 17).**
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


## Author - Mayank Ahuja

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. 