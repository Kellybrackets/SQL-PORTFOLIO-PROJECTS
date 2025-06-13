--Objective: Understand overall shipment volume.
SELECT 
    COUNT(*) AS Total_Orders,
    SUM(Weight) AS Total_Weight_Shipped,
    SUM([Unit quantity]) AS Total_Units_Shipped
FROM OrderList;

--Objective: Identify key customers for targeted logistics planning.
SELECT 
    Customer,
    COUNT(*) AS Order_Count,
    SUM([Unit quantity]) AS Total_Units,
    SUM(Weight) AS Total_Weight
FROM OrderList
GROUP BY Customer
ORDER BY Order_Count DESC
LIMIT 5;

--Objective: Evaluate carriers based on late shipments.
SELECT 
    Carrier,
    COUNT(*) AS Total_Orders,
    AVG([Ship Late Day count]) AS Avg_Late_Days,
    SUM(CASE WHEN [Ship Late Day count] > 0 THEN 1 ELSE 0 END) AS Late_Shipments,
    (SUM(CASE WHEN [Ship Late Day count] > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Late_Percentage
FROM OrderList
GROUP BY Carrier
ORDER BY Late_Percentage DESC;

--Objective: Identify heavy shipments that may require special handling.
SELECT 
    [Order ID],
    Customer,
    [Product ID],
    Weight,
    [Unit quantity],
    [Destination Port]
FROM OrderList
WHERE Weight > (SELECT AVG(Weight) + 2 * STDDEV(Weight) FROM OrderList)
ORDER BY Weight DESC;

--Objective: Identify busiest routes for logistics optimization.
SELECT 
    [Origin Port],
    [Destination Port],
    COUNT(*) AS Shipment_Count,
    SUM(Weight) AS Total_Weight,
    AVG(TPT) AS Avg_Transit_Time
FROM OrderList
GROUP BY [Origin Port], [Destination Port]
ORDER BY Shipment_Count DESC;

--Objective: Optimize inventory distribution based on demand.
SELECT 
    [Plant Code],
    [Product ID],
    SUM([Unit quantity]) AS Total_Units,
    SUM(Weight) AS Total_Weight
FROM OrderList
GROUP BY [Plant Code], [Product ID]
ORDER BY Total_Units DESC;