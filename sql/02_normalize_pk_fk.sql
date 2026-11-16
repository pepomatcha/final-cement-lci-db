USE final_cement_db;

-- ==========================================================
-- 1. 2NF Decomposition: Separate cement_techniques from energy_using
--    Removes partial dependency (technich -> sourcelink)
-- ==========================================================
CREATE TABLE cement_techniques (
    technich VARCHAR(50) NOT NULL,
    sourcelink VARCHAR(255),
    PRIMARY KEY (technich)
);

INSERT INTO cement_techniques (technich, sourcelink)
SELECT DISTINCT technich, sourcelink
FROM energy_using;

CREATE TABLE energy_using_2nf (
    technich VARCHAR(50) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    energy DECIMAL(10, 2),
    PRIMARY KEY (technich, unit),
    CONSTRAINT fk_energy_technique
        FOREIGN KEY (technich) REFERENCES cement_techniques(technich)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO energy_using_2nf (technich, unit, energy)
SELECT technich, unit, energy
FROM energy_using;

-- ==========================================================
-- 2. 3NF Decomposition: Separate products from cement_production
--    Removes transitive dependencies (product -> unit, sourcelink)
-- ==========================================================
CREATE TABLE products (
    product_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    unit VARCHAR(20) NOT NULL,
    sourcelink VARCHAR(255),
    PRIMARY KEY (product_id)
);

INSERT INTO products (product_name, unit, sourcelink)
SELECT DISTINCT product, unit, sourcelink
FROM cement_production;

CREATE TABLE cement_production_3nf (
    year INT NOT NULL,
    month INT NOT NULL,
    product_id INT NOT NULL,
    production BIGINT,
    thousand_baht BIGINT,
    PRIMARY KEY (year, month),
    CONSTRAINT fk_production_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO cement_production_3nf (year, month, product_id, production, thousand_baht)
SELECT cp.year, cp.month, p.product_id, cp.production, cp.thousand_baht
FROM cement_production cp
INNER JOIN products p ON cp.product = p.product_name;

-- ==========================================================
-- 3. Drop unnormalized staging tables so only the 7 normalized tables remain
-- ==========================================================
DROP TABLE energy_using;
DROP TABLE cement_production;

SHOW TABLES;