--Objective: Get a high-level breakdown of interaction types.
SELECT 
    "Interaction type",
    COUNT(*) AS interaction_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM e_commerce_data), 1) AS percentage
FROM e_commerce_data
GROUP BY "Interaction type";

--Insight:
--Purchases (33.6%), Views (33.2%), and Likes (33.2%) are evenly distributed.
--Suggests a balanced but opportunity to improve conversion from views/likes to purchases.

--Objective: Track how users move from views → likes → purchases.
WITH user_journey AS (
    SELECT 
        "user id",
        MAX(CASE WHEN "Interaction type" = 'view' THEN 1 ELSE 0 END) AS viewed,
        MAX(CASE WHEN "Interaction type" = 'like' THEN 1 ELSE 0 END) AS liked,
        MAX(CASE WHEN "Interaction type" = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM e_commerce_data
    GROUP BY "user id"
)
SELECT 
    SUM(viewed) AS total_views,
    SUM(liked) AS total_likes,
    SUM(purchased) AS total_purchases,
    ROUND(SUM(liked) * 100.0 / SUM(viewed), 1) AS view_to_like_rate,
    ROUND(SUM(purchased) * 100.0 / SUM(liked), 1) AS like_to_purchase_rate,
    ROUND(SUM(purchased) * 100.0 / SUM(viewed), 1) AS view_to_purchase_rate
FROM user_journey;

--Insight:
--If View → Like conversion is low, product appeal may need improvement.
--If Like → Purchase is low, pricing or checkout friction may be an issue.

--Objective: Identify best-selling products for inventory & marketing focus.
SELECT 
    "product id",
    COUNT(*) AS purchase_count
FROM e_commerce_data
WHERE "Interaction type" = 'purchase'
GROUP BY "product id"
ORDER BY purchase_count DESC
LIMIT 10;

--Insight:
--Helps in stocking high-demand products and promoting similar items.
--If certain products have low purchases despite high views, investigate why.

--Objective: Identify peak sales periods.
SELECT 
    EXTRACT(MONTH FROM TO_DATE("Time stamp", 'DD/MM/YYYY')) AS month,
    COUNT(*) AS total_interactions,
    SUM(CASE WHEN "Interaction type" = 'purchase' THEN 1 ELSE 0 END) AS purchases
FROM e_commerce_data
GROUP BY month
ORDER BY month;
--Insight:
--Holiday season (Nov-Dec) likely shows higher purchases → increase ad spend.
--Low months may need promotions/discounts to boost sales.

--Objective: Find the best times for marketing campaigns.
SELECT 
    EXTRACT(HOUR FROM TO_TIMESTAMP("Time stamp", 'DD/MM/YYYY HH24:MI')) AS hour_of_day,
    COUNT(*) AS interactions
FROM e_commerce_data
GROUP BY hour_of_day
ORDER BY interactions DESC;
--Insight:
--If most interactions are at 8 AM or 10 AM, schedule email campaigns accordingly.
--Low-engagement hours may need re-targeting ads.

--Objective: Identify potential lost sales for remarketing.
SELECT 
    "user id",
    "product id"
FROM e_commerce_data
WHERE "Interaction type" = 'view'
AND "user id" NOT IN (
    SELECT DISTINCT "user id" 
    FROM e_commerce_data 
    WHERE "Interaction type" = 'purchase'
);
--Insight:
--These users are high-potential targets for discounts or retargeting ads.
--Could indicate cart abandonment issues (check checkout process).