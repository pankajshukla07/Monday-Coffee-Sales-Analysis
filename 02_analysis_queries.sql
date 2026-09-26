-- ============================================================
-- Monday Coffee Sales Analysis
-- Script 2: Analysis Queries
-- ============================================================

USE monday_coffee;


-- ─────────────────────────────────────────────
-- EASY-MEDIUM QUESTIONS
-- ─────────────────────────────────────────────

-- Q1: Coffee Consumers Count
-- How many people in each city are estimated to consume coffee
-- (assuming 25% of the population does)?

SELECT
    city_name,
    population,
    ROUND(population * 0.25) AS estimated_coffee_consumers
FROM city
ORDER BY estimated_coffee_consumers DESC;


-- Q2: Total Revenue from Coffee Sales (Last Quarter of 2023)
-- What is the total revenue generated from coffee sales
-- across all cities in Q4 2023?

SELECT
    SUM(total) AS total_revenue_q4_2023
FROM sales
WHERE sale_date BETWEEN '2023-10-01' AND '2023-12-31';


-- Q3: Sales Count for Each Product
-- How many units of each coffee product have been sold?

SELECT
    p.product_name,
    COUNT(s.sale_id) AS units_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC;


-- Q4: Average Sales Amount per City
-- What is the average sale amount per customer in each city?

SELECT
    ci.city_name,
    ROUND(AVG(s.total), 2) AS avg_sale_per_customer
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city ci      ON cu.city_id    = ci.city_id
GROUP BY ci.city_name
ORDER BY avg_sale_per_customer DESC;


-- Q5: City Population and Coffee Consumers
-- Provide a list of cities with population and estimated coffee consumers.

SELECT
    city_name,
    population,
    ROUND(population * 0.25) AS estimated_coffee_consumers
FROM city
ORDER BY population DESC;


-- ─────────────────────────────────────────────
-- MEDIUM QUESTIONS
-- ─────────────────────────────────────────────

-- Q6: Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?

WITH ranked_products AS (
    SELECT
        ci.city_name,
        p.product_name,
        COUNT(s.sale_id) AS units_sold,
        RANK() OVER (
            PARTITION BY ci.city_name
            ORDER BY COUNT(s.sale_id) DESC
        ) AS rnk
    FROM sales s
    JOIN products  p  ON s.product_id  = p.product_id
    JOIN customers cu ON s.customer_id = cu.customer_id
    JOIN city      ci ON cu.city_id    = ci.city_id
    GROUP BY ci.city_name, p.product_name
)
SELECT city_name, product_name, units_sold
FROM ranked_products
WHERE rnk <= 3
ORDER BY city_name, rnk;


-- Q7: Customer Segmentation by City
-- How many unique customers are there in each city
-- who have purchased coffee products?

SELECT
    ci.city_name,
    COUNT(DISTINCT s.customer_id) AS unique_customers
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city ci      ON cu.city_id    = ci.city_id
GROUP BY ci.city_name
ORDER BY unique_customers DESC;


-- Q8: Impact of Estimated Rent on Sales
-- Find each city's average sale per customer and average rent per customer.

SELECT
    ci.city_name,
    ROUND(SUM(s.total) / COUNT(DISTINCT s.customer_id), 2)        AS avg_sale_per_customer,
    ci.estimated_rent,
    ROUND(ci.estimated_rent / COUNT(DISTINCT s.customer_id), 2)   AS avg_rent_per_customer
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city ci      ON cu.city_id    = ci.city_id
GROUP BY ci.city_name, ci.estimated_rent
ORDER BY avg_sale_per_customer DESC;


-- ─────────────────────────────────────────────
-- ADVANCED QUESTIONS
-- ─────────────────────────────────────────────

-- Q9: Monthly Sales Growth
-- Calculate the percentage growth (or decline) in sales month over month.

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(sale_date, '%Y-%m') AS month,
        SUM(total)                      AS revenue
    FROM sales
    GROUP BY month
),
revenue_with_lag AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS prev_revenue
    FROM monthly_revenue
)
SELECT
    month,
    revenue,
    prev_revenue,
    ROUND(
        (revenue - prev_revenue) * 100.0 / prev_revenue,
        2
    ) AS growth_pct
FROM revenue_with_lag
ORDER BY month;


-- Q10: Market Potential Analysis
-- Identify the top 3 cities based on highest sales.
-- Return city name, total sales, total rent, total customers,
-- and estimated coffee consumers.

SELECT
    ci.city_name,
    SUM(s.total)                       AS total_sales,
    ci.estimated_rent                  AS total_rent,
    COUNT(DISTINCT s.customer_id)      AS total_customers,
    ROUND(ci.population * 0.25)        AS est_coffee_consumers
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city ci      ON cu.city_id    = ci.city_id
GROUP BY ci.city_name, ci.population, ci.estimated_rent
ORDER BY total_sales DESC
LIMIT 3;
