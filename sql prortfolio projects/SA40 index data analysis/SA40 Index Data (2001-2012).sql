--1. Basic Descriptive Statistics
SELECT 
    MIN(SA40) AS min_value,
    MAX(SA40) AS max_value,
    AVG(SA40) AS avg_value,
    STDDEV(SA40) AS std_deviation,
    MAX(Date) - MIN(Date) AS time_span
FROM SA40_index;

--2. Annual Performance Analysis
SELECT 
    EXTRACT(YEAR FROM Date) AS year,
    MIN(SA40) AS min_value,
    MAX(SA40) AS max_value,
    LAST_VALUE(SA40) OVER (PARTITION BY EXTRACT(YEAR FROM Date) ORDER BY Date 
                          ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS year_end_value,
    (LAST_VALUE(SA40) OVER (PARTITION BY EXTRACT(YEAR FROM Date) ORDER BY Date 
                          ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) - 
     FIRST_VALUE(SA40) OVER (PARTITION BY EXTRACT(YEAR FROM Date) ORDER BY Date 
                           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / 
     FIRST_VALUE(SA40) OVER (PARTITION BY EXTRACT(YEAR FROM Date) ORDER BY Date 
                           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS annual_return
FROM SA40_index
GROUP BY EXTRACT(YEAR FROM Date), Date, SA40
ORDER BY year;

--3. Monthly Seasonality Patterns
SELECT 
    EXTRACT(MONTH FROM Date) AS month,
    AVG(SA40) AS avg_value,
    AVG(CASE WHEN EXTRACT(YEAR FROM Date) < 2008 THEN SA40 END) AS pre_2008_avg,
    AVG(CASE WHEN EXTRACT(YEAR FROM Date) >= 2008 THEN SA40 END) AS post_2008_avg,
    COUNT(*) AS trading_days
FROM SA40_index
GROUP BY EXTRACT(MONTH FROM Date)
ORDER BY month;

--4. Volatility Analysis by Year
WITH DailyReturns AS (
    SELECT 
        Date,
        SA40,
        (SA40 - LAG(SA40) OVER (ORDER BY Date))/LAG(SA40) OVER (ORDER BY Date) AS daily_return
    FROM SA40_index
)
SELECT 
    EXTRACT(YEAR FROM Date) AS year,
    STDDEV(daily_return) AS daily_volatility,
    MIN(daily_return) AS worst_day,
    MAX(daily_return) AS best_day,
    SUM(CASE WHEN daily_return > 0 THEN 1 ELSE 0 END) AS up_days,
    SUM(CASE WHEN daily_return < 0 THEN 1 ELSE 0 END) AS down_days
FROM DailyReturns
GROUP BY EXTRACT(YEAR FROM Date)
ORDER BY year;

--5. Drawdown Analysis
WITH PeakValues AS (
    SELECT 
        Date,
        SA40,
        MAX(SA40) OVER (ORDER BY Date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_max
    FROM SA40_index
)
SELECT 
    Date,
    SA40,
    running_max,
    (SA40 - running_max)/running_max AS drawdown
FROM PeakValues
ORDER BY drawdown ASC;

--6. Moving Average Crossovers
SELECT 
    Date,
    SA40,
    AVG(SA40) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW) AS ma50,
    AVG(SA40) OVER (ORDER BY Date ROWS BETWEEN 199 PRECEDING AND CURRENT ROW) AS ma200,
    CASE WHEN 
        AVG(SA40) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW) > 
        AVG(SA40) OVER (ORDER BY Date ROWS BETWEEN 199 PRECEDING AND CURRENT ROW)
    THEN 1 ELSE 0 END AS golden_cross
FROM SA40_index
ORDER BY Date;

--7. Recovery Periods from Major Declines
WITH MajorDeclines AS (
    SELECT 
        Date AS decline_start,
        SA40 AS start_value,
        LEAD(Date) OVER (ORDER BY Date) AS recovery_date,
        LEAD(SA40) OVER (ORDER BY Date) AS recovery_value,
        (LEAD(SA40) OVER (ORDER BY Date) - SA40)/SA40 AS recovery_pct
    FROM SA40_index
    WHERE (SA40 - LAG(SA40) OVER (ORDER BY Date))/LAG(SA40) OVER (ORDER BY Date) < -0.10
)
SELECT 
    decline_start,
    start_value,
    recovery_date,
    recovery_value,
    recovery_pct,
    recovery_date - decline_start AS days_to_recover
FROM MajorDeclines
WHERE recovery_pct > 0
ORDER BY recovery_pct DESC;
