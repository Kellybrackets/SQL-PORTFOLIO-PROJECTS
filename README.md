# SQL Portfolio Projects

Welcome to my SQL portfolio showcasing expertise in **data analysis, database engineering, and business intelligence solutions**. This collection demonstrates my ability to transform raw data into actionable insights across diverse industries.

## 🏆 Featured Projects

### 🏗️ **Data Engineering**
1. **[Data Warehouse Implementation from Scratch](project-link)**
   - Designed a star schema data warehouse with optimized fact/dimension tables
   - Implemented ETL pipelines handling 1M+ records daily
   - Technologies: SQL Server, SSIS, Index Optimization

### 📺 **Media & Entertainment Analytics**
2. **[Netflix Content Strategy Analysis](project-link)**
   - Analyzed 10,000+ titles to identify genre trends and regional preferences
   - Developed recommendation metrics using advanced window functions
   - Key Insights: 65% of new releases are TV shows, with 40% concentrated in Drama

3. **[Spotify Music Trends Dashboard](project-link)**
   - Processed streaming data for 50,000+ tracks to identify artist popularity patterns
   - Created tempo/energy analysis for playlist optimization
   - Technologies: JSON parsing, datetime functions, materialized views

### 🍽️ **FoodTech & Retail**
4. **[Zomato Restaurant Performance Insights](project-link)**
   - Optimized cuisine rankings across 15 cities using 50K+ reviews
   - Reduced query time by 60% through query plan optimization
   - Features: Geospatial queries, stored procedures

5. **[Walmart Sales Analytics Engine](project-link)**
   - Analyzed 2M+ transactions to identify high-growth product categories
   - Built automated sales forecasting queries with 85% accuracy
   - Techniques: PIVOT operations, seasonal trend analysis

### 🦠 **Healthcare Analytics**
6. **[COVID-19 Data Exploration](COVID19_SQLQUERIES_data_cleaning.sql)**
   - Cleaned and analyzed global pandemic datasets (5GB+)
   - Calculated vaccination/infection rate metrics
   - Key Contribution: Reduced data processing time by 75%

### 🛍️ **Retail Systems**
7. **[LesMeison Retail Database System](LesMeison-database)**
   - Designed OLTP database handling 100+ daily transactions
   - Implemented inventory alert triggers reducing stockouts by 30%
   - Schema: 3NF design with 15+ related tables

## 🛠️ **Technical Toolkit**

| Category        | Skills & Technologies |
|----------------|----------------------|
| **Database**   | SQL Server, MySQL, PostgreSQL |
| **Optimization** | Query tuning, indexing, partitioning |
| **Advanced SQL** | Window functions, recursive CTEs, JSON/XML |
| **ETL**        | SSIS, Airflow, Stored Procedures |

## 📊 **Project Highlights**
```sql
-- Sample Code Snippet (COVID-19 Analysis)
SELECT 
    continent,
    MAX(total_cases) AS peak_infections,
    ROUND(100*MAX(people_vaccinated)/population,2) AS vaccination_rate
FROM covid_data
GROUP BY continent, population
ORDER BY vaccination_rate DESC;
