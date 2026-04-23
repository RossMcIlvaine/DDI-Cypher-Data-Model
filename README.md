# DDI-Cypher-Data-Model
Building data model for capstone DDI graph database

# Neo4J Instructions for Core Dataset
1. Run the schema files first to establish database schema.
2. Run seed_drugs.cypher and seed_diagnoses.cypher to populate the database with drugs and diagnoses data, respectively.

# Optional
* classify_interactions groups the interaction mechanisms into 7 main categories
* update_references adds a new reference_url property that links to the source website or text if it exists online
