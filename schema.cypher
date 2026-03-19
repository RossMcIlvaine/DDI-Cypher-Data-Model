// =============================================================
//  DDI Graph Database — Schema & Constraints
//  Target: Neo4j AuraDB
//  Run this FIRST before loading any data
// =============================================================

// ---------------------------------------------------------------
// 1. CONSTRAINTS
//    Enforce uniqueness and create backing indexes automatically
// ---------------------------------------------------------------

// Every Drug node must have a unique name
CREATE CONSTRAINT drug_name_unique IF NOT EXISTS
  FOR (d:Drug)
  REQUIRE d.name IS UNIQUE;

// Every Interaction node must have a unique id
CREATE CONSTRAINT interaction_id_unique IF NOT EXISTS
  FOR (i:Interaction)
  REQUIRE i.id IS UNIQUE;

// Every Mechanism node must have a unique description
CREATE CONSTRAINT mechanism_unique IF NOT EXISTS
  FOR (m:Mechanism)
  REQUIRE m.description IS UNIQUE;

// Every SaferAlternative node must have a unique name
CREATE CONSTRAINT safer_alt_unique IF NOT EXISTS
  FOR (s:SaferAlternative)
  REQUIRE s.name IS UNIQUE;

// ---------------------------------------------------------------
// 2. INDEXES
//    Speed up common lookup patterns
// ---------------------------------------------------------------

// Look up interactions by severity level
CREATE INDEX interaction_severity IF NOT EXISTS
  FOR (i:Interaction)
  ON (i.severity);

// Full-text search across drug names (supports fuzzy / partial matching)
CREATE FULLTEXT INDEX drug_name_fulltext IF NOT EXISTS
  FOR (d:Drug)
  ON EACH [d.name];

// Full-text search across interaction effects
CREATE FULLTEXT INDEX interaction_effect_fulltext IF NOT EXISTS
  FOR (i:Interaction)
  ON EACH [i.effect];

// Full-text search across mechanism descriptions
CREATE FULLTEXT INDEX mechanism_fulltext IF NOT EXISTS
  FOR (m:Mechanism)
  ON EACH [m.description];

// ---------------------------------------------------------------
// 3. NODE LABELS & PROPERTY CONTRACTS  (documentation only)
//    These comments describe the model
// ---------------------------------------------------------------
//
//  (:Drug)
//    - name        : string  — canonical drug name (PK)
//
//  (:Interaction)
//    - id          : string  — "<drug_a>|<drug_b>|<severity>"
//    - severity    : string  — "Major" | "Moderate" | "Minor"
//    - effect      : string  — clinical consequence description
//    - reference   : string  — source citation(s)
//
//  (:Mechanism)
//    - description : string  — pharmacokinetic/dynamic explanation
//
//  (:SaferAlternative)
//    - name        : string  — suggested replacement drug(s)
//    - rationale   : string  — reason this alternative is safer
//
// ---------------------------------------------------------------
// 4. RELATIONSHIP TYPES  (documentation only)
// ---------------------------------------------------------------
//
//  (:Drug)-[:INTERACTS_WITH {severity, effect, reference}]->(:Drug)
//    Direct labeled edge for fast pair lookups (bidirectional intent,
//    stored as directed for query convenience).
//
//  (:Drug)-[:PARTICIPATES_IN]->(:Interaction)
//    Links both drugs to the shared Interaction node.
//
//  (:Interaction)-[:HAS_MECHANISM]->(:Mechanism)
//    Links an interaction to its pharmacological mechanism.
//
//  (:Interaction)-[:HAS_SAFER_ALTERNATIVE]->(:SaferAlternative)
//    Links an interaction to the recommended replacement.
//
// =============================================================
