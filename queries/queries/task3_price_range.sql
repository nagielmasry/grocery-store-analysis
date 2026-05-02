-- ============================================================
-- Task 3: Price Range by Product Type
-- Goal: Return the minimum and maximum price for each
--       product type to understand price range variation
-- ============================================================

SELECT
    product_type,
    MIN(price) AS min_price,
    MAX(price) AS max_price

FROM products

-- GROUP BY groups all rows belonging to the same category
-- so MIN() and MAX() are calculated per product type
GROUP BY product_type

ORDER BY product_type;
