USE final_cement_db;

-- 1. Verify all 7 normalized table structures (PK, FK, Data Types, Nullability)
DESCRIBE products;
DESCRIBE cement_production_3nf;
DESCRIBE cement_techniques;
DESCRIBE energy_using_2nf;
DESCRIBE portland_cement_process;
DESCRIBE commu_carbon;
DESCRIBE carbon_immit;

-- 2. Lossless Join Check 1: Reconstruct 3NF Production + Products (Expect 34 rows)
SELECT p.product_name,
       cp.year,
       cp.month,
       p.unit,
       cp.production,
       cp.thousand_baht,
       p.sourcelink
FROM cement_production_3nf cp
INNER JOIN products p ON cp.product_id = p.product_id
ORDER BY cp.year, cp.month;

-- 3. Lossless Join Check 2: Reconstruct 2NF Energy + Techniques (Expect 4 rows)
SELECT e.technich,
       e.energy,
       e.unit,
       t.sourcelink
FROM energy_using_2nf e
INNER JOIN cement_techniques t ON e.technich = t.technich;

-- 4. Row Count Audit Across All 7 Normalized Tables
SELECT 'products' AS table_name, COUNT(*) AS row_count FROM products
UNION ALL SELECT 'cement_production_3nf', COUNT(*) FROM cement_production_3nf
UNION ALL SELECT 'cement_techniques', COUNT(*) FROM cement_techniques
UNION ALL SELECT 'energy_using_2nf', COUNT(*) FROM energy_using_2nf
UNION ALL SELECT 'portland_cement_process', COUNT(*) FROM portland_cement_process
UNION ALL SELECT 'commu_carbon', COUNT(*) FROM commu_carbon
UNION ALL SELECT 'carbon_immit', COUNT(*) FROM carbon_immit;