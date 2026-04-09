// =============================================================
//  DDI Graph Database — Schema v2 (Edge-only model)
//  
//  Data model:
//    (:Drug)-[:INTERACTS_WITH { all properties }]->(:Drug)
//
//  All interaction data (severity, mechanism, effect,
//  safer_alt, rationale, reference) lives on the edge.
//  No Interaction, Mechanism, or SaferAlternative nodes.
//
//  Run this BEFORE loading any seed data.
//  If migrating from v1: DROP all old constraints/indexes first.
// =============================================================

// ---------------------------------------------------------------
// 1. DROP v1 constraints + indexes (safe to run even if absent)
// ---------------------------------------------------------------
DROP CONSTRAINT interaction_id_unique       IF EXISTS;
DROP CONSTRAINT mechanism_unique            IF EXISTS;
DROP CONSTRAINT safer_alt_unique            IF EXISTS;
DROP INDEX      interaction_severity        IF EXISTS;
DROP INDEX      interaction_effect_fulltext IF EXISTS;
DROP INDEX      mechanism_fulltext          IF EXISTS;

// ---------------------------------------------------------------
// 2. CONSTRAINTS
// ---------------------------------------------------------------

CREATE CONSTRAINT drug_name_unique IF NOT EXISTS
  FOR (d:Drug)
  REQUIRE d.name IS UNIQUE;

// ---------------------------------------------------------------
// 3. INDEXES
// ---------------------------------------------------------------

CREATE FULLTEXT INDEX drug_name_fulltext IF NOT EXISTS
  FOR (n:Drug)
  ON EACH [n.name];

// ---------------------------------------------------------------
// 4. DATA MODEL  (documentation)
// ---------------------------------------------------------------
//
//  (:Drug)
//    - name         : string  — canonical drug name (PK)
//
//  [:INTERACTS_WITH]
//    - severity     : string  — "Major" | "Moderate" | "Minor"
//    - mechanism    : string  — pharmacological mechanism
//    - effect       : string  — clinical consequence
//    - safer_alt    : string  — recommended safer alternative
//    - rationale    : string  — why the alternative is safer
//    - reference    : string  — source citation
//    - source       : string  — "core" | "expanded" (dataset provenance)
//
//  Relationships are stored directed (drug_a -> drug_b).
//  Use MATCH (a)-[:INTERACTS_WITH]-(b) (undirected) when
//  direction doesn't matter.
//
// =============================================================
