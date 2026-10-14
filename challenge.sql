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
SELECT
    ln.loan_id,
    br.borrower_id,
    br.borrower_name,
    br.credit_score,
    br.state,
    ln.loan_amount,
    ln.interest_rate,
    ln.product_type,
    ln.lock_status
FROM loans ln
JOIN borrowers br
    ON ln.borrower_id = br.borrower_id
WHERE br.credit_score < 700
ORDER BY br.credit_score, ln.loan_id;

-- 5. Calculate expected margin dollars by lock status.
SELECT
    lock_status,
    COUNT(*) AS loan_count,
    ROUND(SUM(loan_amount), 2) AS total_loan_volume,
    ROUND(
        SUM(loan_amount * expected_margin_bps / 10000.0),
        2
    ) AS expected_margin_dollars
FROM loans
GROUP BY lock_status
ORDER BY expected_margin_dollars DESC;

-- 6. Create a CTE that ranks loans from largest to smallest.
WITH ranked_loans AS (
    SELECT
        loan_id,
        borrower_id,
        loan_amount,
        interest_rate,
        product_type,
        lock_status,
        ROW_NUMBER() OVER (
            ORDER BY loan_amount DESC, loan_id
        ) AS loan_rank
    FROM loans
)
SELECT
    loan_rank,
    loan_id,
    borrower_id,
    loan_amount,
    interest_rate,
    product_type,
    lock_status
FROM ranked_loans
ORDER BY loan_rank;

-- 7. Bonus: Use a window function to calculate each loan's percentage of total pipeline volume.
WITH raw_pipeline_share AS (
    SELECT
        loan_id,
        borrower_id,
        loan_amount,
        SUM(loan_amount) OVER () AS total_pipeline_volume,
        loan_amount * 100.0
            / SUM(loan_amount) OVER () AS raw_pipeline_share_pct
    FROM loans
),
rounded_down AS (
    SELECT
        loan_id,
        borrower_id,
        loan_amount,
        total_pipeline_volume,
        raw_pipeline_share_pct,
        CAST(raw_pipeline_share_pct * 100 AS INTEGER)
            AS base_hundredths,
        raw_pipeline_share_pct * 100
            - CAST(raw_pipeline_share_pct * 100 AS INTEGER)
            AS fractional_remainder
    FROM raw_pipeline_share
),
ranked_remainders AS (
    SELECT
        loan_id,
        borrower_id,
        loan_amount,
        total_pipeline_volume,
        base_hundredths,
        ROW_NUMBER() OVER (
            ORDER BY fractional_remainder DESC, loan_id
        ) AS remainder_rank,
        10000 - SUM(base_hundredths) OVER ()
            AS hundredths_to_allocate
    FROM rounded_down
)
SELECT
    loan_id,
    borrower_id,
    loan_amount,
    ROUND(total_pipeline_volume, 2)
        AS total_pipeline_volume,
    ROUND(
        (
            base_hundredths
            + CASE
                WHEN remainder_rank <= hundredths_to_allocate
                    THEN 1
                ELSE 0
            END
        ) / 100.0,
        2
    ) AS pipeline_share_pct
FROM ranked_remainders
ORDER BY pipeline_share_pct DESC, loan_id;

