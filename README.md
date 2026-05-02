[README.md](https://github.com/user-attachments/files/27304502/README.md)
# 🛒 Grocery Store Sales Analysis (SQL)

## 🚀 Overview

This project is a **SQL-based data analysis** of a grocery store chain's product catalog.  
It demonstrates end-to-end data analyst skills — from **data cleaning and validation** through to **business-driven querying** — using a real-world style dataset.

The dataset belongs to **FoodYum**, a US-based grocery chain that sells produce, meat, dairy, baked goods, and snacks. As food costs rise, the business needs to ensure it stocks products across all categories and price ranges to serve a broad customer base.

---

## 🎯 Project Objectives

- Identify and handle data quality issues in a raw product table
- Clean and standardise inconsistent, missing, and placeholder values
- Answer business questions about price ranges and product performance
- Demonstrate production-quality SQL with clear structure and comments

---

## 🧠 Business Questions Answered

✔ What does the raw data look like, and what quality issues exist?  
✔ How can we clean and standardise all columns to match the required specification?  
✔ What is the **minimum and maximum price** for each product type?  
✔ Which **Meat and Dairy products** have average monthly sales greater than 10 units?

---

## 🏗️ Tech Stack

- **SQL (PostgreSQL)** → Data cleaning, transformation, and analysis
- **DataLab (DataCamp)** → Query execution environment

---

## 🔍 SQL Skills Demonstrated

- 🧹 **Data Cleaning** → Handling NULLs, placeholders (`-`), mixed formats, case variants
- 🔄 **Type Casting** → Converting text columns to numeric with validation
- 📊 **Aggregations** → `MIN`, `MAX`, `AVG`, `GROUP BY`
- 🔢 **Median Calculation** → `PERCENTILE_CONT` for robust imputation
- 🧮 **Conditional Logic** → `CASE WHEN`, `COALESCE`, `NULLIF`
- ✂️ **String Manipulation** → `TRIM`, `UPPER`, `REPLACE`, `REGEXP`
- 🔍 **Filtering** → `WHERE`, `IN`, comparison operators

---

## 📁 Project Structure

```
grocery-store-analysis/
│
├── README.md
│
├── queries/
│   ├── task1_data_exploration.sql   → Inspect raw data and identify issues
│   ├── task2_data_cleaning.sql      → Full cleaning query (SELECT only, no UPDATE)
│   ├── task3_price_range.sql        → Min/max price per product type
│   └── task4_meat_dairy_filter.sql  → High-selling Meat & Dairy products
│
└── data/
    └── schema.md                    → Table schema and column descriptions
```

---

## 📋 Dataset — `products` Table

| Column | Type | Description |
|---|---|---|
| `product_id` | integer | Unique product identifier. No nulls. |
| `product_type` | text | Category: Produce, Meat, Dairy, Bakery, Snacks |
| `brand` | text | Brand name. One of 7 values. May have `'-'` placeholders. |
| `weight` | text | Weight in grams. Mixed formats: `'462.45 grams'` or `'462.45'` |
| `price` | real | Price in USD. May have missing values. |
| `average_units_sold` | integer | Avg monthly units sold. May have missing values. |
| `year_added` | integer | Year product was added to FoodYum stock. |
| `stock_location` | text | Warehouse location: A, B, C, or D. Case variants possible. |

---

## 🧹 Data Cleaning Summary (Task 2)

| Column | Issue Found | Fix Applied |
|---|---|---|
| `product_type` | NULL values | Replaced with `'Unknown'` |
| `brand` | NULLs and `'-'` placeholders | Replaced both with `'Unknown'` |
| `weight` | Mixed formats (`'462.45 grams'` vs `'462.45'`), stored as TEXT | Stripped `' grams'`, cast to NUMERIC, rounded to 2dp; NULLs → median |
| `price` | NULL values | Replaced with overall median price |
| `average_units_sold` | NULL values | Replaced with `0` |
| `year_added` | Some missing | Replaced with `2022` |
| `stock_location` | Case variants + NULLs | `UPPER(TRIM())` applied; NULLs → `'Unknown'` |

---

## 📊 Key Findings

### Price Range by Product Type (Task 3)
Each product category covers a wide price range, confirming FoodYum stocks items across multiple price points to serve different customer budgets.

### High-Selling Meat & Dairy Products (Task 4)
Filtering for Meat and Dairy products with average monthly sales above 10 units helps the operations team focus on their highest-demand perishable items.

---

## ▶️ How to Use

1. Clone or download this repository
2. Review `data/schema.md` for the full table description
3. Run queries in order from `task1` through `task4` in any PostgreSQL-compatible environment
4. Each query file is fully self-contained with comments explaining every step

---

## 👤 Nagi El-Masry 

Data Analyst | SQL · Python · Data Cleaning · Business Analytics
