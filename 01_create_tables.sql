-- ============================================================
-- Monday Coffee Sales Analysis
-- Script 1: Create Database and Tables
-- ============================================================

CREATE DATABASE IF NOT EXISTS monday_coffee;
USE monday_coffee;

-- City table
CREATE TABLE city (
    city_id        INT PRIMARY KEY,
    city_name      VARCHAR(50),
    population     BIGINT,
    estimated_rent DECIMAL(10,2),
    city_rank      INT
);

-- Products table
CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(100),
    price        DECIMAL(10,2)
);

-- Customers table
CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city_id       INT,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

-- Sales table
CREATE TABLE sales (
    sale_id     INT PRIMARY KEY,
    sale_date   DATE,
    product_id  INT,
    customer_id INT,
    total       DECIMAL(10,2),
    rating      INT,
    FOREIGN KEY (product_id)  REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
