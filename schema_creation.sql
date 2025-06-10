-- dim_user
CREATE TABLE dim_user (
    user_key SERIAL PRIMARY KEY,
    user_id VARCHAR
);

-- dim_product
CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id VARCHAR(50) UNIQUE
);

-- dim_category
CREATE TABLE dim_category (
    category_key SERIAL PRIMARY KEY,
    category VARCHAR(100) UNIQUE
);

-- dim_payment_method
CREATE TABLE dim_payment_method (
    payment_method_key SERIAL PRIMARY KEY,
    payment_method VARCHAR(50) UNIQUE
);

-- dim_date
CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    year INT
);

CREATE TABLE fact_sales (
    sales_key SERIAL PRIMARY KEY,
    user_key INT REFERENCES dim_user(user_key),
    product_key INT REFERENCES dim_product(product_key),
    category_key INT REFERENCES dim_category(category_key),
    payment_method_key INT REFERENCES dim_payment_method(payment_method_key),
    date_key INT REFERENCES dim_date(date_id),
    price NUMERIC,
    discount NUMERIC,
    final_price NUMERIC
);