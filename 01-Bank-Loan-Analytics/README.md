# Bank Loan Analytics

**Tools:** Power BI · MySQL

Loan portfolio analysis for a retail lending dataset: how much was lent, to whom, how it was repaid, and how verification status and home ownership relate to repayment.

## Business questions

1. How has total loan amount changed year over year?
2. How does revolving balance vary across loan grades and sub-grades?
3. Do verified borrowers repay more than non-verified borrowers?
4. How does loan status vary by state and by month?
5. How do home ownership and last payment date relate to repayment?

## Approach

- **SQL ([`sql/bank_loan_analysis.sql`](sql/bank_loan_analysis.sql))** — built two tables (`finance_1` loan details, `finance_2` payment details), joined them into a `finance_combined` view and wrote one query per business question using `GROUP BY` aggregations, `COALESCE` for missing payment dates and formatted totals in millions.
- **Power BI ([`Bank_Loan_Analytics.pbix`](Bank_Loan_Analytics.pbix))** — report pages for each KPI:
  - Total Loan Amount by Year
  - Verification Status vs Total Payment
  - State-wise Loan Status (matrix)
  - Loan Amount by Month and Loan Status
  - Loan Amount by Home Ownership and Last Payment Date
  - KPI cards: Total Loan Amount, Average Loan Amount, Loan Count

## Files

| File | Description |
|------|-------------|
| `Bank_Loan_Analytics.pbix` | Power BI report (open in Power BI Desktop) |
| `sql/bank_loan_analysis.sql` | Table creation, join view and KPI queries |
