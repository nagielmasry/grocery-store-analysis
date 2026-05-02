-- ============================================================
-- Task 2: Data Cleaning Query for the products Table
-- Goal: Return a clean version of the data WITHOUT modifying
--       the original table.
-- ============================================================


-- ============================================================
-- STEP 1: Strip the word "grams" from weight values and cast
--         to numeric so we can calculate the median correctly
-- ============================================================
WITH weight_cleaned AS (
    SELECT
        ROUND(
            CAST(REPLACE(TRIM(weight), ' grams', '') AS NUMERIC),
        2) AS weight_val
    FROM products
    WHERE weight IS NOT NULL
      AND TRIM(weight) NOT IN ('', '-')
),

-- ============================================================
-- STEP 2: Calculate the overall median weight
--         (used to fill missing/invalid weight values)
-- ============================================================
weight_median AS (
    SELECT
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight_val) AS median_weight
    FROM weight_cleaned
),

-- ============================================================
-- STEP 3: Calculate the overall median price
--         (used to fill missing price values)
-- ============================================================
price_median AS (
    SELECT
        ROUND(
            CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS NUMERIC),
        2) AS median_price
    FROM products
    WHERE price IS NOT NULL
)


-- ============================================================
-- STEP 4: Return the fully cleaned dataset
-- ============================================================
SELECT

    -- No cleaning needed; primary key, never null
    product_id,

    -- Replace NULL product types with 'Unknown'
    COALESCE(product_type, 'Unknown') AS product_type,

    -- Replace both NULL and placeholder '-' with 'Unknown'
    CASE
        WHEN brand IS NULL OR TRIM(brand) = '-' THEN 'Unknown'
        ELSE brand
    END AS brand,

    -- Strip ' grams' text, cast to numeric, round to 2 decimal places
    -- Replace NULL or invalid entries with the overall median weight
    CASE
        WHEN weight IS NULL OR TRIM(weight) IN ('', '-')
            THEN (SELECT median_weight FROM weight_median)
        ELSE ROUND(CAST(REPLACE(TRIM(weight), ' grams', '') AS NUMERIC), 2)
    END AS weight,

    -- Replace NULL prices with the overall median price
    COALESCE(
        ROUND(CAST(price AS NUMERIC), 2),
        (SELECT median_price FROM price_median)
    ) AS price,

    -- Replace NULL sales figures with 0
    COALESCE(average_units_sold, 0) AS average_units_sold,

    -- Replace missing years with 2022 (last year)
    COALESCE(year_added, 2022) AS year_added,

    -- Standardize case variants (e.g. 'a' -> 'A') and replace NULLs with 'Unknown'
    CASE
        WHEN stock_location IS NULL THEN 'Unknown'
        ELSE UPPER(TRIM(stock_location))
    END AS stock_location

FROM products;
