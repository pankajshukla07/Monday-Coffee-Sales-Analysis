# Monday Coffee — Sales Data Analysis (SQL)

![Monday Coffee](https://img.shields.io/badge/Project-Data%20Analysis-blue) ![SQL](https://img.shields.io/badge/Tool-MySQL-orange) ![Status](https://img.shields.io/badge/Status-Complete-green)

## Project Overview

This project analyzes sales data for **Monday Coffee**, a fictional Indian coffee brand, using SQL (MySQL). The goal is to uncover business insights from 10,000+ transactions across 14 Indian cities spanning January 2023 to October 2024.

---

## Objectives

- Analyze coffee sales trends and business performance metrics
- Perform data extraction, filtering, aggregation, and reporting
- Generate insights on customer purchasing patterns, product performance, and revenue growth
- Identify high-potential cities for market expansion

---

## Dataset

| Table | Rows | Description |
|---|---|---|
| `sales` | 10,388 | Transaction records with date, product, customer, amount, rating |
| `products` | 28 | Coffee products and their prices |
| `customers` | 497 | Customer names and city mapping |
| `city` | 14 | City population, estimated rent, city rank |

**Date range:** Jan 2023 – Oct 2024  
**Cities covered:** Bangalore, Chennai, Pune, Delhi, Mumbai, Jaipur, Kolkata, Hyderabad, Ahmedabad, Surat, Indore, Kanpur, Nagpur, Lucknow

---

## Schema

```
city ──< customers ──< sales >── products
```

---

## Questions Solved

### Easy-Medium
| # | Question |
|---|---|
| Q1 | Coffee consumers count — estimated 25% of city population |
| Q2 | Total revenue from coffee sales in Q4 2023 |
| Q3 | Sales count for each product |
| Q4 | Average sales amount per customer per city |
| Q5 | City population and coffee consumers list |

### Medium
| # | Question |
|---|---|
| Q6 | Top 3 selling products in each city (using `RANK()`) |
| Q7 | Unique customer count per city |
| Q8 | Impact of estimated rent on sales (avg sale vs avg rent per customer) |

### Advanced
| # | Question |
|---|---|
| Q9 | Monthly sales growth % using `LAG()` window function |
| Q10 | Market potential — top 3 cities by sales, rent, customers, consumers |

---

## Key Insights

- **Pune** is the top revenue city at ₹12.58L, with the best sales-to-rent ratio — making it the strongest market
- **Cold Brew Pack (6 Bottles)** is the #1 product by both revenue (₹11.93L) and units sold (1,326)
- **November 2023** was the peak month at ₹7.09L — Sep–Nov 2023 saw a 169% spike, likely driven by a festive season campaign
- **Jaipur and Delhi** have the most customers (69 & 68), but Pune earns more — higher spend per visit
- **Mumbai and Hyderabad** have high rent-per-customer ratios, indicating tighter margins for new store openings
- **Bangalore and Chennai** have large untapped consumer bases (30L+ estimated coffee drinkers vs only 39–42 active customers)

---

## SQL Concepts Used

- `JOIN` across 4 tables
- `GROUP BY` with aggregation (`SUM`, `COUNT`, `AVG`, `ROUND`)
- `WHERE` with date range filtering
- `WITH` (Common Table Expressions)
- `RANK()` and `LAG()` window functions
- `DATE_FORMAT()` for time-series grouping
- Subqueries and derived tables

---

## How to Run

1. Open MySQL Workbench (or any MySQL client)
2. Run `scripts/01_create_tables.sql` to create the schema
3. Import the CSVs from `datasets/` into their respective tables  
   *(Right-click table → Table Data Import Wizard)*
4. Run `scripts/02_analysis_queries.sql` to execute all 10 queries

---

## Tools Used

- **MySQL** — query execution and analysis
- **MySQL Workbench** — schema design and data import

---

## Project Structure

```
monday-coffee-sql-analysis/
├── README.md
├── datasets/
│   ├── sales.csv
│   ├── products.csv
│   ├── customers.csv
│   └── city.csv
├── scripts/
│   ├── 01_create_tables.sql
│   └── 02_analysis_queries.sql
└── images/
    └── schema.png
```

---

## Author

**[Your Name]**  
Aspiring Data Analyst | SQL · Python · Power BI  
[LinkedIn](https://linkedin.com/in/yourprofile) · [GitHub](https://github.com/yourusername)
