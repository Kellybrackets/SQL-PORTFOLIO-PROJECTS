# Eskom Power Generation Data Analysis (April 2018)

## 📌 Overview
This repository contains SQL queries and business insights derived from Eskom's hourly power generation and demand data for April 1-11, 2018. The analysis focuses on:
- Demand patterns
- Renewable energy contribution
- Load shedding events
- Peaking plant costs
- International power trading

### 📊 Key Findings
**Peak demand: 6-8 PM daily (~30,000 MW)**

**Renewables contribute: 5-10% of supply**

**Load shedding events: April 3 & 6 (peaking at 400 MW)**

**Peaking plant costs: ~R50 million/day during high demand**

## 🛠 Setup Instructions

### Option 1: SQL Server
1. **Upload CSV to SQL Server**:
   ```sql
   -- Create table (adjust datatypes as needed)
   CREATE TABLE Eskom_Power_Data (
       [Date Time Hour Beginning] DATETIME,
       [Residual Demand] FLOAT,
       [Wind] FLOAT,
       [PV] FLOAT,
       -- Add all other columns from CSV
   );
   
   -- Bulk import
   BULK INSERT Eskom_Power_Data
   FROM 'C:\path\to\ESK2033.csv'
   WITH (
       FORMAT = 'CSV',
       FIRSTROW = 2,
       FIELDTERMINATOR = ',',
       ROWTERMINATOR = '\n'
   );
    ```

### 🔍 Key Queries
**All queries are available in the /queries folder. Highlights:**

Peak Demand Identification

```sql
-- Finds top 10 highest demand hours
SELECT TOP 10
    [Date Time Hour Beginning],
    [Residual Demand] 
FROM Eskom_Power_Data
ORDER BY [Residual Demand] DESC;
Renewable Energy Contribution
```

```sql
-- Calculates daily renewable percentage
SELECT 
    CAST([Date Time Hour Beginning] AS DATE) AS Date,
    SUM(Wind + PV + CSP) / SUM([Residual Demand]) * 100 AS Renewable_Pct
FROM Eskom_Power_Data
GROUP BY CAST([Date Time Hour Beginning] AS DATE);
```
