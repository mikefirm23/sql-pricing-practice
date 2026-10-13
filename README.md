# SQL Pricing Practice Project

A beginner-friendly SQLite project that mimics a small mortgage pricing and loan-pipeline dataset.

## Business purpose
Use SQL to answer practical questions about loan volume, average rates, expected revenue, risk tiers, and lock status.

## Files
- `schema.sql`: creates the tables
- `seed.sql`: loads sample data
- `queries.sql`: contains worked examples
- `challenge.sql`: contains practice questions

## Run with SQLite
```bash
sqlite3 pricing_practice.db
.read schema.sql
.read seed.sql
.read queries.sql
```

## Git practice workflow
```bash
git checkout -b feature/add-analysis
git add .
git commit -m "Add SQL pricing analysis"
git push -u origin feature/add-analysis
```

Then open a pull request on GitHub.
