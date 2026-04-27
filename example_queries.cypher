// =============================================================
//  DDI Graph Database — Sample Queries (Full Schema)
//
//  Data model:
//    (:Drug)-[:INTERACTS_WITH {
//      severity, mechanism, effect, safer_alt, rationale,
//      reference, reference_url, source,
//      mechanism_group, effect_polarity
//    }]->(:Drug)
//
//    (:Drug)-[:ASSOCIATED_WITH {
//      admission_count, total_drug_admissions,
//      pct_of_drug_admissions, drug_labels
//    }]->(:Diagnosis)
//
// =============================================================


// ---------------------------------------------------------------
// Q1. FULL DRUG PROFILE
//     Everything known about a drug in one query:
//     interactions + diagnoses it appears in
// ---------------------------------------------------------------
MATCH (d:Drug {name: 'Warfarin'})

// Interactions
OPTIONAL MATCH (d)-[i:INTERACTS_WITH]-(other:Drug)

// Diagnoses
OPTIONAL MATCH (d)-[a:ASSOCIATED_WITH]->(diag:Diagnosis)

RETURN
  d.name                    AS drug,
  collect(DISTINCT {
    interacts_with:   other.name,
    severity:         i.severity,
    mechanism_group:  i.mechanism_group,
    effect_polarity:  i.effect_polarity,
    effect:           i.effect
  })                        AS interactions,
  collect(DISTINCT {
    diagnosis:        diag.long_title,
    icd_code:         diag.icd_code,
    admissions:       a.admission_count,
    pct:              a.pct_of_drug_admissions
  })                        AS diagnoses;


// ---------------------------------------------------------------
// Q2. DIAGNOSES MOST ASSOCIATED WITH A DRUG
//     Top diagnoses seen alongside a given drug in admissions,
//     ranked by admission count
// ---------------------------------------------------------------
MATCH (d:Drug {name: 'Warfarin'})-[a:ASSOCIATED_WITH]->(diag:Diagnosis)
RETURN
  diag.long_title             AS diagnosis,
  diag.icd_code               AS icd_code,
  a.admission_count           AS admissions,
  a.pct_of_drug_admissions    AS pct_of_drug_admissions
ORDER BY a.admission_count DESC
LIMIT 15;


// ---------------------------------------------------------------
// Q3. DRUGS MOST ASSOCIATED WITH A DIAGNOSIS
//     Which drugs appear most in admissions for a given diagnosis
// ---------------------------------------------------------------
MATCH (d:Drug)-[a:ASSOCIATED_WITH]->(diag:Diagnosis)
WHERE toLower(diag.long_title) CONTAINS toLower('hypertension')
RETURN
  d.name                      AS drug,
  diag.long_title             AS diagnosis,
  a.admission_count           AS admissions,
  a.pct_of_drug_admissions    AS pct_of_admissions
ORDER BY a.admission_count DESC
LIMIT 20;


// ---------------------------------------------------------------
// Q4. INTERACTION RISK + DIAGNOSIS CONTEXT
//     For a drug pair with a known interaction, show what
//     diagnoses each drug is commonly associated with —
//     useful for understanding real-world co-prescribing context
// ---------------------------------------------------------------
MATCH (a:Drug {name: 'Warfarin'})-[i:INTERACTS_WITH]-(b:Drug {name: 'Aspirin'})
OPTIONAL MATCH (a)-[aa:ASSOCIATED_WITH]->(da:Diagnosis)
OPTIONAL MATCH (b)-[ab:ASSOCIATED_WITH]->(db:Diagnosis)
RETURN
  i.severity                  AS severity,
  i.mechanism_group           AS mechanism_group,
  i.effect_polarity           AS effect_polarity,
  i.effect                    AS effect,
  i.safer_alt                 AS safer_alternative,
  i.reference                 AS reference,
  i.reference_url             AS reference_url,
  collect(DISTINCT {diagnosis: da.long_title, admissions: aa.admission_count})[..5]
                              AS top_warfarin_diagnoses,
  collect(DISTINCT {diagnosis: db.long_title, admissions: ab.admission_count})[..5]
                              AS top_aspirin_diagnoses;


// ---------------------------------------------------------------
// Q5. HARMFUL MAJOR INTERACTIONS BY MECHANISM GROUP
//     Breakdown of Major + Harmful interactions grouped by
//     pharmacological class — useful for formulary review
// ---------------------------------------------------------------
MATCH (a:Drug)-[r:INTERACTS_WITH]->(b:Drug)
WHERE r.severity        = 'Major'
  AND r.effect_polarity = 'Harmful'
RETURN
  r.mechanism_group             AS mechanism_group,
  count(r)                      AS interaction_count,
  collect(DISTINCT a.name)[..5] AS example_drugs
ORDER BY interaction_count DESC;


// ---------------------------------------------------------------
// Q6. POLYPHARMACY CHECK WITH MECHANISM CONTEXT
//     Check a patient's medication list for all pairwise
//     interactions, including mechanism group and polarity
// ---------------------------------------------------------------
WITH ['Warfarin', 'Aspirin', 'Omeprazole', 'Sertraline', 'Simvastatin'] AS meds
MATCH (a:Drug)-[r:INTERACTS_WITH]-(b:Drug)
WHERE a.name IN meds
  AND b.name IN meds
  AND a.name < b.name
RETURN
  a.name              AS drug_a,
  b.name              AS drug_b,
  r.severity          AS severity,
  r.mechanism_group   AS mechanism_group,
  r.effect_polarity   AS effect_polarity,
  r.effect            AS effect,
  r.safer_alt         AS safer_alternative
ORDER BY
  CASE r.severity
    WHEN 'Major'    THEN 1
    WHEN 'Moderate' THEN 2
    WHEN 'Minor'    THEN 3
    ELSE 4
  END,
  CASE r.effect_polarity
    WHEN 'Harmful'          THEN 1
    WHEN 'Neutral/Variable' THEN 2
    WHEN 'Beneficial'       THEN 3
    ELSE 4
  END;


// ---------------------------------------------------------------
// Q7. SHARED DIAGNOSES BETWEEN TWO INTERACTING DRUGS
//     Find diagnoses that appear in admissions for BOTH drugs —
//     these patients are at highest real-world co-exposure risk
// ---------------------------------------------------------------
MATCH (a:Drug {name: 'Warfarin'})-[i:INTERACTS_WITH]-(b:Drug {name: 'Aspirin'})
MATCH (a)-[aa:ASSOCIATED_WITH]->(diag:Diagnosis)<-[ab:ASSOCIATED_WITH]-(b)
RETURN
  diag.long_title             AS shared_diagnosis,
  diag.icd_code               AS icd_code,
  aa.admission_count          AS warfarin_admissions,
  ab.admission_count          AS aspirin_admissions,
  i.severity                  AS interaction_severity,
  i.effect_polarity           AS effect_polarity
ORDER BY (aa.admission_count + ab.admission_count) DESC
LIMIT 15;


// ---------------------------------------------------------------
// Q8. HIGH-RISK DIAGNOSIS CLUSTERS
//     Diagnoses where the associated drugs have the most
//     Major interactions between them — identifies clinical
//     scenarios with highest polypharmacy interaction risk
// ---------------------------------------------------------------
MATCH (d:Drug)-[:ASSOCIATED_WITH]->(diag:Diagnosis)
WITH diag, collect(d) AS drugs
UNWIND drugs AS drugA
UNWIND drugs AS drugB
WITH diag, drugA, drugB
WHERE drugA.name < drugB.name
MATCH (drugA)-[r:INTERACTS_WITH]-(drugB)
WHERE r.severity = 'Major'
RETURN
  diag.long_title               AS diagnosis,
  count(r)                      AS major_interactions_among_associated_drugs,
  collect(drugA.name + ' ↔ ' + drugB.name)[..5] AS example_pairs
ORDER BY major_interactions_among_associated_drugs DESC
LIMIT 15;


// ---------------------------------------------------------------
// Q9. BENEFICIAL INTERACTIONS
//     All interactions classified as Beneficial —
//     useful for identifying protective drug combinations
// ---------------------------------------------------------------
MATCH (a:Drug)-[r:INTERACTS_WITH]->(b:Drug)
WHERE r.effect_polarity = 'Beneficial'
RETURN
  a.name              AS drug_a,
  b.name              AS drug_b,
  r.severity          AS severity,
  r.mechanism_group   AS mechanism_group,
  r.effect            AS effect,
  r.reference         AS reference,
  r.reference_url     AS reference_url
ORDER BY r.mechanism_group, a.name;


// ---------------------------------------------------------------
// Q10. DRUGS WITH BOTH HIGH INTERACTION BURDEN AND
//      HIGH ADMISSION VOLUME
//      Identifies the highest clinical-priority drugs:
//      commonly prescribed AND heavily interacting
// ---------------------------------------------------------------
MATCH (d:Drug)-[a:ASSOCIATED_WITH]->(diag:Diagnosis)
WITH d, sum(a.admission_count) AS total_admissions

MATCH (d)-[r:INTERACTS_WITH]-(other:Drug)
WITH d, total_admissions,
     count(r)                                           AS total_interactions,
     count(CASE r.severity WHEN 'Major' THEN 1 END)    AS major_interactions,
     count(CASE r.effect_polarity WHEN 'Harmful' THEN 1 END) AS harmful_interactions

RETURN
  d.name              AS drug,
  total_admissions,
  total_interactions,
  major_interactions,
  harmful_interactions
ORDER BY major_interactions DESC, total_admissions DESC
LIMIT 20;


// ---------------------------------------------------------------
// Q11. MECHANISM GROUP SUMMARY ACROSS FULL DATABASE
//      Count of interactions per group + polarity —
//      good for a dashboard overview
// ---------------------------------------------------------------
MATCH ()-[r:INTERACTS_WITH]->()
WHERE r.mechanism_group IS NOT NULL
RETURN
  r.mechanism_group             AS mechanism_group,
  r.effect_polarity             AS effect_polarity,
  count(r)                      AS total_interactions
ORDER BY mechanism_group, effect_polarity;


// ---------------------------------------------------------------
// Q12. SAFER ALTERNATIVE LOOKUP WITH DIAGNOSIS CONTEXT
//      Given an interacting pair, show the safer alternative
//      AND check whether that alternative also appears in
//      admissions for the same diagnoses
// ---------------------------------------------------------------
MATCH (a:Drug {name: 'Simvastatin'})-[r:INTERACTS_WITH]-(b:Drug {name: 'Clarithromycin'})
OPTIONAL MATCH (alt:Drug {name: r.safer_alt})
OPTIONAL MATCH (a)-[aa:ASSOCIATED_WITH]->(diag:Diagnosis)<-[alta:ASSOCIATED_WITH]-(alt)
RETURN
  a.name              AS drug_a,
  b.name              AS drug_b,
  r.severity          AS severity,
  r.effect            AS effect,
  r.safer_alt         AS safer_alternative,
  r.rationale         AS rationale,
  r.reference         AS reference,
  r.reference_url     AS reference_url,
  collect(DISTINCT {
    diagnosis:        diag.long_title,
    alt_admissions:   alta.admission_count
  })[..5]             AS alternative_also_seen_in;


// ---------------------------------------------------------------
// Q13. DATABASE STATS — Full smoke test
// ---------------------------------------------------------------
MATCH (d:Drug)              WITH count(d)  AS drugs
MATCH (dx:Diagnosis)        WITH drugs, count(dx) AS diagnoses
MATCH ()-[i:INTERACTS_WITH]->()
WITH drugs, diagnoses,
     count(i)                                             AS total_interactions,
     count(CASE i.source WHEN 'core' THEN 1 END)         AS core_interactions,
     count(CASE i.source WHEN 'expanded' THEN 1 END)     AS expanded_interactions,
     count(i.mechanism_group)                             AS classified_interactions,
     count(i.reference_url)                               AS interactions_with_url
MATCH ()-[a:ASSOCIATED_WITH]->()
RETURN
  drugs,
  diagnoses,
  total_interactions,
  core_interactions,
  expanded_interactions,
  classified_interactions,
  interactions_with_url,
  count(a) AS diagnosis_edges;
