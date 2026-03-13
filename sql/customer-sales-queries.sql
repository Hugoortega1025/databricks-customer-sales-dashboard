-- Databricks Sales Dashboard SQL Queries
-- Dataset tables: fact_sales, dim_products, dim_customers
-- Used to generate metrics for the dashboard visualizations


SHOW tables;
DESCRIBE TABLE dim_customers;

--This grabs all unique countries in the table
SELECT DISTINCT country
FROM dim_customers
ORDER by country;

---This lists all unique categories, subcategories, and products in the products table
SELECT DISTINCT
category,
subcategory,
product_name
FROM dim_products
ORDER BY category, subcategory, product_name;

--Total Sales
SELECT SUM(sales_amount) AS Total_Sales
From fact_sales;

---Total Customers
SELECT COUNT (DISTINCT customer_id) as Total_Customers
FROM dim_customers;

---Total Products
SELECT COUNT (DISTINCT product_id) as Total_Products
FROM dim_products;

---Total Orders
SELECT COUNT (DISTINCT order_number) as Total_Orders
FROM fact_sales;

--Sales by product
SELECT p.product_name,
SUM(f.sales_amount) AS Total_Sales
FROM fact_sales f
JOIN dim_products p
  ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY Total_Sales DESC;

---Sales by Category
SELECT p.category,
SUM(f.sales_amount) AS Total_Sales
FROM fact_sales f 
JOIN dim_products p
  ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY Total_Sales DESC;

--Orders over time
SELECT order_date,
COUNT(DISTINCT order_number) AS Orders
FROM fact_sales
GROUP BY order_date
ORDER BY order_date;
