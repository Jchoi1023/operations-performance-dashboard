-- BAE Systems-style Aftermarket Services Project
-- Create tables

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    airline_code VARCHAR(5) PRIMARY KEY,
    airline_name VARCHAR(100),
    region VARCHAR(50),
    account_tier VARCHAR(20),
    contract_type VARCHAR(30)
);

DROP TABLE IF EXISTS parts;
CREATE TABLE parts (
    part_id VARCHAR(10) PRIMARY KEY,
    part_type VARCHAR(50),
    aircraft_model VARCHAR(20),
    capability_area VARCHAR(50),
    base_fail_rate DECIMAL(5,2),
    base_repair_cost DECIMAL(12,2)
);

DROP TABLE IF EXISTS repair_centers;
CREATE TABLE repair_centers (
    repair_center_id VARCHAR(10) PRIMARY KEY,
    location VARCHAR(100),
    daily_capacity_index INT,
    efficiency_factor DECIMAL(4,2)
);

DROP TABLE IF EXISTS repair_orders;
CREATE TABLE repair_orders (
    order_id VARCHAR(20) PRIMARY KEY,
    airline_code VARCHAR(5),
    airline_name VARCHAR(100),
    region VARCHAR(50),
    account_tier VARCHAR(20),
    part_id VARCHAR(10),
    part_type VARCHAR(50),
    aircraft_model VARCHAR(20),
    capability_area VARCHAR(50),
    repair_center_id VARCHAR(10),
    repair_center_location VARCHAR(100),
    order_created_date DATE,
    received_date DATE,
    completed_date DATE,
    status VARCHAR(20),
    priority VARCHAR(20),
    warranty_flag VARCHAR(1),
    quoted_repair_days INT,
    actual_repair_days INT,
    repair_cost_usd DECIMAL(12,2),
    sla_met VARCHAR(1)
);

-- Example analysis query 1: repair center performance
SELECT
    repair_center_id,
    repair_center_location,
    COUNT(*) AS total_orders,
    AVG(actual_repair_days) AS avg_repair_days,
    SUM(CASE WHEN sla_met = 'N' THEN 1 ELSE 0 END) AS missed_sla_orders,
    SUM(repair_cost_usd) AS total_repair_cost
FROM repair_orders
WHERE status = 'Completed'
GROUP BY repair_center_id, repair_center_location
ORDER BY avg_repair_days DESC;

-- Example analysis query 2: top customers by revenue and volume
SELECT
    airline_name,
    COUNT(*) AS total_repairs,
    SUM(repair_cost_usd) AS total_revenue,
    AVG(actual_repair_days) AS avg_turnaround_days
FROM repair_orders
WHERE status = 'Completed'
GROUP BY airline_name
ORDER BY total_revenue DESC;

-- Example analysis query 3: parts creating the most operational burden
SELECT
    part_type,
    capability_area,
    COUNT(*) AS repairs,
    AVG(actual_repair_days) AS avg_repair_days,
    SUM(repair_cost_usd) AS total_cost
FROM repair_orders
WHERE status = 'Completed'
GROUP BY part_type, capability_area
ORDER BY repairs DESC, avg_repair_days DESC;
