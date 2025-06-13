--Query 1: Most Common Medical Conditions
--Objective: Identify the most frequent medical conditions to prioritize staffing and resources.
SELECT 
    `Medical Condition`, 
    COUNT(*) AS Patient_Count,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare_dataset), 2) AS Percentage
FROM healthcare_dataset
GROUP BY `Medical Condition`
ORDER BY Patient_Count DESC;

--Query 2: Average Billing Amount by Condition
--Objective: Determine which conditions are the most costly to treat.
SELECT 
    `Medical Condition`, 
    ROUND(AVG(`Billing Amount`), 2) AS Avg_Billing,
    MAX(`Billing Amount`) AS Max_Billing,
    MIN(`Billing Amount`) AS Min_Billing
FROM healthcare_dataset
GROUP BY `Medical Condition`
ORDER BY Avg_Billing DESC;

--Query 3: Admission Type Analysis
--Objective: Understand the distribution of admission types (Emergency, Urgent, Elective).
SELECT 
    `Admission Type`, 
    COUNT(*) AS Cases,
    ROUND(AVG(`Billing Amount`), 2) AS Avg_Cost,
    AVG(DATEDIFF(`Discharge Date`, `Date of Admission`)) AS Avg_Stay_Days
FROM healthcare_dataset
GROUP BY `Admission Type`;

--Query 4: Insurance Provider Analysis
--Objective: Compare billing amounts across insurance providers.
SELECT 
    `Insurance Provider`, 
    COUNT(*) AS Patient_Count,
    ROUND(AVG(`Billing Amount`), 2) AS Avg_Billing,
    SUM(`Billing Amount`) AS Total_Revenue
FROM healthcare_dataset
GROUP BY `Insurance Provider`
ORDER BY Total_Revenue DESC;

--Query 5: Doctor Workload Analysis
--Objective: Identify doctors handling the most patients.
SELECT 
    Doctor, 
    COUNT(*) AS Patient_Count,
    GROUP_CONCAT(DISTINCT `Medical Condition`) AS Common_Conditions
FROM healthcare_dataset
GROUP BY Doctor
ORDER BY Patient_Count DESC
LIMIT 10;

--Query 6: Room Utilization by Department
--Objective: Analyze room usage to optimize capacity.
SELECT 
    `Room Number`, 
    COUNT(*) AS Usage_Count,
    AVG(DATEDIFF(`Discharge Date`, `Date of Admission`)) AS Avg_Stay_Days
FROM healthcare_dataset
GROUP BY `Room Number`
ORDER BY Usage_Count DESC
LIMIT 10;

--Query 7: Test Results & Medication Effectiveness
--Objective: Check if certain medications correlate with normal test results.
SELECT 
    Medication, 
    `Test Results`,
    COUNT(*) AS Cases,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Medication), 2) AS Result_Percentage
FROM healthcare_dataset
GROUP BY Medication, `Test Results`
ORDER BY Medication, Cases DESC;
