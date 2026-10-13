-- 1. What is the total loan volume by state?

SELECT
    b.state,
    COUNT(*) AS loan_count,
    ROUND(SUM(l.loan_amount), 2) AS total_loan_volume
FROM borrowers b
JOIN loans l
    ON b.borrower_id = l.borrower_id
GROUP BY b.state
ORDER BY total_loan_volume DESC;


-- 2. Which product type has the highest average expected margin in basis points?
SELECT
    product_type,
    ROUND(AVG(expected_margin_bps), 2) AS avg_margin_bps
FROM loans
GROUP BY product_type
ORDER BY avg_margin_bps DESC
LIMIT 1;

-- 3. Show every borrower, including any borrower who has no loan.

SELECT
    br.borrower_id,
    br.borrower_name,
    br.credit_score,
    br.state,
    ln.loan_id,
    ln.loan_amount,
    ln.product_type,
    ln.lock_status
FROM borrowers br
LEFT JOIN loans ln
    ON br.borrower_id = ln.borrower_id
ORDER BY br.borrower_id, ln.loan_id;



-- 4. Return only loans with a credit score below 700.

-- 5. Calculate expected margin dollars by lock status.

-- 6. Create a CTE that ranks loans from largest to smallest.

-- 7. Bonus: Use a window function to calculate each loan's percentage of total pipeline volume.
