-- ============================================================
-- Task 4: Meat & Dairy Products with High Sales Volume
-- Goal: Return products that are either Meat or Dairy type
--       AND have average units sold greater than 10
-- ============================================================

SELECT
    product_id,
    price,
    average_units_sold

FROM products

-- IN ('Meat', 'Dairy') is cleaner than writing OR conditions
-- > 10 means strictly greater than — does not include 10
WHERE product_type IN ('Meat', 'Dairy')
  AND average_units_sold > 10

-- Worst performers appear first
ORDER BY average_units_sold DESC;
