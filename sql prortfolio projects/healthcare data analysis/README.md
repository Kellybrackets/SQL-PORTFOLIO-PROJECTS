# Healthcare Dataset Analysis - Business Analyst Report  
**Author:** Keletso Ntseno  

---

## **📌 Overview**  
As a **Business Analyst**, I analyzed a **healthcare dataset** containing **1,000 patient records** to extract actionable insights for hospital management, insurers, and medical staff. This README explains:  
✔ **Key business questions** we need to answer  
✔ **SQL queries** to derive insights  
✔ **Findings & recommendations** for decision-makers  
✔ **How to run this analysis** in your own environment  

---

## **🔍 Business Objectives**  
### **1. Optimize Hospital Operations**  
- Which medical conditions are most common?  
- How are rooms and doctors being utilized?  
- What’s the breakdown of emergency vs. elective cases?  

### **2. Financial & Billing Insights**  
- Which conditions cost the most to treat?  
- Which insurance providers contribute the most revenue?  
- Are there billing anomalies (e.g., unusually high/low charges)?  

### **3. Patient Care Improvements**  
- Which medications have the best/worst outcomes?  
- How long do patients typically stay?  
- Are test results mostly normal or abnormal?  

---

## **💻 How to Run This Analysis**  
### **Prerequisites**  
- SQL-compatible database (MySQL, PostgreSQL, SQLite, etc.)  
- The `healthcare_dataset.csv` file loaded into a table  

### **Step-by-Step Execution**  
1. **Import the dataset** into your SQL database:  
   ```sql
   CREATE TABLE healthcare_data (
       Name VARCHAR(100),
       Age INT,
       Gender VARCHAR(10),
       Blood_Type VARCHAR(5),
       Medical_Condition VARCHAR(50),
       Date_of_Admission DATE,
       Doctor VARCHAR(100),
       Hospital VARCHAR(100),
       Insurance_Provider VARCHAR(50),
       Billing_Amount DECIMAL(12,2),
       Room_Number INT,
       Admission_Type VARCHAR(20),
       Discharge_Date DATE,
       Medication VARCHAR(50),
       Test_Results VARCHAR(20)
   );
   
   -- Load data (syntax varies by database)
   LOAD DATA INFILE 'healthcare_dataset.csv' INTO TABLE healthcare_data
   FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
   IGNORE 1 ROWS;
