[schema.md](https://github.com/user-attachments/files/27304520/schema.md)
# Dataset Schema — `products` Table

## Context

FoodYum is a US-based grocery store chain selling produce, meat, dairy, baked goods,
snacks, and other household food staples. As food costs rise, FoodYum wants to ensure
it keeps stocking products in all categories that cover a range of prices to serve a
broad customer base.

---

## Table: `products`

| Column | Data Type | Nulls / Placeholders | Description |
|---|---|---|---|
| `product_id` | integer | No nulls | Nominal. Unique product identifier. Missing not possible due to DB structure. |
| `product_type` | text | May have missing | Nominal. One of 5 values: Produce, Meat, Dairy, Bakery, Snacks. |
| `brand` | text | May have missing; `'-'` present | Nominal. One of 7 possible brand values. |
| `weight` | text | Mixed formats; `''`, `'-'` possible | Continuous. Weight in grams. Some values include the word 'grams'. |
| `price` | real | May have missing | Continuous. Price in USD, rounded to 2 decimal places. |
| `average_units_sold` | integer | May have missing | Discrete. Average number of units sold per month. |
| `year_added` | integer | Some missing | Nominal. Year product was first added to FoodYum stock. |
| `stock_location` | text | May have missing; case variants | Nominal. Warehouse location: A, B, C, or D. |

---

## Cleaning Specification

| Column | Cleaning Rule |
|---|---|
| `product_type` | Missing → `'Unknown'` |
| `brand` | NULL or `'-'` → `'Unknown'` |
| `weight` | Strip `' grams'` text, cast to NUMERIC, round to 2dp. Missing → overall median weight |
| `price` | Missing → overall median price, rounded to 2dp |
| `average_units_sold` | Missing → `0` |
| `year_added` | Missing → `2022` |
| `stock_location` | Apply `UPPER(TRIM())`. Missing → `'Unknown'` |
