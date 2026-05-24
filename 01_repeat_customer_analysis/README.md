# Repeat Customer Revenue Analysis

## Project overview

This analysis examines how revenue from repeat customers is distributed across products. The goal is to understand whether repeat customer spending is concentrated in a small number of products or spread across the catalog.

---

## Data

The analysis uses order-level transaction data combined with product and customer information.

- **Orders**: transactional purchase data
- **Products**: product reference information
- **Customer segmentation**: derived from purchase frequency

---

## Approach

### 1. Customer segmentation
Customers are classified based on purchase frequency:
- repeat customers = 2 or more orders
- one-time customers = 1 order

---

### 2. Data preparation
Order data is enriched with product information and customer segment classification to enable product-level analysis of repeat customers.

---

### 3. Analysis scope
The analysis focuses exclusively on repeat customer transactions to isolate their contribution to revenue.

---

### 4. Revenue calculation
Revenue is calculated at the product level based on repeat customer purchases.

---

### 5. Ranking
Products are ranked by total repeat customer revenue and their contribution to overall repeat revenue is calculated.

---

## SQL

All SQL logic is available in `analysis.sql`.

---

## Key findings

- Repeat customer revenue is concentrated in a limited number of products  
- Spending is not evenly distributed across the product catalog  
- A small set of products drives a disproportionate share of repeat customer revenue  

---

## Next steps

- Analyze repeat revenue trends over time
- Build cohort-based repeat customer analysis
- Identify product patterns linked to customer retention
