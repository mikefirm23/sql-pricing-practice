-- schema.sql
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS borrowers;

CREATE TABLE borrowers (
    borrower_id INTEGER PRIMARY KEY,
    borrower_name TEXT NOT NULL,
    credit_score INTEGER NOT NULL,
    state TEXT NOT NULL
);

CREATE TABLE loans (
    loan_id INTEGER PRIMARY KEY,
    borrower_id INTEGER NOT NULL,
    loan_amount DECIMAL(12,2) NOT NULL,
    interest_rate DECIMAL(5,3) NOT NULL,
    lock_status TEXT NOT NULL,
    product_type TEXT NOT NULL,
    expected_margin_bps INTEGER NOT NULL,
    FOREIGN KEY (borrower_id) REFERENCES borrowers(borrower_id)
);
