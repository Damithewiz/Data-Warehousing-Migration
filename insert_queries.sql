INSERT INTO dim_user (user_id)
SELECT DISTINCT "User_ID"
FROM stg_ecommerce_sales
WHERE "User_ID" IS NOT NULL;

INSERT INTO dim_product (product_id)
SELECT DISTINCT "Product_ID"
FROM stg_ecommerce_sales
WHERE "Product_ID" IS NOT NULL;

INSERT INTO dim_category (category)
SELECT DISTINCT "Category"
FROM stg_ecommerce_sales;

INSERT INTO dim_payment_method (payment_method)
SELECT DISTINCT "Payment_Method"
FROM stg_ecommerce_sales;

INSERT INTO dim_date (full_date, day, month, year)
SELECT 
    TO_DATE("Purchase_Date", 'DD-MM-YYYY') AS full_date,
    EXTRACT(DAY FROM TO_DATE("Purchase_Date", 'DD-MM-YYYY')) AS day,
    EXTRACT(MONTH FROM TO_DATE("Purchase_Date", 'DD-MM-YYYY')) AS month,
    EXTRACT(YEAR FROM TO_DATE("Purchase_Date", 'DD-MM-YYYY')) AS year
FROM (
    SELECT DISTINCT "Purchase_Date"
    FROM stg_ecommerce_sales
) AS distinct_dates;


INSERT INTO fact_sales (
    user_key,
    product_key,
    category_key,
    payment_method_key,
    date_key,
    price,
    discount,
    final_price
)
SELECT
    u.user_key,
    p.product_key,
    c.category_key,
    pm.payment_method_key,
    d.date_id,
    CAST(s."Price (Rs.)" AS NUMERIC),
    CAST(s."Discount (%)" AS NUMERIC),
    CAST(s."Final_Price(Rs.)" AS NUMERIC)
FROM stg_ecommerce_sales s
JOIN dim_user u ON s."User_ID" = u.user_id
JOIN dim_product p ON s."Product_ID" = p.product_id
JOIN dim_category c ON s."Category" = c.category
JOIN dim_payment_method pm ON s."Payment_Method" = pm.payment_method
JOIN dim_date d ON TO_DATE(s."Purchase_Date", 'DD-MM-YYYY') = d.full_date;




