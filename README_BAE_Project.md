# BAE Systems-style Business Analyst Intern Project

## Project title
Aftermarket Services Repair Center Optimization

## Business question
How can we use SQL and Tableau to identify repair-center bottlenecks, improve turnaround time, and better manage airline customer accounts?

## Files included
- `repair_orders.csv` — main fact table with 3,200 synthetic repair orders
- `customers.csv` — airline customer reference table
- `parts.csv` — aircraft component reference table
- `repair_centers.csv` — repair center reference table
- `schema_and_queries.sql` — SQL table definitions and sample analysis queries

## Recommended Tableau dashboards
1. **Repair Center Performance**
   - KPI cards: Total Repairs, Avg Repair Days, SLA Miss Rate, Total Repair Cost
   - Bar chart: Avg Repair Days by Repair Center
   - Scatter plot: Repair Volume vs Avg Repair Days
   - Line chart: Monthly repairs by center

2. **Customer Account Dashboard**
   - Bar chart: Top customers by revenue
   - Heatmap: Avg turnaround time by customer and priority
   - Map or bar chart: Repairs by region
   - Table: customer volume, avg days, SLA miss count

3. **Parts & Opportunity Analysis**
   - Bar chart: Repairs by part type
   - Tree map: Repair cost by capability area
   - Highlight table: Part type vs repair center avg days
   - Filter: priority, warranty, aircraft model

## Interview story (30–45 seconds)
I created a simulated aftermarket services dataset to analyze aircraft component repair operations. Using SQL, I measured repair volume, turnaround time, SLA performance, and customer impact across repair centers and part types. Then I built Tableau dashboards to identify bottlenecks, high-value customer accounts, and parts driving the most operational burden. This project shows how I can turn raw operational data into insights that support business lifecycle decisions, customer account management, and process optimization.

## Suggested insights you can mention
- Some repair centers show longer average turnaround time despite lower volume, suggesting process inefficiency rather than capacity alone.
- High-priority repairs can improve speed but often increase cost, which creates a tradeoff between service level and margin.
- A small number of part types can drive a disproportionate share of repair volume and cost.
- Strategic airline accounts may need tighter SLA monitoring because delays can affect customer relationship quality.

## Notes
This is a synthetic dataset built for interview and portfolio use, so you can explain every field and every transformation confidently.
