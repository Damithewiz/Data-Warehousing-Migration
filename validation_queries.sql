-- row count check
SELECT COUNT(*) AS fact_sales_count FROM fact_sales;
SELECT COUNT(*) AS stg_sales_count FROM stg_ecommerce_sales;


-- confirming referential integrity (JOINS) 
-- for user 
SELECT COUNT(*) AS orphaned_users
FROM fact_sales f
LEFT JOIN dim_user u ON f.user_key = u.user_key
WHERE u.user_key IS NULL;

-- for product
SELECT COUNT(*) AS orphaned_products
FROM fact_sales f
LEFT JOIN dim_product p ON f.product_key = p.product_key
WHERE p.product_key IS NULL;

-- for category
SELECT COUNT(*) AS orphaned_categories
FROM fact_sales f
LEFT JOIN dim_category c ON f.category_key = c.category_key
WHERE c.category_key IS NULL;

-- for payment method
SELECT COUNT(*) AS orphaned_payment_methods
FROM fact_sales f
LEFT JOIN dim_payment_method pm ON f.payment_method_key = pm.payment_method_key
WHERE pm.payment_method_key IS NULL;

-- for date
SELECT COUNT(*) AS orphaned_dates
FROM fact_sales f
LEFT JOIN dim_date d ON f.date_key = d.date_id
WHERE d.date_id IS NULL;


-- checking for duplicates in dimension tables
-- for user
SELECT user_id, COUNT(*)
FROM dim_user
GROUP BY user_id
HAVING COUNT(*) > 1;

-- for product
SELECT product_id, COUNT(*)
FROM dim_product
GROUP BY product_id
HAVING COUNT(*) > 1;

-- for category
SELECT category, COUNT(*)
FROM dim_category
GROUP BY category
HAVING COUNT(*) > 1;

-- for payment method
SELECT payment_method, COUNT(*)
FROM dim_payment_method
GROUP BY payment_method
HAVING COUNT(*) > 1;

-- for date
SELECT date_id, COUNT(*)
FROM dim_date
GROUP BY date_id
HAVING COUNT(*) > 1;


SELECT * FROM fact_sales LIMIT 10;


-- checking for null foreign keys
SELECT COUNT(*) AS null_keys_count
FROM fact_sales
WHERE user_key IS NULL
   OR product_key IS NULL
   OR category_key IS NULL
   OR payment_method_key IS NULL
   OR date_key IS NULL;

-- verifying mappings
SELECT f.sales_key, u.user_id, p.product_id, c.category, pm.payment_method, d.full_date
FROM fact_sales f
JOIN dim_user u ON f.user_key = u.user_key
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_category c ON f.category_key = c.category_key
JOIN dim_payment_method pm ON f.payment_method_key = pm.payment_method_key
JOIN dim_date d ON f.date_key = d.date_id
LIMIT 10;

-- Total Sales by Product Category 
SELECT 
    c.category AS category_name,
    SUM(f.final_price) AS total_sales,
    COUNT(f.sales_key) AS num_transactions
FROM fact_sales f
JOIN dim_category c ON f.category_key = c.category_key
GROUP BY c.category
ORDER BY total_sales DESC;

-- Total Sales by Payment Method
SELECT
    pm.payment_method,
    SUM(f.final_price) AS total_sales,
    COUNT(f.sales_key) AS num_transactions
FROM fact_sales f
JOIN dim_payment_method pm ON f.payment_method_key = pm.payment_method_key
GROUP BY pm.payment_method
ORDER BY total_sales DESC;

-- Daily Sales Trend
SELECT
    d.full_date,
    SUM(f.final_price) AS total_sales,
    COUNT(f.sales_key) AS num_transactions
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_id
GROUP BY d.full_date
ORDER BY d.full_date;
