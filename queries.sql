-- queries.sql
.headers on
.mode column

-- 1. Inspect the full pipeline
SELECT * FROM loans;

-- 2. Join borrower and loan information
SELECT
    l.loan_id,
    b.borrower_name,
    b.credit_score,
    b.state,
    l.loan_amount,
    l.interest_rate,
    l.lock_status,
    l.product_type
FROM loans AS l
JOIN borrowers AS b
    ON l.borrower_id = b.borrower_id
ORDER BY l.loan_amount DESC;

-- 3. Summarize pipeline by lock status
SELECT
    lock_status,
    COUNT(*) AS loan_count,
    ROUND(SUM(loan_amount), 2) AS total_volume,
    ROUND(AVG(interest_rate), 3) AS average_rate
FROM loans
GROUP BY lock_status
ORDER BY total_volume DESC;

-- 4. Estimate expected dollar margin
-- 100 basis points = 1 percent, so divide bps by 10,000.
SELECT
    loan_id,
    loan_amount,
    expected_margin_bps,
    ROUND(loan_amount * expected_margin_bps / 10000.0, 2) AS expected_margin_dollars
FROM loans
ORDER BY expected_margin_dollars DESC;

-- 5. Assign a simple credit tier with CASE
SELECT
    borrower_name,
    credit_score,
    CASE
        WHEN credit_score >= 760 THEN 'Tier 1'
        WHEN credit_score >= 700 THEN 'Tier 2'
        ELSE 'Tier 3'
    END AS credit_tier
FROM borrowers
ORDER BY credit_score DESC;

-- 6. Find locked loans above $300,000
SELECT loan_id, loan_amount, interest_rate
FROM loans
WHERE lock_status = 'Locked'
  AND loan_amount > 300000
ORDER BY loan_amount DESC;
