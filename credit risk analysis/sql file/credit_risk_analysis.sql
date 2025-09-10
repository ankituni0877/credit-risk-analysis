CREATE DATABASE credit_risk_db;
USE credit_risk_db;
CREATE TABLE credit_risk (
    id INT AUTO_INCREMENT PRIMARY KEY,
    person_age INT,
    person_income BIGINT,
    person_home_ownership VARCHAR(50),
    person_emp_length FLOAT,
    loan_intent VARCHAR(50),
    loan_grade VARCHAR(10),
    loan_amnt INT,
    loan_int_rate FLOAT,
    loan_status VARCHAR(20),
    loan_percent_income FLOAT,
    cb_person_default_on_file VARCHAR(5),
    cb_person_cred_hist_length INT
);
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
LOAD DATA INFILE 'C:\Users\adity\OneDrive\Desktop\credit_risk_analysis\data\processed\credit_risk_cleaned.csv'
INTO TABLE credit_risk
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(person_age, person_income, person_home_ownership, person_emp_length, loan_intent, loan_grade, loan_amnt, loan_int_rate, loan_status, loan_percent_income, cb_person_default_on_file, cb_person_cred_hist_length);
LOAD DATA LOCAL INFILE 'C:\Users\adity\OneDrive\Desktop\credit_risk_analysis\data\processed\credit_risk_cleaned.csv'
INTO TABLE credit_risk
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(person_age, person_income, person_home_ownership, person_emp_length, loan_intent, loan_grade, loan_amnt, loan_int_rate, loan_status, loan_percent_income, cb_person_default_on_file, cb_person_cred_hist_length);
LOAD DATA LOCAL INFILE 'C:/Users/adity/OneDrive/Desktop/credit_risk_analysis/data/processed/credit_risk_cleaned.csv'
INTO TABLE credit_risk
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    person_age, 
    person_income, 
    person_home_ownership, 
    person_emp_length, 
    loan_intent, 
    loan_grade, 
    loan_amnt, 
    loan_int_rate, 
    loan_status, 
    loan_percent_income, 
    cb_person_default_on_file, 
    cb_person_cred_hist_length
);
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
USE credit_risk_analysis;

LOAD DATA LOCAL INFILE 'C:/Users/adity/OneDrive/Desktop/credit_risk_analysis/data/processed/credit_risk_cleaned.csv'
INTO TABLE credit_risk
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    person_age,
    person_income,
    person_home_ownership,
    person_emp_length,
    loan_intent,
    loan_grade,
    loan_amnt,
    loan_int_rate,
    loan_status,
    loan_percent_income,
    cb_person_default_on_file,
    cb_person_cred_hist_length
);

USE credit_risk_analysis;
LOAD DATA LOCAL INFILE 'C:/Users/adity/OneDrive/Desktop/credit_risk_analysis/data/processed/credit_risk_cleaned.csv'
INTO TABLE credit_risk
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    person_age,
    person_income,
    person_home_ownership,
    person_emp_length,
    loan_intent,
    loan_grade,
    loan_amnt,
    loan_int_rate,
    loan_status,
    loan_percent_income,
    cb_person_default_on_file,
    cb_person_cred_hist_length
);
USE credit_risk_db;
SELECT * FROM credit_risk LIMIT 10;

SELECT COUNT(*) FROM credit_risk;

-- Average loan amount
SELECT AVG(loan_amnt) FROM credit_risk;

-- Count loans by status
SELECT loan_status, COUNT(*) 
FROM credit_risk 
GROUP BY loan_status;

-- Default rate by loan grade
SELECT loan_grade, loan_status, COUNT(*) 
FROM credit_risk 
GROUP BY loan_grade, loan_status;

SELECT COUNT(*) AS total_rows FROM credit_risk;

SHOW COLUMNS FROM credit_risk;
-- Average, Min, Max loan amount
SELECT 
    AVG(loan_amnt) AS avg_loan,
    MIN(loan_amnt) AS min_loan,
    MAX(loan_amnt) AS max_loan
FROM credit_risk;

-- Average interest rate
SELECT 
    AVG(loan_int_rate) AS avg_rate 
FROM credit_risk;

SELECT loan_status, COUNT(*) AS count
FROM credit_risk
GROUP BY loan_status;
SELECT person_home_ownership, loan_status, COUNT(*) AS count
FROM credit_risk
GROUP BY person_home_ownership, loan_status
ORDER BY person_home_ownership;

SELECT loan_grade, loan_status, COUNT(*) AS count
FROM credit_risk
GROUP BY loan_grade, loan_status
ORDER BY loan_grade;

SELECT 
    ROUND(AVG(person_income), 2) AS avg_income,
    ROUND(AVG(loan_percent_income), 2) AS avg_loan_pct
FROM credit_risk;

SELECT person_emp_length, loan_status, COUNT(*) AS count
FROM credit_risk
GROUP BY person_emp_length, loan_status
ORDER BY person_emp_length;

SELECT * FROM credit_risk;


