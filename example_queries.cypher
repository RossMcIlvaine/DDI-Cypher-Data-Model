// =============================================================
//  DDI Graph Database — Example Queries
//  Target: Neo4j AuraDB
// =============================================================


// ---------------------------------------------------------------
// Q1. BASIC LOOKUP — Is there an interaction between two specific drugs?
//     Use case: Pharmacist checks a two-drug combo at dispensing
// ---------------------------------------------------------------
MATCH (a:Drug {name: 'Warfarin'})-[i:INTERACTS_WITH]->(b:Drug {name: 'Ibuprofen'})
RETURN
  a.name        AS drug_a,
  b.name        AS drug_b,
  i.severity    AS severity,
  i.effect      AS effect,
  i.reference   AS reference
// Alternative via Interaction node (includes mechanism + alternative):
UNION
MATCH (a:Drug {name: 'Warfarin'})-[:PARTICIPATES_IN]->(i:Interaction)<-[:PARTICIPATES_IN]-(b:Drug {name: 'Ibuprofen'})
MATCH (i)-[:HAS_MECHANISM]->(m:Mechanism)
MATCH (i)-[:HAS_SAFER_ALTERNATIVE]->(s:SaferAlternative)
RETURN
  a.name        AS drug_a,
  b.name        AS drug_b,
  i.severity    AS severity,
  i.effect      AS effect,
  m.description AS mechanism,
  s.name        AS safer_alternative,
  i.reference   AS reference;


// ---------------------------------------------------------------
// Q2. DRUG RISK PROFILE — All interactions for a given drug, by severity
//     Use case: Provider reviews a patient's full medication risk before prescribing
// ---------------------------------------------------------------
MATCH (d:Drug {name: 'Warfarin'})-[:PARTICIPATES_IN]->(i:Interaction)<-[:PARTICIPATES_IN]-(other:Drug)
MATCH (i)-[:HAS_MECHANISM]->(m:Mechanism)
MATCH (i)-[:HAS_SAFER_ALTERNATIVE]->(s:SaferAlternative)
RETURN
  other.name    AS interacts_with,
  i.severity    AS severity,
  i.effect      AS effect,
  m.description AS mechanism,
  s.name        AS safer_alternative
ORDER BY
  CASE i.severity
    WHEN 'Major'    THEN 1
    WHEN 'Moderate' THEN 2
    WHEN 'Minor'    THEN 3
    ELSE 4
  END,
  other.name;


// ---------------------------------------------------------------
// Q3. POLYPHARMACY CHECK — Scan a patient medication list for ALL pairwise interactions
//     Use case: Clinical decision support for multi-drug regimens
// ---------------------------------------------------------------
WITH ['Warfarin', 'Ibuprofen', 'Omeprazole', 'Sertraline'] AS patient_meds
MATCH (a:Drug)-[:PARTICIPATES_IN]->(i:Interaction)<-[:PARTICIPATES_IN]-(b:Drug)
WHERE a.name IN patient_meds
  AND b.name IN patient_meds
  AND a.name < b.name          // avoid duplicate pairs
MATCH (i)-[:HAS_SAFER_ALTERNATIVE]->(s:SaferAlternative)
RETURN
  a.name     AS drug_a,
  b.name     AS drug_b,
  i.severity AS severity,
  i.effect   AS effect,
  s.name     AS safer_alternative
ORDER BY
  CASE i.severity
    WHEN 'Major'    THEN 1
    WHEN 'Moderate' THEN 2
    WHEN 'Minor'    THEN 3
    ELSE 4
  END;


// ---------------------------------------------------------------
// Q4. SEVERITY SUMMARY — Count of interactions per severity tier
//     Use case: Dashboard KPI / data quality validation
// ---------------------------------------------------------------
MATCH (i:Interaction)
RETURN
  i.severity    AS severity,
  count(i)      AS total_interactions
ORDER BY
  CASE i.severity
    WHEN 'Major'    THEN 1
    WHEN 'Moderate' THEN 2
    WHEN 'Minor'    THEN 3
    ELSE 4
  END;


// ---------------------------------------------------------------
// Q5. HIGH-RISK DRUGS — Which drugs appear most often in Major interactions?
//     Use case: Flag highest-risk medications for extra monitoring workflows
// ---------------------------------------------------------------
MATCH (d:Drug)-[:PARTICIPATES_IN]->(i:Interaction {severity: 'Major'})
RETURN
  d.name            AS drug,
  count(i)          AS major_interaction_count
ORDER BY major_interaction_count DESC
LIMIT 10;


// ---------------------------------------------------------------
// Q6. MECHANISM CLUSTERING — Which pharmacological mechanisms drive the most interactions?
//     Use case: Research / formulary committee insights
// ---------------------------------------------------------------
MATCH (i:Interaction)-[:HAS_MECHANISM]->(m:Mechanism)
RETURN
  m.description     AS mechanism,
  count(i)          AS interaction_count,
  collect(i.severity) AS severities
ORDER BY interaction_count DESC
LIMIT 15;


// ---------------------------------------------------------------
// Q7. SAFER ALTERNATIVE LOOKUP — Given an interacting pair, what is recommended?
//     Use case: Real-time prescribing alert with suggested substitute
// ---------------------------------------------------------------
MATCH (a:Drug {name: 'Simvastatin'})-[:PARTICIPATES_IN]->(i:Interaction)<-[:PARTICIPATES_IN]-(b:Drug {name: 'Clarithromycin'})
MATCH (i)-[:HAS_SAFER_ALTERNATIVE]->(s:SaferAlternative)
RETURN
  a.name          AS drug_a,
  b.name          AS drug_b,
  i.severity      AS severity,
  i.effect        AS effect,
  s.name          AS safer_alternative,
  s.rationale     AS rationale;


// ---------------------------------------------------------------
// Q8. SHARED ALTERNATIVES — Which safer alternatives cover the most interactions?
//     Use case: Identify go-to substitutes when building prescribing guidelines
// ---------------------------------------------------------------
MATCH (i:Interaction)-[:HAS_SAFER_ALTERNATIVE]->(s:SaferAlternative)
RETURN
  s.name             AS safer_alternative,
  count(i)           AS interactions_resolved,
  collect(DISTINCT i.severity) AS severity_levels_covered
ORDER BY interactions_resolved DESC
LIMIT 10;


// ---------------------------------------------------------------
// Q9. GRAPH PATHS — Find indirect connections (drugs sharing interaction partners)
//     Use case: Discover network-level risk clusters (e.g., Warfarin web)
// ---------------------------------------------------------------
MATCH path = (a:Drug {name: 'Warfarin'})-[:INTERACTS_WITH*1..2]-(b:Drug)
WHERE a <> b
RETURN
  b.name                    AS connected_drug,
  length(path)              AS degrees_of_separation,
  [n IN nodes(path) WHERE n:Drug | n.name] AS drug_path
ORDER BY degrees_of_separation, b.name
LIMIT 20;


// ---------------------------------------------------------------
// Q10. DATABASE STATS — Overall node and relationship counts
//      Use case: Verify seed loaded correctly / smoke test
// ---------------------------------------------------------------
MATCH (d:Drug)            WITH count(d) AS drugs
MATCH (i:Interaction)     WITH drugs, count(i) AS interactions
MATCH (m:Mechanism)       WITH drugs, interactions, count(m) AS mechanisms
MATCH (s:SaferAlternative)
RETURN
  drugs              AS total_drugs,
  interactions       AS total_interactions,
  mechanisms         AS total_mechanisms,
  count(s)           AS total_safer_alternatives;
