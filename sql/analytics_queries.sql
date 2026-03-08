-- =========================================
-- Operations Analytics Project
-- Tableau-ready analytical views
-- PostgreSQL
-- =========================================

-- Optional: check base table
SELECT COUNT(*) AS repair_orders_count
FROM repair_orders;

-- =========================================
-- Drop existing views if they already exist
-- =========================================
DROP VIEW IF EXISTS repair_center_performance;
DROP VIEW IF EXISTS customer_repair_summary;
DROP VIEW IF EXISTS parts_analysis;
DROP VIEW IF EXISTS priority_performance;
DROP VIEW IF EXISTS monthly_repair_trend;

-- =========================================
-- 1. Repair Center Performance
-- =========================================
CREATE VIEW repair_center_performance AS
SELECT 
    repair_center_id,
    repair_center_location,
    COUNT(*) AS total_repairs,
    ROUND(AVG(actual_repair_days), 2) AS avg_repair_days,
    ROUND(AVG(repair_cost_usd), 2) AS avg_repair_cost,
    ROUND(
        100.0 * SUM(CASE WHEN sla_met = 'FALSE' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS sla_miss_rate_pct
FROM repair_orders
GROUP BY repair_center_id, repair_center_location;

-- =========================================
-- 2. Customer Repair Summary
-- =========================================
CREATE VIEW customer_repair_summary AS
SELECT 
    airline_name,
    region,
    COUNT(*) AS total_repairs,
    ROUND(SUM(repair_cost_usd), 2) AS total_repair_cost,
    ROUND(AVG(actual_repair_days), 2) AS avg_repair_days
FROM repair_orders
GROUP BY airline_name, region;

-- =========================================
-- 3. Parts Analysis
-- =========================================
CREATE VIEW parts_analysis AS
SELECT 
    part_type,
    aircraft_model,
    COUNT(*) AS repair_volume,
    ROUND(AVG(actual_repair_days), 2) AS avg_repair_days,
    ROUND(AVG(repair_cost_usd), 2) AS avg_repair_cost
FROM repair_orders
GROUP BY part_type, aircraft_model;

-- =========================================
-- 4. Priority Performance
-- =========================================
CREATE VIEW priority_performance AS
SELECT 
    priority,
    COUNT(*) AS total_orders,
    ROUND(AVG(actual_repair_days), 2) AS avg_repair_days,
    ROUND(
        100.0 * SUM(CASE WHEN sla_met = 'FALSE' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS sla_miss_rate_pct
FROM repair_orders
GROUP BY priority;

-- =========================================
-- 5. Monthly Repair Trend
-- =========================================
CREATE VIEW monthly_repair_trend AS
SELECT 
    DATE_TRUNC('month', received_date)::date AS repair_month,
    COUNT(*) AS repair_volume,
    ROUND(AVG(actual_repair_days), 2) AS avg_repair_days,
    ROUND(AVG(repair_cost_usd), 2) AS avg_repair_cost,
    ROUND(
        100.0 * SUM(CASE WHEN sla_met = 'FALSE' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS sla_miss_rate_pct
FROM repair_orders
GROUP BY DATE_TRUNC('month', received_date)
ORDER BY repair_month;

-- =========================================
-- Validation queries
-- =========================================
SELECT * FROM repair_center_performance;
SELECT * FROM customer_repair_summary;
SELECT * FROM parts_analysis;
SELECT * FROM priority_performance;
SELECT * FROM monthly_repair_trend;

