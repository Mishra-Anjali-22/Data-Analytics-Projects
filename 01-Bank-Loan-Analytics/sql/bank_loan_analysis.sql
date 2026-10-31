CREATE DATABASE bank_acc;
USE bank_acc;

-- Finance_1 table
CREATE TABLE finance_1(
    id INT PRIMARY KEY,
    member_id INT,
    loan_amnt DECIMAL(10,2),
    funded_amnt DECIMAL(10,2),
    funded_amnt_inv DECIMAL(10,2),
    term INT,
    int_rate DECIMAL(5,2),
    installment DECIMAL(10,2),
    grade CHAR(1),
    sub_grade VARCHAR(3),
    home_ownership VARCHAR(20),
    annual_inc INT,
    verification_status VARCHAR(20),
    issue_month VARCHAR(4),
    issue_yr INT,
    loan_status VARCHAR(50),
    addr_state VARCHAR(10),
    dti DECIMAL(5,2)
);

-- Finance_2 table
CREATE TABLE finance_2(
    id INT PRIMARY KEY,
    revol_bal DECIMAL(12,2),
    total_pymnt DECIMAL(12,2),
    last_pymnt_yr INT
);


-- combining two datasets
CREATE VIEW finance_combined AS
SELECT  f1.id, f1.member_id, f1.loan_amnt,f1.funded_amnt,f1.funded_amnt_inv,f1.term,
		f1.int_rate,f1.installment,f1.grade,f1.sub_grade,f1.home_ownership,f1.annual_inc,
		f1.verification_status,f1.issue_month,f1.issue_yr,f1.loan_status,f1.addr_state,f1.dti,f2.revol_bal,
		f2.total_pymnt,f2.last_pymnt_yr
FROM finance_1 AS f1
LEFT JOIN finance_2 AS f2 
    ON f1.id = f2.id;

-- Analysis
-- YEAR WISE LOAN AMOUNT STATUS
SELECT 
		issue_yr AS issue_year,
		COUNT(id) AS total_loans,
 		CONCAT(FORMAT(SUM(loan_amnt)/1000000,2),'M') AS total_loan_amount,
		ROUND(AVG(loan_amnt),2) AS avg_loan_amount,
		MAX(loan_amnt) AS max_loan_amount,
		MIN(loan_amnt) AS min_loan_amount
FROM finance_1
GROUP BY issue_year
ORDER BY issue_year;

-- GRADE AND SUB GRADE WISE REVOL_BAL
SELECT 
    grade,
    sub_grade,
    CONCAT(FORMAT(SUM(revol_bal)/1000000,2),'M') AS total_revol_bal,
    ROUND(AVG(revol_bal),2) AS avg_revol_bal,
    COUNT(*) AS loan_count
FROM finance_combined
GROUP BY grade, sub_grade
ORDER BY grade, sub_grade;

-- TOTAL PAYMENT FOR VERIFIED STATUS vs TOTAL PAYMENT FOR NON VERIFIED STATUS
SELECT 
    verification_status,
    CONCAT(FORMAT(SUM(total_pymnt)/1000000,2),'M') AS total_payment,
    ROUND(AVG(total_pymnt),2) AS avg_payment,
    COUNT(*) AS loan_count
FROM finance_combined
WHERE verification_status <> 'Source Verified'
GROUP BY verification_status;

-- STATE WISE AND MONTH WISE LOAN STATUS
SELECT 
    addr_state,
    issue_yr,
    issue_month,
    loan_status,
    COUNT(*) AS loan_count,
    SUM(loan_amnt) AS total_loan_amt
FROM finance_combined
GROUP BY addr_state, issue_yr, issue_month, loan_status
ORDER BY addr_state, issue_yr, issue_month, loan_status;

-- HOME OWNERSHIP vs LAST PAYMENT DATE STATS
SELECT 
    home_ownership,
    COALESCE(CAST(last_pymnt_yr AS CHAR), 'No Last Payment Date') AS last_payment_year,
    COUNT(*) AS loan_count,
    CONCAT(FORMAT(SUM(total_pymnt)/1000000,2),'M') AS total_payment,
    ROUND(AVG(total_pymnt),2) AS avg_payment
FROM finance_combined
GROUP BY home_ownership, last_pymnt_yr
ORDER BY home_ownership, last_pymnt_yr DESC;




