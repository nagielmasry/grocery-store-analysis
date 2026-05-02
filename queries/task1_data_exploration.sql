-- ============================================================
-- Task 1: Data Exploration
-- Goal: Inspect the raw products table to understand
--       the data and identify quality issues before cleaning
-- ============================================================


-- ============================================================
-- STEP 1: Preview the raw data
-- ============================================================
SELECT *
FROM products
LIMIT 20;


-- ============================================================
-- STEP 2: Count total rows
-- ============================================================
SELECT COUNT(*) AS total_rows
FROM products;


-- ============================================================
-- STEP 3: Check for NULLs and missing values in each column
-- ============================================================
SELECT
    COUNT(*)                                            AS total_rows,
    COUNT(*) - COUNT(product_id)                        AS missing_product_id,
    COUNT(*) - COUNT(product_type)                      AS missing_product_type,
    COUNT(*) - COUNT(brand)                             AS missing_brand,
    COUNT(*) - COUNT(weight)                            AS missing_weight,
    COUNT(*) - COUNT(price)                             AS missing_price,
    COUNT(*) - COUNT(average_units_sold)                AS missing_avg_units_sold,
    COUNT(*) - COUNT(year_added)                        AS missing_year_added,
    COUNT(*) - COUNT(stock_location)                    AS missing_stock_location
FROM products;


-- ============================================================
-- STEP 4: Check all unique values in categorical columns
-- ============================================================

-- Unique product types
SELECT product_type, COUNT(*) AS occurrences
FROM products
GROUP BY product_type
ORDER BY occurrences DESC;

-- Unique brand values (looking for '-' placeholders)
SELECT brand, COUNT(*) AS occurrences
FROM products
GROUP BY brand
ORDER BY occurrences DESC;

-- Unique stock_location values (looking for case variants)
SELECT stock_location, COUNT(*) AS occurrences
FROM products
GROUP BY stock_location
ORDER BY occurrences DESC;


-- ============================================================
-- STEP 5: Inspect the weight column for mixed formats
-- Weight is stored as TEXT — check how many rows contain
-- the word 'grams' vs pure numeric strings
-- ============================================================
SELECT
    COUNT(*) FILTER (WHERE weight LIKE '%grams%') AS has_grams_text,
    COUNT(*) FILTER (WHERE weight NOT LIKE '%grams%'
                       AND weight IS NOT NULL
                       AND TRIM(weight) != '')       AS numeric_only,
    COUNT(*) FILTER (WHERE weight IS NULL
                       OR TRIM(weight) IN ('', '-')) AS missing_or_placeholder
FROM products;


-- ============================================================
-- STEP 6: Check price and weight ranges for outliers
-- ============================================================
SELECT
    MIN(price)                  AS min_price,
    MAX(price)                  AS max_price,
    ROUND(AVG(price)::NUMERIC, 2) AS avg_price,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM products
WHERE price IS NOT NULL;
