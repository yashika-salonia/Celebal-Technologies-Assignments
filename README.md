# Data Engineering Tasks & Progress

This repository contains my weekly learning tasks, practice files, and mini implementations completed during the Data Engineering Internship at Celebal Technologies.  
It highlights hands-on work in data cleaning, preprocessing, and analysis using Python.

## 🛠️ Tech Stack

- **Languages:** Python, SQL
- **Libraries:** Pandas, NumPy
- **Tools/Environments:** Jupyter Notebook, VS Code, MySQL Workbench
- **Databases:** MySQL

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

* **Data Modeling:** Normalized a flat dataset into structured Dimension (`customers`, `products`) and Fact (`orders`) tables.
* **Subqueries:** Used derived tables (uncorrelated subqueries) via `JOIN` to drastically optimize query execution times on large datasets.
* **CTEs:** Built reusable, modular queries to calculate aggregate baselines, such as total customer sales.
* **Window Functions:** Applied `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()` for dynamic leaderboards and chronological order sequencing.
* **Performance Optimization:** Replaced $O(N^2)$ correlated subqueries with optimized derived tables (Uncorrelated Subqueries via `JOIN`) to drastically reduce execution time and prevent database timeouts on large datasets.

---
More weekly tasks and implementations will be added as the internship progresses.
