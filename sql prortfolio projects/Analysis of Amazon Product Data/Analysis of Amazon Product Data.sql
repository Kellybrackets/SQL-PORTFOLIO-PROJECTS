--Query 1: Top-Rated Products (Rating ≥ 4.5)
SELECT product_name, rating, rating_count, discounted_price  
FROM amazon_products  
WHERE rating >= 4.5  
ORDER BY rating DESC, rating_count DESC; 

--Query 2: Discount Impact on Sales Volume
SELECT product_name, actual_price, discounted_price, discount_percentage, rating_count  
FROM amazon_products  
ORDER BY discount_percentage DESC  
LIMIT 10;  

--Query 3: Most Reviewed Products (Customer Engagement)
SELECT product_name, rating_count, rating  
FROM amazon_products  
ORDER BY rating_count DESC  
LIMIT 5;  

--Query 4: Category-wise Performance (Cables vs. Smart TVs)
SELECT 
    CASE 
        WHEN category LIKE '%Cables%' THEN 'Cables' 
        WHEN category LIKE '%SmartTelevisions%' THEN 'Smart TVs' 
        ELSE 'Others' 
    END AS category_group,  
    AVG(rating) AS avg_rating,  
    SUM(rating_count) AS total_reviews  
FROM amazon_products  
GROUP BY category_group  
ORDER BY total_reviews DESC;  

--Query 5: Sentiment Analysis (Positive vs. Negative Reviews)
SELECT  
    product_name,  
    SUM(CASE WHEN review_content LIKE '%good%' OR '%great%' THEN 1 ELSE 0 END) AS positive_reviews,  
    SUM(CASE WHEN review_content LIKE '%bad%' OR '%issue%' THEN 1 ELSE 0 END) AS negative_reviews  
FROM amazon_products  
GROUP BY product_name  
ORDER BY positive_reviews DESC  
LIMIT 5;  
