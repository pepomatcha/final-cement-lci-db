CREATE DATABASE IF NOT EXISTS final_cement_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE final_cement_db;

-- 1. portland_cement_process (7 rows)
CREATE TABLE portland_cement_process (
    product VARCHAR(100) NOT NULL,
    quantity DECIMAL(10, 2),
    unit VARCHAR(20),
    sourcelink VARCHAR(255),
    PRIMARY KEY (product)
);

INSERT INTO portland_cement_process (product, quantity, unit, sourcelink) VALUES
('Calcium Oxide', 0.67, 'Tons', 'https://www.cementl.com/th/what-is-portland-cement-made-of/'),
('Silicon dioxide', 0.25, 'Tons', 'https://www.cementl.com/th/what-is-portland-cement-made-of/'),
('Alumina', 0.08, 'Tons', 'https://www.cementl.com/th/what-is-portland-cement-made-of/'),
('Iron oxide', 0.06, 'Tons', 'https://www.cementl.com/th/what-is-portland-cement-made-of/'),
('Magnesium oxide', 0.04, 'Tons', 'https://www.cementl.com/th/what-is-portland-cement-made-of/'),
('Sulfur trioxide', 0.03, 'Tons', 'https://www.cementl.com/th/what-is-portland-cement-made-of/'),
('potassium carbonate', 0.01, 'Tons', 'https://www.cementl.com/th/what-is-portland-cement-made-of/');

-- 2. cement_production (34 rows)
CREATE TABLE cement_production (
    product VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    unit VARCHAR(20),
    production BIGINT,
    thousand_baht BIGINT,
    sourcelink VARCHAR(255),
    PRIMARY KEY (year, month)
);

INSERT INTO cement_production (product, year, month, unit, production, thousand_baht, sourcelink) VALUES
('Portland Cement', 2021, 1, 'Tons', 2890376, 4354456, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 2, 'Tons', 2663853, 4192086, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 3, 'Tons', 3264265, 5105578, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 4, 'Tons', 2859336, 3931938, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 5, 'Tons', 3126131, 4552495, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 6, 'Tons', 2949782, 4157581, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 7, 'Tons', 2571146, 3650855, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 8, 'Tons', 2639970, 3670921, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 9, 'Tons', 2213033, 3266075, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 10, 'Tons', 2205298, 3352742, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 11, 'Tons', 2403556, 3564667, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2021, 12, 'Tons', 2796898, 4018880, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 1, 'Tons', 2820443, 4515805, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 2, 'Tons', 2697679, 4602199, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 3, 'Tons', 3104740, 5320735, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 4, 'Tons', 2718398, 4334538, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 5, 'Tons', 2767976, 4852086, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 6, 'Tons', 2771070, 4948009, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 7, 'Tons', 2795998, 4763224, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 8, 'Tons', 2628295, 4688287, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 9, 'Tons', 2369883, 4363180, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 10, 'Tons', 2310050, 4352985, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 11, 'Tons', 2495278, 4796609, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2022, 12, 'Tons', 2759364, 4944523, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2023, 1, 'Tons', 2513635, 5125937, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2023, 2, 'Tons', 2692170, 5304774, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2023, 3, 'Tons', 3063437, 6198403, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2023, 4, 'Tons', 2639801, 4600616, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2023, 5, 'Tons', 2669425, 5437877, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2023, 6, 'Tons', 2725018, 5604694, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2023, 7, 'Tons', 3259630, 5553127, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2023, 8, 'Tons', 2616623, 5100314, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2023, 9, 'Tons', 2533695, 4222450, 'https://i.index.oie.go.th/industrialStatistics1.aspx'),
('Portland Cement', 2023, 10, 'Tons', 2347707, 4401777, 'https://i.index.oie.go.th/industrialStatistics1.aspx');

-- 3. energy_using (4 rows)
CREATE TABLE energy_using (
    technich VARCHAR(50) NOT NULL,
    energy DECIMAL(10, 2),
    unit VARCHAR(20) NOT NULL,
    sourcelink VARCHAR(255),
    PRIMARY KEY (technich, unit)
);

INSERT INTO energy_using (technich, energy, unit, sourcelink) VALUES
('portland_dry', 85.00, 'kWh/ton', 'https://www.cementl.com/th/what-is-the-dry-process-in-portland-cement-production/'),
('portland_wet', 110.00, 'kWh/ton', 'https://www.cementl.com/th/what-is-the-dry-process-in-portland-cement-production/'),
('portland_dry', 3.10, 'KJ/ton', 'https://www.cementl.com/th/what-is-the-dry-process-in-portland-cement-production/'),
('portland_wet', 5.40, 'KJ/ton', 'https://www.cementl.com/th/what-is-the-dry-process-in-portland-cement-production/');

-- 4. commu_carbon (32 rows)
CREATE TABLE commu_carbon (
    id INT NOT NULL,
    factor DECIMAL(10, 4),
    factor_unit VARCHAR(50),
    unit VARCHAR(20),
    sourcelink VARCHAR(255),
    PRIMARY KEY (id)
);

INSERT INTO commu_carbon (id, factor, factor_unit, unit, sourcelink) VALUES
(198, 1.1208, 'kgCO2e/unit', 'km', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(199, 0.1042, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(200, 0.0745, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(201, 0.0589, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(202, 0.9454, 'kgCO2e/unit', 'km', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(203, 0.0840, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(204, 0.0577, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(205, 0.0433, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(206, 1.1848, 'kgCO2e/unit', 'km', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(207, 0.1049, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(208, 0.0745, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(209, 0.0591, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(178, 0.6313, 'kgCO2e/unit', 'km', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(179, 0.0918, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(180, 0.0624, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(181, 0.0470, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(182, 0.7378, 'kgCO2e/unit', 'km', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(183, 0.1097, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(184, 0.0772, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(185, 0.0610, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(186, 0.4638, 'kgCO2e/unit', 'km', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(187, 0.0834, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(188, 0.0610, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(189, 0.0474, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(190, 0.4822, 'kgCO2e/unit', 'km', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(191, 0.0985, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(192, 0.0731, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(193, 0.0546, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(194, 0.9126, 'kgCO2e/unit', 'km', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(195, 0.0840, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(196, 0.0594, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)'),
(197, 0.0461, 'kgCO2e/unit', 'tkm', 'Thai National LCI Database, TIIS-MTEC-NSTDA (with TGO electricity 2022-2024)');

-- 5. carbon_immit (schema ready)
CREATE TABLE carbon_immit (
    product VARCHAR(100) NOT NULL,
    carbon DECIMAL(10, 4),
    unit VARCHAR(50),
    sourcelink VARCHAR(255),
    PRIMARY KEY (product)
);

SHOW DATABASES;
SHOW TABLES;