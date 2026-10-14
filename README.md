# SQL Mortgage Pricing and Pipeline Analysis

A beginner-friendly SQLite project that models a fictional mortgage loan pipeline and demonstrates practical SQL analysis, database validation, and GitHub version-control workflows.

## Business Purpose

This project demonstrates how a pricing or capital-markets analyst can use SQL to evaluate:

- Loan-production volume
- Geographic concentrations
- Interest rates and product mix
- Rate-lock status
- Borrower credit characteristics
- Expected margin in basis points and dollars
- Loan-level pipeline concentration
- Missing relationships and data-quality exceptions

The project uses a small fictional dataset for educational and portfolio purposes.

## Database Structure

The project contains two related tables.

### `borrowers`

Stores borrower-level information:

- `borrower_id`
- `borrower_name`
- `credit_score`
- `state`

### `loans`

Stores loan-level information:

- `loan_id`
- `borrower_id`
- `loan_amount`
- `interest_rate`
- `lock_status`
- `product_type`
- `expected_margin_bps`

The tables are connected through `borrower_id`.

```text
borrowers.borrower_id
          |
          +---- loans.borrower_id
```

## Project Files

- `schema.sql`: Creates the borrower and loan tables
- `seed.sql`: Loads fictional sample records
- `queries.sql`: Contains worked SQL examples
- `challenge.sql`: Contains completed analytical exercises
- `.gitignore`: Excludes generated SQLite database files
- `README.md`: Documents the project and workflow

## SQL Analyses

### 1. Loan Volume by State

Calculates loan count and total pipeline volume by state.

### 2. Average Expected Margin by Product

Identifies the product type with the highest average expected margin in basis points.

### 3. Borrower Coverage

Uses a `LEFT JOIN` to preserve every borrower, including borrowers without a matching loan.

### 4. Credit-Risk Filtering

Returns loans associated with borrowers whose credit scores are below 700.

### 5. Expected Margin by Lock Status

Converts expected-margin basis points into estimated dollars and summarizes the results by lock status.

> **Expected margin dollars = Loan amount × Expected margin basis points ÷ 10,000**

### 6. Loan Ranking

Uses a Common Table Expression and `ROW_NUMBER()` to rank loans from largest to smallest.

### 7. Pipeline Share

Uses window functions to calculate each loan's percentage of total pipeline volume while preserving loan-level detail.

The project applies total-preserving percentage rounding so the displayed percentages total exactly 100.00%.

## SQL Skills Demonstrated

- `SELECT`
- `WHERE`
- `ORDER BY`
- `JOIN`
- `LEFT JOIN`
- `GROUP BY`
- `COUNT`
- `SUM`
- `AVG`
- `ROUND`
- `CASE`
- Common Table Expressions
- `ROW_NUMBER()`
- Window functions
- Calculated fields
- Null-value analysis
- Data reconciliation
- Deterministic sorting

## Run the Project

### 1. Open SQLite

From the project directory:

```bash
sqlite3 pricing_practice.db
```

### 2. Create the Tables

At the `sqlite>` prompt:

```sql
.read schema.sql
```

### 3. Load the Sample Data

```sql
.read seed.sql
```

Run `seed.sql` only once after creating the database to avoid duplicate primary-key errors.

### 4. Configure Readable Output

```sql
.headers on
.mode column
.nullvalue NULL
```

### 5. Run the Worked Examples

```sql
.read queries.sql
```

### 6. Run the Challenge Analyses

```sql
.read challenge.sql
```

### 7. Exit SQLite

```sql
.quit
```

## Validation Results

The sample dataset contains:

- 6 borrowers
- 6 loans
- $1,940,000 in total pipeline volume
- 1 borrower without a matching loan

Key validated results include:

- North Carolina has the highest state-level pipeline volume
- The 15-year fixed product has the highest average expected margin
- Two loans are associated with borrowers whose credit scores are below 700
- Locked loans have $14,875.00 in expected margin
- Loan 103 is the largest loan at $510,000
- Loan 103 represents 26.29% of total pipeline volume
- Adjusted displayed pipeline percentages total exactly 100.00%

## GitHub Workflow

A typical feature workflow for this project is:

```bash
git switch main
git pull origin main
git switch -c feature/example-analysis
git add challenge.sql
git commit -m "Add example SQL analysis"
git push -u origin feature/example-analysis
```

After pushing the branch, open a pull request to review and merge the change into `main`.

## Data Disclaimer

All borrower and loan records in this repository are fictional and were created solely for SQL practice.

This project does not contain real borrower information, customer data, proprietary company data, or production lending policies.

## Project Limitations

The expected-margin calculations are simplified for SQL practice. A production mortgage-pricing or profitability model could also include:

- Hedge gains or losses
- Loan fallout
- Funding costs
- Servicing value
- Credit costs
- Transaction expenses
- Capital charges
- Market-price changes

The outputs should be interpreted as analytical practice results rather than realized profitability.
