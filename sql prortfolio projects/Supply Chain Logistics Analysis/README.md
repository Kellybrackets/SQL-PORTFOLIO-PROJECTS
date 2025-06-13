# **Supply Chain Logistics Analytics - Business Analyst's Guide**  
*By Keletso Ntseno, Supply Chain Business Analyst*  

## **📌 Overview**  
This repository contains a **comprehensive supply chain logistics analysis** derived from order shipment data. As a Business Analyst, my goal was to extract actionable insights to **optimize shipping efficiency, reduce costs, and improve customer satisfaction**. Below, I explain:  
- How to **run the queries** (even with basic SQL skills).  
- **Key findings** and their business impact.  
- **Next steps** for stakeholders.  

---

## **🔍 How to Use This Analysis**  
### **1. Data Source**  
- **Dataset**: `Supply chain logistics problem.xlsx` (Sheet: `OrderList`)  
- **Tools Needed**:  
  - SQL (I used **PostgreSQL**, but any SQL-compatible tool works).  
  - Excel/Power BI for visualization (optional).  

### **2. Running the Queries**  
All queries are designed to be **plug-and-play**—just execute them in your SQL environment.  

#### **Example Setup (for non-technical users):**  
1. **Upload data** to a database (e.g., Google BigQuery, MySQL, or even Excel + Power Query).  
2. **Run queries** like this one to get started:  
   ```sql
   -- Total Orders, Weight, and Units (Basic)
   SELECT 
       COUNT(*) AS Total_Orders,
       SUM(Weight) AS Total_Weight_Shipped,
       SUM([Unit quantity]) AS Total_Units_Shipped
   FROM OrderList;
   ```
### 📊 Key Insights & Business Impact
***1. Customer Prioritization***
Finding: V55555_53 accounts for ~70% of orders.

Action:

Negotiate bulk discounts with carriers for this customer.

Assign a dedicated logistics coordinator to streamline their shipments.

***2. Carrier Performance***
Finding: V44_3 has a 12% late shipment rate.

Action:

Meet with the carrier to identify bottlenecks (e.g., port delays).

Benchmark against alternative carriers (e.g., FedEx, DHL).

***3. Cost Optimization***
Finding: Top 5% of shipments by weight drive 30% of freight costs.

Action:

Implement weight-tiered pricing with carriers.

Explore pallet consolidation for small-but-heavy orders.

***4. Route Efficiency***
Finding: PORT09 → PORT09 is the most frequent route (likely internal transfers).

Action:

Audit internal transfers for redundancies.

Consider cross-docking to reduce handling time.
