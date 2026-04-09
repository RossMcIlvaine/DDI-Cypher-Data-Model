// =============================================================
//  DDI Graph Database — Schema Update: Diagnosis Nodes
//  Run AFTER 01_schema_v2.cypher (safe to run on existing DB)
// =============================================================

// ── Constraint: each Diagnosis node has a unique long_title ──
CREATE CONSTRAINT diagnosis_title_unique IF NOT EXISTS
  FOR (d:Diagnosis)
  REQUIRE d.long_title IS UNIQUE;

// ── Index: fast lookup by ICD code ───────────────────────────
CREATE INDEX diagnosis_icd_code IF NOT EXISTS
  FOR (d:Diagnosis)
  ON (d.icd_code);

// ── Full-text search across diagnosis titles ─────────────────
CREATE FULLTEXT INDEX diagnosis_title_fulltext IF NOT EXISTS
  FOR (n:Diagnosis)
  ON EACH [n.long_title];

// =============================================================
//  Updated data model (documentation)
//
//  EXISTING (unchanged):
//    (:Drug)-[:INTERACTS_WITH { severity, mechanism, effect,
//      safer_alt, rationale, reference, source }]->(:Drug)
//
//  NEW:
//    (:Drug)-[:ASSOCIATED_WITH {
//      admission_count          — unique admissions with this pair
//      avg_severity             — mean severity score
//      total_drug_admissions    — total admissions for this drug
//      pct_of_drug_admissions   — % of drug's admissions with this diagnosis
//      drug_label               — original drug name from source data
//    }]->(:Diagnosis)
//
//  (:Diagnosis)
//    - long_title  : string  — full diagnosis description (PK)
//    - icd_code    : string  — ICD code (may be shared across titles)
// =============================================================
