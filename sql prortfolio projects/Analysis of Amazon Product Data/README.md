# Amazon Product Data Analysis (Electronics & Cables)

## 📌 Overview
This project analyzes an Amazon product dataset (51 entries) focusing on **electronics, cables, and smart TVs** to derive business insights. The analysis includes:
- **Top-performing products**
- **Pricing & discount strategies**
- **Customer sentiment analysis**
- **Category-wise performance**
- **Actionable recommendations**

## 📊 Key Insights

### 1. **Top-Rated Products**
- Duracell USB-C to Lightning Cable (`4.5⭐`) and AmazonBasics HDMI Cable (`4.4⭐`) are highest-rated.
- **Recommendation:** Promote these in marketing campaigns.

### 2. **Discount Impact**
- Deep discounts (e.g., 90% off) don’t always drive sales volume (e.g., Sounce Fast Charging Cable: 7,928 reviews).
- **Opportunity:** Test moderate discounts (50-60%).

### 3. **Most Reviewed Products**
- Cables dominate engagement (`500K+ reviews` vs. Smart TVs at `80K`).
- **Action:** Stock more high-demand cables (e.g., braided fast-charging).

### 4. **Customer Sentiment**
- Positive: boAt Deuce USB 300 ("Charges good").
- Negative: pTron Solero TB301 ("Doesn’t support 33W charging").
- **Fix:** Improve product durability/features.

---

## 🛠️ Queries & Analysis
| Query | Purpose | Insight |
|-------|---------|---------|
| `Top-Rated Products` | Identify best-rated items | Duracell, AmazonBasics lead |
| `Discount Impact` | Analyze discount vs. sales | High discounts ≠ high volume |
| `Category Performance` | Compare cables vs. TVs | Cables have 6x more reviews |
| `Sentiment Analysis` | Gauge customer satisfaction | boAt has most positive reviews |

---

## 🚀 Business Recommendations
1. **Pricing Strategy:**  
   - Test moderate discounts (50-60%) instead of deep cuts.
2. **Inventory Focus:**  
   - Prioritize fast-charging cables and high-margin Smart TVs.
3. **Marketing:**  
   - Bundle cables with devices (e.g., smartphones).
4. **Product Improvements:**  
   - Address charging speed/durability issues.

---

## 📂 Files
- `analysis_report.md`: Full business case + queries.
- `queries.sql`: SQL code for data extraction.
- `dataset.csv`: Raw Amazon product data.

---

## 🛠️ Setup & Execution Instructions

### **Option 1: Using SQL Server**
#### **Step 1: Import CSV into SQL Server**
1. **Open SQL Server Management Studio (SSMS)** and connect to your database.
2. **Right-click your database** → `Tasks` → `Import Data`.
3. In the **SQL Server Import/Export Wizard**:
   - Data Source: Select `Flat File Source` and browse your `amazon_products.csv`.
   - Destination: Choose your SQL Server database.
   - Map columns to the correct data types (e.g., `rating` as `FLOAT`, `rating_count` as `INT`).
4. Click **Finish** to import.

#### **Step 2: Run Queries**
```sql
-- Example: Top-rated products query
SELECT product_name, rating, rating_count
FROM amazon_products
WHERE rating >= 4.5
ORDER BY rating DESC;
