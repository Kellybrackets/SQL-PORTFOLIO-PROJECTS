--Query 1: Daily Peak Demand Analysis
SELECT 
    DATE(`Date Time Hour Beginning`) AS Date,
    HOUR(`Date Time Hour Beginning`) AS Hour,
    MAX(`Residual Demand`) AS Peak_Demand_MW
FROM Eskom_Power_Data
GROUP BY Date, Hour
ORDER BY Peak_Demand_MW DESC
LIMIT 10;

--Query 2: Renewable Energy Contribution
SELECT 
    DATE(`Date Time Hour Beginning`) AS Date,
    SUM(`Wind` + `PV` + `CSP`) AS Total_RE_Generation_MW,
    (SUM(`Wind` + `PV` + `CSP`) / SUM(`Residual Demand`)) * 100 AS RE_Percentage
FROM Eskom_Power_Data
GROUP BY Date
ORDER BY RE_Percentage DESC;

--Query 3: Emergency Load Shedding (MLR) Events
SELECT 
    DATE(`Date Time Hour Beginning`) AS Date,
    HOUR(`Date Time Hour Beginning`) AS Hour,
    `Manual Load_Reduction(MLR)` AS Load_Shedding_MW
FROM Eskom_Power_Data
WHERE `Manual Load_Reduction(MLR)` > 0
ORDER BY Load_Shedding_MW DESC;

--Query 4: Cost Analysis of Peaking Plants (OCGT & Gas)
SELECT 
    DATE(`Date Time Hour Beginning`) AS Date,
    SUM(`Eskom OCGT Generation` + `Eskom Gas Generation`) AS Peaking_Power_MW,
    -- Assuming OCGT cost: R3,000/MWh, Gas: R2,500/MWh (hypothetical)
    SUM((`Eskom OCGT Generation` * 3000) + (`Eskom Gas Generation` * 2500)) AS Estimated_Cost_ZAR
FROM Eskom_Power_Data
GROUP BY Date;

--Query 5: International Power Trade Impact
SELECT 
    DATE(`Date Time Hour Beginning`) AS Date,
    SUM(`International Imports`) AS Total_Imports_MW,
    SUM(`International Exports`) AS Total_Exports_MW,
    (SUM(`International Imports`) - SUM(`International Exports`)) AS Net_Import_MW
FROM Eskom_Power_Data
GROUP BY Date;
