USE digital_payments;
CREATE TABLE transactions (
    Transaction_ID VARCHAR(20) PRIMARY KEY,
    Transaction_Date DATE,
    Transaction_Time TIME,
    Customer_ID VARCHAR(20),
    Amount DECIMAL(12,2),
    Payment_Method VARCHAR(50),
    Transaction_Type VARCHAR(50),
    Location VARCHAR(50),
    Device_Type VARCHAR(30),
    Merchant_Category VARCHAR(50),
    Customer_Age INT,
    Transaction_Status VARCHAR(30),
    Fraud_Flag INT,
    Transaction_Hour INT,
    Time_Period VARCHAR(30),
    Amount_Category VARCHAR(30)
);
SELECT *
FROM transactions;
SELECT COUNT(*) AS total_transactions
FROM transactions;
SELECT SUM(Amount) AS total_transaction_value
FROM transactions;
SELECT AVG(Amount) AS average_transaction_value
FROM transactions;
SELECT COUNT(*) AS fraud_transactions
FROM transactions
WHERE Fraud_Flag = 1;
SELECT SUM(Amount) AS fraud_amount
FROM transactions
WHERE Fraud_Flag = 1;
SELECT
    SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END) * 100.0
    / COUNT(*) AS fraud_rate
FROM transactions;
SELECT
    Payment_Method,
    COUNT(*) AS total_transactions,
    SUM(Fraud_Flag) AS fraud_transactions,
    SUM(CASE WHEN Fraud_Flag = 1 THEN Amount ELSE 0 END) AS fraud_amount
FROM transactions
GROUP BY Payment_Method
ORDER BY fraud_transactions DESC;
SELECT
    Location,
    COUNT(*) AS total_transactions,
    SUM(Fraud_Flag) AS fraud_transactions
FROM transactions
GROUP BY Location
ORDER BY fraud_transactions DESC;
SELECT
    Device_Type,
    COUNT(*) AS total_transactions,
    SUM(Fraud_Flag) AS fraud_transactions
FROM transactions
GROUP BY Device_Type
ORDER BY fraud_transactions DESC;
SELECT
    Merchant_Category,
    COUNT(*) AS total_transactions,
    SUM(Fraud_Flag) AS fraud_transactions
FROM transactions
GROUP BY Merchant_Category
ORDER BY fraud_transactions DESC;
SELECT
    Time_Period,
    COUNT(*) AS total_transactions,
    SUM(Fraud_Flag) AS fraud_transactions
FROM transactions
GROUP BY Time_Period
ORDER BY fraud_transactions DESC;
SELECT
    Transaction_Type,
    COUNT(*) AS total_transactions,
    SUM(Fraud_Flag) AS fraud_transactions
FROM transactions
GROUP BY Transaction_Type
ORDER BY fraud_transactions DESC;
SELECT
    Payment_Method,
    SUM(Fraud_Flag) AS fraud_transactions
FROM transactions
GROUP BY Payment_Method
HAVING SUM(Fraud_Flag) > 5;
SELECT
    Transaction_ID,
    Amount,
    CASE
        WHEN Amount >= 15000 THEN 'High Risk'
        WHEN Amount >= 5000 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Level
FROM transactions;
WITH fraud_summary AS (
    SELECT
        Payment_Method,
        COUNT(*) AS total_transactions,
        SUM(Fraud_Flag) AS fraud_transactions
    FROM transactions
    GROUP BY Payment_Method
)
SELECT *
FROM fraud_summary
ORDER BY fraud_transactions DESC;
SELECT
    Payment_Method,
    fraud_transactions,
    RANK() OVER (
        ORDER BY fraud_transactions DESC
    ) AS fraud_rank
FROM (
    SELECT
        Payment_Method,
        SUM(Fraud_Flag) AS fraud_transactions
    FROM transactions
    GROUP BY Payment_Method
) AS x;