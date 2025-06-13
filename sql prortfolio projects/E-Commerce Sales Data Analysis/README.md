# E-Commerce Sales Data Analysis 📊

This project analyzes an e-commerce dataset (`E-commerce_sales_data_2024.csv`) to derive business insights on customer behavior, conversion funnels, and sales trends. The goal is to optimize marketing, inventory, and user engagement strategies.

---

## **📌 Table of Contents**  
1. [Business Case](#-business-case)  
2. [Key SQL Queries](#-key-sql-queries)  
3. [Setup Instructions](#-setup-instructions)  
   - [SQL Server](#sql-server)  
   - [PostgreSQL](#postgresql)  
4. [How to Run](#-how-to-run)  
5. [Insights & Recommendations](#-insights--recommendations)  
6. [Next Steps](#-next-steps)  

---

## **🎯 Business Case**  
**Objective:**  
Analyze customer interactions (views, likes, purchases) to:  
- Improve **conversion rates** (view → like → purchase).  
- Identify **best-selling products** and inventory needs.  
- Detect **seasonal trends** for targeted marketing.  
- Fix **data quality issues** (missing values).  

**Key Questions:**  
✔ How do users move through the sales funnel?  
✔ Which products have the highest purchase rates?  
✔ When are peak engagement times?  

---

## **🔍 Key SQL Queries**  
### **1. Interaction Distribution**  
```sql
SELECT 
    "Interaction type",
    COUNT(*) AS interaction_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM e_commerce_data), 1) AS percentage
FROM e_commerce_data
GROUP BY "Interaction type";
```

⚙️ Setup Instructions
SQL Server
Create Table:

```sql
CREATE TABLE e_commerce_data (
    "user id" INT,
    "product id" VARCHAR(50),
    "Interaction type" VARCHAR(20),
    "Time stamp" VARCHAR(20)
);
```

Import CSV:

Use SQL Server Import Wizard (Right-click DB → Tasks → Import Data).

Or run:

``` sql
BULK INSERT e_commerce_data
FROM 'C:\path\to\E-commerce_sales_data_2024.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2);
PostgreSQL
Create Table:
```

```sql
CREATE TABLE e_commerce_data (
    user_id INT,
    product_id VARCHAR(50),
    interaction_type VARCHAR(20),
    time_stamp VARCHAR(20)
);
```

Import CSV:

``` sql
COPY e_commerce_data FROM '/path/to/E-commerce_sales_data_2024.csv' DELIMITER ',' CSV HEADER;
```

## 🚀 How to Run
Download the dataset and place it in your project folder.

Execute queries in your preferred SQL environment:

SQL Server: Use SSMS or Azure Data Studio.

PostgreSQL: Use psql or pgAdmin.

For analysis:

Run analysis_queries.sql (included in repo).

Visualize results in Power BI/Tableau (optional).


