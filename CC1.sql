USE Credit_Card_Fraud_PRJ;


--Combined Both Table
INSERT INTO cleaned_fraudTrain
SELECT * FROM cleaned_fraudTest;

SELECT COUNT(*) FROM cleaned_fraudTrain;--NOW IN THIS TABLE IT HAS FULL DATA


--Transaction Summary
--calculate total transactions and fraud cases.
SELECT COUNT(trans_num) AS TotalTRansaction,
	   SUM(is_fraud) AS TotalFraud 
FROM cleaned_fraudTrain;


--Fraud Rate by Merchant:
--Identify merchants with high fraud rates
SELECT TOP(5)* FROM cleaned_fraudTrain;



-- Fraud rate by merchant in FraudTrain
SELECT 

    merchant,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    (SUM(is_fraud) / COUNT(*)) AS fraud_rate
FROM cleaned_fraudTrain
GROUP BY merchant
HAVING COUNT(*) > 100  -- Filter for merchants with at least 100 transactions
ORDER BY fraud_rate DESC;

--Fraud Rate by Customer Demographics:
--Analyzing fraud rates by customer demographics like gender or job

SELECT gender,
COUNT(*) AS Total_Transaction,
SUM(is_fraud) Fraud_Transaction,
ROUND(CAST(SUM(is_fraud) AS float) / COUNT(*),4) AS fraud_rate
FROM cleaned_fraudTrain
GROUP BY gender;

SELECT job,
COUNT(*) AS Total_Transaction,
SUM(is_fraud) AS Total_Fraud,
ROUND(CAST(SUM(is_fraud) AS float)/ COUNT(*),4) AS Fraud_Rate
FROM cleaned_fraudTrain
GROUP BY job;

--Fraud by City or State:
--Analyze fraud by location, e.g., by city or state:
SELECT city,SUM(is_fraud) AS Total_Fraud FROM cleaned_fraudTrain
GROUP BY city
ORDER BY Total_Fraud DESC

SELECT state,SUM(is_fraud) AS Total_Fraud FROM cleaned_fraudTrain
GROUP BY state
ORDER BY Total_Fraud DESC

--Fraud Over Time
--Analyze fraud trends over time, e.g., by month or year:
SELECT 
YEAR(trans_date_trans_time) AS Years,
MONTH(trans_date_trans_time) AS Months,
COUNT(*) AS Total_Transaction,
SUM(is_fraud) AS Total_Fraud
FROM cleaned_fraudTrain
GROUP BY YEAR(trans_date_trans_time),MONTH(trans_date_trans_time)
ORDER BY Years,Months;


-- Fraud Risk by Merchant Latitude and Longitude
--Use the geographical data to identify areas with high fraud risk.


SELECT 
merch_lat,merch_long,
COUNT(*) AS Total_Transaction,
SUM(is_fraud) AS Total_Fraud
FROM cleaned_fraudTrain
GROUP BY merch_lat,merch_long
HAVING SUM(is_fraud)=1;


-- Detect potential fraudulent transactions based on anomalies in transaction amount, frequency, and location

