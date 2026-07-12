# Data Engineering Tasks & Progress

This repository contains my weekly learning tasks, practice files, and mini implementations completed during the Data Engineering Internship at Celebal Technologies.  
It highlights hands-on work in data cleaning, preprocessing, and analysis using Python.

## 🛠️ Tech Stack

- **Languages:** Python, SQL, PySpark
- **Big Data & Cloud:** Apache Spark, Azure Data Factory (ADF), Azure Blob Storage
- **Libraries:** Pandas, NumPy, Faker, SQLite3, Tabulate
- **Tools/Environments:** Databricks, Google Colab, Jupyter Notebook, VS Code, MySQL Workbench
- **Databases & Data Formats:** MySQL, SQLite, Parquet, CSV

## 📅 Week 1 — Pandas Basics & Data Cleaning

### Objective

Perform data exploration and implement a dynamic data cleaning workflow on an E-commerce dataset using Pandas.

### Work Completed

- Explored dataset structure, columns, datatypes, and missing values.
- Implemented dynamic handling of null values:
  - Removed columns with excessive missing data.
  - Filled missing numeric values with `0`.
  - Filled missing categorical/text values with `"Not Available"`.
- Filtered and analyzed product data based on pricing conditions.
- Created derived columns for basic business calculations.
- Removed duplicate records to improve data quality.
- Exported the final cleaned dataset as `Cleaned_Combined_dataset_Final.csv`.

## 📅 Week 2 — SQL Data Analysis & Database Concepts

### Objective

Use SQL to analyze sales data, perform aggregations, and understand fundamental database concepts.

### Work Completed

- Imported and explored a sales dataset in MySQL.
- Wrote SQL queries for filtering, sorting, and data retrieval.
- Performed aggregations using `GROUP BY`, `SUM`, `AVG`, and `COUNT`.
- Analyzed monthly sales trends and top-performing customers/products.
- Conducted basic data quality checks and duplicate detection.

## 📅 Week 3 — Advanced SQL: CTEs & Window Functions

### Objective

Analyze the Superstore dataset using advanced SQL techniques to extract complex business intelligence and optimize query performance.

### Work Completed

- **Data Modeling:** Normalized a flat dataset into structured Dimension (`customers`, `products`) and Fact (`orders`) tables.
- **Subqueries:** Used derived tables (uncorrelated subqueries) via `JOIN` to drastically optimize query execution times on large datasets.
- **CTEs:** Built reusable, modular queries to calculate aggregate baselines, such as total customer sales.
- **Window Functions:** Applied `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()` for dynamic leaderboards and chronological order sequencing.
- **Performance Optimization:** Replaced $O(N^2)$ correlated subqueries with optimized derived tables (Uncorrelated Subqueries via `JOIN`) to drastically reduce execution time and prevent database timeouts on large datasets.

## 📅 Week 4 — Azure Cloud Fundamentals & ETL Pipeline

### Objective

Build an end-to-end ETL pipeline using Azure Data Factory (ADF) and Azure Blob Storage.

### Work Completed

- Created a Resource Group (`rg-celebal-week4`) for resource management.
- Configured Azure Storage Account with `input-data` and `output-data` Blob containers.
- Assigned appropriate IAM roles to ADF Managed Identity for secure storage access.
- Created an Azure Data Factory instance (`adf-celebal-week4`) with Linked Services and Datasets.

### Pipeline Workflow

- **Get Metadata** activity validates the source CSV file.
- **Copy Data** activity transfers data from the input container to the output container.
- Pipeline execution was tested and validated using the ADF Debug feature.

### Outcome

Successfully designed and executed an ETL pipeline that validates and transfers data between Azure Blob Storage containers using Azure Data Factory.

## 📅 Week 5 — Apache Spark & Distributed Data Pipelines

### Objective

Implement distributed data processing concepts and build modular PySpark pipelines for large-scale data cleaning and aggregation.

### Work Completed

- **Data Ingestion & Mocking:** Generated a custom CSV dataset to validate edge cases including structural nulls, duplicates, and empty strings.
- **Architecture Theory:** Documented core big data concepts including In-Memory computing, RDD immutability, and network shuffle operations.
- **Deduplication:** Cleaned datasets by removing duplicate records based on composite primary keys to ensure accurate reporting.
- **Data Aggregation:** Filtered large datasets and applied `groupBy` operations to calculate averages and volume counts (simulating SQL `HAVING`).
- **Data Quality & Null Handling:** Safely imputed missing categorical values using `.na.fill()` and actively filtered out empty strings.
- **Schema Transformation:** Standardized data types by casting raw string formats into proper `TimestampType` columns.
- **Statistical Analysis:** Computed simultaneous multi-metric aggregations (min, max, mean) using Spark's `.agg()` function.
- **End-to-End ETL Pipeline:** Built a fully chained, production-grade PySpark pipeline that deduplicates, imputes nulls, and calculates total revenue.

## 📅 Week 6 — Apache Spark Architecture & Advanced Processing

### Objective

Understand Spark architecture and build an optimized, end-to-end ETL pipeline using PySpark.

### Work Completed

- Documented core Spark architecture components (Driver, Cluster Manager, Executors) and execution modes.
- Generated and configured test datasets in both CSV (row-based) and Parquet (columnar) formats.
- Applied Spark performance optimizations including Lazy Evaluation, DAG Lineage, and Predicate Pushdown.
- Initialized a PySpark Session to execute and validate distributed transformations.

### Pipeline Workflow

- **Read Data** activity loads raw CSV/Parquet files utilizing `inferSchema=True` for dynamic typing.
- **Transform Data** activity renames columns, casts data types (String to Double), and derives new calculated columns.
- **Filter Data** activity isolates high-value records and removes rows with null identity values.
- **Write Data** activity exports the cleaned and processed DataFrame to a target destination.
- Pipeline exploration was safely tested and validated using `.show()` to ensure Driver memory stability.

## 📅 Week 7 - Delta Lake & Incremental Data Processing

### Objective

Implement incremental data processing (SCD Type 1) using Databricks and Delta Lake to manage daily data updates.

### Work Completed

- Set up a **Databricks** workspace to handle ACID-compliant data transactions.
- Created mock datasets (`master` and `incremental`) to simulate daily data ingestion.
- Built a data cleansing step to remove duplicate primary keys and handle missing values.
- Converted standard data formats into **Delta Tables** to allow row-level updates (Upserts).

### Pipeline Workflow

- **Ingest & Clean:** Loaded the raw `customer_master` data, dropped duplicates, and fixed nulls.
- **Save as Delta:** Stored the clean dataset as a native Delta Table.
- **Load Incremental:** Ingested the `customer_incremental` payload containing new daily records and updates.
- **MERGE (Upsert):** Used the Delta API to perform an SCD Type 1 update:
  - Updated existing customers using `.whenMatchedUpdateAll()`.
  - Inserted brand-new customers using `.whenNotMatchedInsertAll()`.
- **Validate:** Queried the final table to mathematically prove there were zero duplicates and all updates were successfully applied.

## 📅 Week 8 - E-Commerce Analytics System (CLI)

### Objective

Design and develop a complete data analytics system locally—from generating raw mock data to building an interactive Command-Line Interface (CLI) for business reporting using Python and Advanced SQL.

### Work Completed

- **Data Generation:** Built a realistic mock dataset with intentional anomalies (nulls, duplicates, bad data) using Python (`Faker`).
- **Data Cleaning Engine:** Sanitized data using Pandas to fix anomalies and enforce referential integrity.
- **Database Ingestion:** Automated the loading of clean data into a local SQLite database.(`ecommerce_analytics.db`).
- **Advanced SQL Analytics:** Extracted key business metrics using CTEs, complex `JOIN`s, and Window Functions `(RANK())`
- **CLI Tool Development:** Developed an interactive, terminal-based Python app using `tabulate` to visualize dynamic reports.

### Pipeline Workflow

- **Monthly Revenue Trends:** Groups and aggregates total sales by category and month using `JOIN`s.
- **Top VIP Customers:** Ranks customers by Lifetime Value (LTV) using advanced Window Functions.
- **Customer Segmentation:** Dynamically categorizes users into 'One-time Buyers' or 'Loyal Customers' based on purchase frequency.
- **Retention Metrics (Cohort Analysis):** Executes complex self-joins and chronological groupings to track customer return rates based on their first purchase month.

---

_This marks the final week of tasks completed during this internship._
