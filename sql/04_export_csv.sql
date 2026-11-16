USE final_cement_db;

-- 1. Export products.csv
SELECT 'product_id', 'product_name', 'unit', 'sourcelink'
UNION ALL
SELECT product_id, product_name, unit, IFNULL(sourcelink, '')
FROM products
INTO OUTFILE '/var/lib/mysql-files/products.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- 2. Export cement_production_3nf.csv
SELECT 'year', 'month', 'product_id', 'production', 'thousand_baht'
UNION ALL
SELECT year, month, product_id, IFNULL(production, ''), IFNULL(thousand_baht, '')
FROM cement_production_3nf
INTO OUTFILE '/var/lib/mysql-files/cement_production_3nf.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- 3. Export cement_techniques.csv
SELECT 'technich', 'sourcelink'
UNION ALL
SELECT technich, IFNULL(sourcelink, '')
FROM cement_techniques
INTO OUTFILE '/var/lib/mysql-files/cement_techniques.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- 4. Export energy_using_2nf.csv
SELECT 'technich', 'unit', 'energy'
UNION ALL
SELECT technich, unit, IFNULL(energy, '')
FROM energy_using_2nf
INTO OUTFILE '/var/lib/mysql-files/energy_using_2nf.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- 5. Export portland_cement_process.csv
SELECT 'product', 'quantity', 'unit', 'sourcelink'
UNION ALL
SELECT product, IFNULL(quantity, ''), IFNULL(unit, ''), IFNULL(sourcelink, '')
FROM portland_cement_process
INTO OUTFILE '/var/lib/mysql-files/portland_cement_process.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- 6. Export commu_carbon.csv
SELECT 'id', 'factor', 'factor_unit', 'unit', 'sourcelink'
UNION ALL
SELECT id, IFNULL(factor, ''), IFNULL(factor_unit, ''), IFNULL(unit, ''), IFNULL(sourcelink, '')
FROM commu_carbon
INTO OUTFILE '/var/lib/mysql-files/commu_carbon.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- 7. Export carbon_immit.csv
SELECT 'product', 'carbon', 'unit', 'sourcelink'
UNION ALL
SELECT product, IFNULL(carbon, ''), IFNULL(unit, ''), IFNULL(sourcelink, '')
FROM carbon_immit
INTO OUTFILE '/var/lib/mysql-files/carbon_immit.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';