// =========================================================================
// 05_neo4j_serving_layer.cypher
// GitHub username & repo : pepomatcha  final-cement-lci-db
// =========================================================================

// 1. CLEAR OLD GRAPH (Safe reset for testing)
MATCH (n) DETACH DELETE n;

// 2. CREATE UNIQUENESS CONSTRAINTS (Primary Keys)[cite: 7]
CREATE CONSTRAINT product_pk IF NOT EXISTS FOR (n:product) REQUIRE n.product_id IS UNIQUE;
CREATE CONSTRAINT production_pk IF NOT EXISTS FOR (n:cement_production_3nf) REQUIRE (n.year, n.month) IS UNIQUE;
CREATE CONSTRAINT technique_pk IF NOT EXISTS FOR (n:cement_techniques) REQUIRE n.technich IS UNIQUE;
CREATE CONSTRAINT energy_pk IF NOT EXISTS FOR (n:energy_using_2nf) REQUIRE (n.technich, n.unit) IS UNIQUE;
CREATE CONSTRAINT process_pk IF NOT EXISTS FOR (n:portland_cement_process) REQUIRE n.product IS UNIQUE;
CREATE CONSTRAINT commu_pk IF NOT EXISTS FOR (n:commu_carbon) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT carbon_immit_pk IF NOT EXISTS FOR (n:carbon_immit) REQUIRE n.product IS UNIQUE;

// 3. LOAD CSVs DIRECTLY FROM GITHUB RAW URLS & MERGE NODES[cite: 7]
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/pepomatcha/final-cement-lci-db/main/csv/products.csv' AS row
MERGE (p:product {product_id: toInteger(row.product_id)})
SET p.product_name = row.product_name, p.unit = row.unit, p.sourcelink = row.sourcelink;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/pepomatcha/final-cement-lci-db/main/csv/cement_production_3nf.csv' AS row
MERGE (cp:cement_production_3nf {year: toInteger(row.year), month: toInteger(row.month)})
SET cp.product_id = toInteger(row.product_id),
    cp.production = toInteger(row.production),
    cp.thousand_baht = toInteger(row.thousand_baht)
WITH cp
MATCH (p:product {product_id: cp.product_id})
MERGE (p)-[:source_for]->(cp);

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/pepomatcha/final-cement-lci-db/main/csv/cement_techniques.csv' AS row
MERGE (t:cement_techniques {technich: row.technich})
SET t.sourcelink = row.sourcelink;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/pepomatcha/final-cement-lci-db/main/csv/energy_using_2nf.csv' AS row
MERGE (e:energy_using_2nf {technich: row.technich, unit: row.unit})
SET e.energy = toFloat(row.energy)
WITH e
MATCH (t:cement_techniques {technich: e.technich})
MERGE (t)-[:source_for]->(e);

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/pepomatcha/final-cement-lci-db/main/csv/portland_cement_process.csv' AS row
MERGE (proc:portland_cement_process {product: row.product})
SET proc.quantity = toFloat(row.quantity), proc.unit = row.unit, proc.sourcelink = row.sourcelink;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/pepomatcha/final-cement-lci-db/main/csv/commu_carbon.csv' AS row
MERGE (cc:commu_carbon {id: toInteger(row.id)})
SET cc.factor = toFloat(row.factor),
    cc.factor_unit = row.factor_unit,
    cc.unit = row.unit,
    cc.sourcelink = row.sourcelink;

// 4. CREATE GRAPH RELATIONSHIPS (Schema Diagram)[cite: 3]
MATCH (cp:cement_production_3nf), (proc:portland_cement_process)
MERGE (cp)-[:material]->(proc);

MATCH (e:energy_using_2nf), (proc:portland_cement_process)
MERGE (e)-[:energy]->(proc);

MATCH (proc:portland_cement_process), (cc:commu_carbon)
MERGE (proc)-[:commu_emit]->(cc);

MATCH (proc:portland_cement_process), (ci:carbon_immit)
MERGE (proc)-[:carbon_immit]->(ci);

// 5. EMBEDDING + VECTOR INDEX (Cosine Similarity)[cite: 8]
UNWIND [
  {product: 'Calcium Oxide',       vec: [0.98, 0.5877, 1.0, 0.0]},
  {product: 'Silicon dioxide',     vec: [0.85, 0.2193, 1.0, 0.0]},
  {product: 'Alumina',             vec: [0.72, 0.0702, 0.0, 0.0]},
  {product: 'Iron oxide',          vec: [0.68, 0.0526, 0.0, 0.0]},
  {product: 'Magnesium oxide',     vec: [0.45, 0.0351, 0.0, 0.0]},
  {product: 'Sulfur trioxide',     vec: [0.20, 0.0263, 0.0, 1.0]},
  {product: 'potassium carbonate', vec: [0.15, 0.0088, 0.0, 1.0]}
] AS item
MATCH (proc:portland_cement_process {product: item.product})
CALL db.create.setNodeVectorProperty(proc, 'embedding', item.vec);

CREATE VECTOR INDEX process_material_idx IF NOT EXISTS
FOR (proc:portland_cement_process) ON (proc.embedding)
OPTIONS {
  indexConfig: {
    `vector.dimensions`: 4,
    `vector.similarity_function`: 'cosine'
  }
};

// ค้นหาวัตถุดิบคล้าย Calcium Oxide + คำนวณปริมาณที่ใช้ในเดือน 2023-10
CALL db.index.vector.queryNodes('process_material_idx', 3, [0.98, 0.5877, 1.0, 0.0])
YIELD node AS proc, score
MATCH (p:product)-[:source_for]->(cp:cement_production_3nf)-[:material]->(proc)
WHERE cp.year = 2023 AND cp.month = 10
RETURN proc.product, round(cp.production * proc.quantity, 2) AS req_tons,
       round(score, 4) AS score;


// 6. TEST QUERIES (Semantic Search + Multi-Hop Traversal)[cite: 9]
// Q1: Top 3 materials similar to Calcium Oxide
CALL db.index.vector.queryNodes('process_material_idx', 3, [0.98, 0.5877, 1.0, 0.0])
YIELD node AS proc, score
RETURN proc.product AS material, proc.quantity AS tons_per_ton, round(score, 4) AS score
ORDER BY score DESC;

// Q2 (Single-hop Vector Search): Find alkali/sulfate minor additives similar to [0.18, 0.02, 0.0, 1.0]
CALL db.index.vector.queryNodes('process_material_idx', 3, [0.18, 0.02, 0.0, 1.0])
YIELD node AS proc, score
RETURN proc.product AS additive,
       proc.quantity AS tons_per_ton_cement,
       proc.unit AS unit,
       round(score, 4) AS similarity_score
ORDER BY similarity_score DESC;

// Q3: Multi-hop semantic search + 2023-10 production + transport emission factor (ID 201)
CALL db.index.vector.queryNodes('process_material_idx', 2, [0.98, 0.5877, 1.0, 0.0])
YIELD node AS proc, score
MATCH (p:product)-[:source_for]->(cp:cement_production_3nf)-[:material]->(proc)-[:commu_emit]->(cc:commu_carbon)
WHERE cp.year = 2023 AND cp.month = 10 AND cc.id = 201
RETURN p.product_name AS product, cp.year AS year, cp.month AS month,
       cp.production AS monthly_tons, proc.product AS material,
       round(cp.production * proc.quantity, 2) AS required_material_tons,
       cc.id AS transport_id, cc.factor AS kgCO2e_per_tkm, round(score, 4) AS score;


// test query
MATCH (p:product)-[:source_for]->(cp:cement_production_3nf)
RETURN p.product_id AS product_id,
       p.product_name AS product_name,
       cp.year AS year,
       cp.month AS month,
       cp.production AS production,
       cp.thousand_baht AS thousand_baht,
       p.unit AS unit,
       p.sourcelink AS sourcelink
ORDER BY cp.year, cp.month;

MATCH (proc:portland_cement_process)
WHERE proc.quantity >= 0.08
RETURN proc.product, proc.quantity, proc.unit
ORDER BY proc.quantity DESC;

MATCH (p:product)-[:source_for]->
(cp:cement_production_3nf)
RETURN p.product_name, cp.year,
round(avg(cp.production)) AS avg_tons
ORDER BY cp.year;

MATCH (proc:portland_cement_process)
-[:commu_emit]->(cc:commu_carbon)
WHERE cc.unit = 'tkm' AND cc.factor < 0.0600
RETURN DISTINCT cc.id, cc.factor, cc.unit
ORDER BY cc.factor ASC;