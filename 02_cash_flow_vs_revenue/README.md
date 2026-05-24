# Cash Flow vs Revenue Analysis

## Overview

This project analyzes the relationship between revenue and cash flow over time. In many businesses, sales and payments do not occur at the same time, which creates a gap between when revenue is recorded and when cash is actually received.

The goal of this analysis is to compare these two metrics and understand how they evolve across months.

---

## Business Question

How does cash flow compare to revenue over time?

---

## KPI Definitions

### Revenue

Revenue represents the total value of products sold during a given period. It is calculated from the `order_items` table using quantity, unit price, and discounts. Revenue is recognized when the order is placed, regardless of payment timing.

### Cash Flow

Cash flow represents the actual money received by the business during a given period. It is calculated from the `payments` table and reflects payment transactions based on payment date.

---

## Data Model

This analysis uses the following tables:

- `order_items`: used to calculate revenue at the product line level  
- `orders`: connects order items to customers and provides order date  
- `payments`: used to calculate cash flow based on payment transactions  
- `customers`: provides customer attributes (not directly used in aggregation)  
- `dim_date`: used to group both revenue and cash flow by month  

Revenue and cash flow are aligned using the date dimension to ensure consistent time-based comparison.

---

## Grain

### Base Grain

- Revenue: order item level  
- Cash flow: payment transaction level  

### Reporting Grain

One row per month

---

## Logic

Revenue is calculated from `order_items` by applying quantity, unit price, and discount. It is joined with `orders` to access the order date and grouped by month.

Cash flow is calculated from `payments` using the payment amount and grouped by payment month.

Both metrics are aggregated separately and then aligned by month using the `dim_date` table.

---

## SQL

All SQL logic for this analysis is available in `analysis.sql`.

---

## Key Insights

- Revenue and cash flow do not always move together over time. Revenue is recorded at the time of sale, while cash flow depends on when payments are received.  
- In some months, revenue is higher than cash flow, which may indicate delayed payments or outstanding invoices. In other months, cash flow may be higher due to payments from previous periods.  
- Understanding the gap between these two metrics helps identify payment delays and provides a clearer view of business liquidity.

---

## Business Value

This analysis helps:

- Compare sales performance with actual cash inflow  
- Identify timing gaps between revenue and payments  
- Improve cash flow forecasting  
- Support financial decision-making  
