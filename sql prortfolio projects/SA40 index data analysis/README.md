# 📊 SA40 Index Analysis Toolkit  
*Business Analyst's Playbook for Market Insights*  

**Hi there!** I'm Keletso, a business analyst specializing in financial markets. This toolkit helps you extract powerful insights from South Africa's SA40 index data (2001-2012). Let me walk you through how to turn raw numbers into actionable intelligence.

---

## 🛠️ Tech Stack  
Here's what powers this analysis:  

```
    A[SQL] --> B[Window Functions]
    A --> C[CTEs]
    A --> D[Aggregations]
```

🔍 SQL Principles in Action
1. Window Functions (My Secret Weapon)
```sql
SELECT 
    Date,
    SA40,
    AVG(SA40) OVER (ORDER BY Date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS 30_day_ma
FROM SA40_index
Why it matters: Creates rolling calculations without collapsing rows - perfect for moving averages!
```

2. Common Table Expressions (CTEs)
```sql
WITH DailyReturns AS (
    SELECT Date, (SA40 - LAG(SA40) OVER (ORDER BY Date))/LAG(SA40) OVER (ORDER BY Date) AS return
    FROM SA40_index
)
SELECT STDDEV(return) FROM DailyReturns
Pro tip: Break complex queries into readable chunks like building blocks.
```

3. Conditional Aggregation
```sql
SELECT 
    EXTRACT(YEAR FROM Date) AS year,
    SUM(CASE WHEN SA40 > LAG(SA40) OVER (ORDER BY Date) THEN 1 ELSE 0 END) AS up_days
FROM SA40_index
GROUP BY year
Business use: Counts bullish vs bearish days - great for sentiment analysis.
```
