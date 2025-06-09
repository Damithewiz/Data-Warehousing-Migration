# Data Warehouse Staging Migration – E-Commerce Dataset
This project simulates a real-world ETL pipeline and data warehouse migration using a synthetic e-commerce dataset. The goal is to move data from a flat file into a fully normalized star schema using PostgreSQL, complete with dimension and fact tables.

## Project Objective

The aim of this project is to simulate a real-world data warehouse migration process using a synthetic e-commerce dataset. The goal is to extract, transform, and load (ETL) raw transaction data from a flat CSV file into a fully normalized star schema using PostgreSQL, empowering:

- Clean, consistent, and analysis-ready data storage.
- Scalable architecture for BI and reporting.
- Dimensional modeling practices aligned with modern data warehousing principles.

## Key Features
- Staging Table Loading via Python (SQLAlchemy).
- Star Schema Design with 5 dimension tables and 1 fact table.
- ETL Process Automation using SQL scripts.
- Referential Integrity Enforcement using foreign key constraints.
- Data Validation between staging and warehouse layers.
- Ready-to-query Schema for downstream reporting.

## Tools & Technologies
PostgreSQL – Core database engine
pgAdmin – SQL development environment
Python (Pandas, SQLAlchemy) – Data processing & staging
SQL – Schema design and transformations
E-commerce Dataset – Retail transaction data from Kaggle View the database link here: [Database Public Link](https://www.kaggle.com/datasets/steve1215rogg/e-commerce-dataset)

## Schema Overview
The project uses a classic Star Schema. Each table was carefully designed and normalized to reduce redundancy and support efficient querying with the following structure:
#### Dimension Tables:
- dim_user
- dim_product
- dim_category
- dim_payment_method
- dim_date
  
#### Fact Table:
- fact_sales
