// =============================================================
//  DDI Graph — Classify Core Interactions Only
//  Sets mechanism_group + effect_polarity on 180 core edges
//  Matches edges by drug_a + drug_b + mechanism (source: 'core')
//  Safe to run on existing database — uses SET, no deletes
// =============================================================

// Chunk 1/2
UNWIND [
  {
    drug_a:          'Warfarin',
    drug_b:          'Ibuprofen',
    mechanism:       'Increased bleeding risk (antiplatelet effect, GI irritation)',
    mechanism_group: 'Haematological',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Simvastatin',
    drug_b:          'Clarithromycin',
    mechanism:       'CYP3A4 inhibition → increased statin levels → myopathy',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Sertraline',
    drug_b:          'Tramadol',
    mechanism:       'Increased serotonin levels',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Clopidogrel',
    drug_b:          'Omeprazole',
    mechanism:       'CYP2C19 inhibition → decreased clopidogrel efficacy',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Digoxin',
    drug_b:          'Verapamil',
    mechanism:       'P-gp inhibition → increased digoxin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Lithium',
    drug_b:          'Ibuprofen',
    mechanism:       'Decreased renal lithium clearance → increased lithium levels',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Codeine',
    drug_b:          'Paroxetine',
    mechanism:       'CYP2D6 inhibition → decreased conversion to morphine',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Theophylline',
    drug_b:          'Ciprofloxacin',
    mechanism:       'CYP1A2 inhibition → increased theophylline levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Rifampin',
    drug_b:          'Warfarin',
    mechanism:       'CYP induction → decreased warfarin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Sildenafil',
    drug_b:          'Nitroglycerin',
    mechanism:       'Profound hypotension',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Valproic Acid',
    drug_b:          'Lamotrigine',
    mechanism:       'Inhibits lamotrigine metabolism',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Fluconazole',
    mechanism:       'CYP2C9 inhibition → increased warfarin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Cyclosporine',
    drug_b:          'St. John\'s Wort',
    mechanism:       'CYP3A4 induction → decreased cyclosporine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Methotrexate',
    drug_b:          'Ibuprofen',
    mechanism:       'Decreased methotrexate renal excretion',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Citalopram',
    drug_b:          'Tamoxifen',
    mechanism:       'CYP2D6 inhibition → decreased conversion to active endoxifen',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Allopurinol',
    drug_b:          'Azathioprine',
    mechanism:       'XO inhibition → increased azathioprine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Sulfamethoxazole/Trimethoprim',
    mechanism:       'CYP2C9 inhibition + other mechanisms → increased warfarin effect',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Quetiapine',
    drug_b:          'Ketoconazole',
    mechanism:       'CYP3A4 inhibition → increased quetiapine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Ethinyl Estradiol',
    drug_b:          'Carbamazepine',
    mechanism:       'CYP induction → decreased contraceptive levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Amiodarone',
    mechanism:       'CYP2C9 inhibition → increased warfarin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Metformin',
    drug_b:          'Iodinated Contrast Dye',
    mechanism:       'Increased risk of contrast-induced lactic acidosis',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Tacrolimus',
    drug_b:          'Voriconazole',
    mechanism:       'CYP3A4 inhibition → increased tacrolimus levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Venlafaxine',
    drug_b:          'Tramadol',
    mechanism:       'Increased serotonin levels',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Colchicine',
    drug_b:          'Clarithromycin',
    mechanism:       'P-gp/CYP3A4 inhibition → increased colchicine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Duloxetine',
    drug_b:          'Tramadol',
    mechanism:       'Increased serotonin levels',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Fluoxetine',
    mechanism:       'CYP2C9 inhibition → increased warfarin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Lithium',
    drug_b:          'Hydrochlorothiazide',
    mechanism:       'Decreased renal lithium clearance → increased lithium levels',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Risperidone',
    drug_b:          'Carbamazepine',
    mechanism:       'CYP induction → decreased risperidone levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Salmeterol',
    drug_b:          'Propranolol',
    mechanism:       'Antagonism of bronchodilator effect',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Dextromethorphan',
    drug_b:          'Phenelzine',
    mechanism:       'Increased serotonin levels',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Paroxetine',
    drug_b:          'Tamoxifen',
    mechanism:       'CYP2D6 inhibition → decreased conversion to active endoxifen',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Atorvastatin',
    drug_b:          'Itraconazole',
    mechanism:       'CYP3A4 inhibition → increased statin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Levodopa',
    drug_b:          'Metoclopramide',
    mechanism:       'Dopamine receptor antagonism → decreased levodopa efficacy',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Sodium Valproate',
    drug_b:          'Meropenem',
    mechanism:       'Decreased valproate levels',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Linezolid',
    drug_b:          'Sertraline',
    mechanism:       'MAO inhibition + SSRI → increased serotonin levels',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Pimozide',
    drug_b:          'Clarithromycin',
    mechanism:       'CYP3A4 inhibition → increased pimozide levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Tizanidine',
    drug_b:          'Ciprofloxacin',
    mechanism:       'CYP1A2 inhibition → increased tizanidine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Thioridazine',
    drug_b:          'Paroxetine',
    mechanism:       'CYP2D6 inhibition → increased thioridazine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Donepezil',
    drug_b:          'Glycopyrrolate',
    mechanism:       'Pharmacodynamic antagonism',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Isotretinoin',
    drug_b:          'Tetracycline',
    mechanism:       'Increased risk of benign intracranial hypertension',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Rivaroxaban',
    drug_b:          'Carbamazepine',
    mechanism:       'CYP3A4/P-gp induction → decreased rivaroxaban levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Alfuzosin',
    drug_b:          'Ketoconazole',
    mechanism:       'CYP3A4 inhibition → increased alfuzosin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Phenelzine',
    drug_b:          'Meperidine',
    mechanism:       'Increased serotonin levels',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Sildenafil',
    drug_b:          'Ritonavir',
    mechanism:       'CYP3A4 inhibition → increased sildenafil levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Digoxin',
    drug_b:          'Quinidine',
    mechanism:       'P-gp inhibition → increased digoxin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Isosorbide Mononitrate',
    drug_b:          'Riociguat',
    mechanism:       'Additive hypotension',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Apixaban',
    mechanism:       'Additive anticoagulant effect',
    mechanism_group: 'Haematological',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Verapamil',
    drug_b:          'Atenolol',
    mechanism:       'Additive bradycardia and hypotension',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Dabigatran',
    mechanism:       'Additive anticoagulant effect',
    mechanism_group: 'Haematological',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Lithium',
    drug_b:          'ACE Inhibitors (e.g., Lisinopril)',
    mechanism:       'Decreased renal lithium clearance → increased lithium levels',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Clozapine',
    drug_b:          'Ciprofloxacin',
    mechanism:       'CYP1A2 inhibition → increased clozapine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Triamterene',
    drug_b:          'Indomethacin',
    mechanism:       'Increased risk of nephrotoxicity & hyperkalemia',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Fluoxetine',
    drug_b:          'Risperidone',
    mechanism:       'CYP2D6 inhibition → increased risperidone levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Methadone',
    drug_b:          'Phenytoin',
    mechanism:       'CYP induction → decreased methadone levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Tacrolimus',
    drug_b:          'St. John\'s Wort',
    mechanism:       'CYP3A4 induction → decreased tacrolimus levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Cisapride',
    drug_b:          'Erythromycin',
    mechanism:       'CYP3A4 inhibition → increased cisapride levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Bupropion',
    drug_b:          'Tamoxifen',
    mechanism:       'CYP2D6 inhibition → decreased conversion to active endoxifen',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Amiodarone',
    drug_b:          'Simvastatin',
    mechanism:       'CYP3A4 inhibition → increased statin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Imatinib',
    mechanism:       'CYP2C9 inhibition → increased warfarin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Duloxetine',
    drug_b:          'Linezolid',
    mechanism:       'MAO inhibition + SSRI → increased serotonin levels',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Rifampin',
    drug_b:          'Verapamil',
    mechanism:       'CYP induction → decreased verapamil levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Nafcillin',
    mechanism:       'CYP induction → decreased warfarin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Trimipramine',
    drug_b:          'Phenelzine',
    mechanism:       'Increased serotonin levels',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Atorvastatin',
    drug_b:          'Azithromycin',
    mechanism:       'Weak CYP3A4 inhibition may slightly increase atorvastatin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Sertraline',
    drug_b:          'Aspirin',
    mechanism:       'Increased antiplatelet effect',
    mechanism_group: 'Haematological',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Levothyroxine',
    drug_b:          'Iron Sulfate',
    mechanism:       'Binding in GI tract',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Metformin',
    drug_b:          'Cephalexin',
    mechanism:       'May increase metformin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Omeprazole',
    drug_b:          'Clopidogrel',
    mechanism:       'CYP2C19 inhibition may decrease clopidogrel efficacy',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Acetaminophen',
    mechanism:       'Regular high doses may increase INR',
    mechanism_group: 'Haematological',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Citalopram',
    drug_b:          'Tramadol',
    mechanism:       'Potential increased serotonin levels',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Amlodipine',
    drug_b:          'Simvastatin',
    mechanism:       'May slightly increase simvastatin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Digoxin',
    drug_b:          'Omeprazole',
    mechanism:       'May slightly increase digoxin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Venlafaxine',
    drug_b:          'Ibuprofen',
    mechanism:       'May increase risk of bleeding',
    mechanism_group: 'Haematological',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Lisinopril',
    drug_b:          'Spironolactone',
    mechanism:       'Additive hyperkalemia risk',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Metoprolol',
    drug_b:          'Diltiazem',
    mechanism:       'Additive effect on heart rate',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Quetiapine',
    drug_b:          'Lurasidone',
    mechanism:       'Additive CNS effects',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Duloxetine',
    drug_b:          'Meloxicam',
    mechanism:       'May increase risk of bleeding',
    mechanism_group: 'Haematological',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Alprazolam',
    drug_b:          'Cimetidine',
    mechanism:       'CYP3A4 inhibition may increase alprazolam levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Escitalopram',
    drug_b:          'Warfarin',
    mechanism:       'May increase INR',
    mechanism_group: 'Haematological',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Furosemide',
    drug_b:          'Lisinopril',
    mechanism:       'Potential for first-dose hypotension',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Gabapentin',
    drug_b:          'Hydrocodone',
    mechanism:       'Additive CNS depression',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Hydrochlorothiazide',
    drug_b:          'Ibuprofen',
    mechanism:       'NSAIDs may decrease diuretic efficacy',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Insulin',
    drug_b:          'Pramlintide',
    mechanism:       'Additive effect on glucose control',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Lamotrigine',
    drug_b:          'Valproic Acid',
    mechanism:       'Valproic acid inhibits lamotrigine metabolism',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Losartan',
    drug_b:          'Ibuprofen',
    mechanism:       'NSAIDs may decrease antihypertensive efficacy',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Memantine',
    drug_b:          'Carbonic Anhydrase Inhibitors',
    mechanism:       'May increase risk of renal stone formation',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Nitrofurantoin',
    drug_b:          'Magnesium Trisilicate',
    mechanism:       'Antacids may decrease nitrofurantoin absorption',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Olanzapine',
    drug_b:          'Diazepam',
    mechanism:       'Additive CNS depression',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Pantoprazole',
    drug_b:          'Warfarin',
    mechanism:       'May slightly increase INR',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Quetiapine',
    drug_b:          'Fluoxetine',
    mechanism:       'May increase quetiapine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Ranitidine',
    drug_b:          'Warfarin',
    mechanism:       'May slightly increase INR',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Sertraline',
    drug_b:          'Tolbutamide',
    mechanism:       'May increase tolbutamide levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Trazodone',
    drug_b:          'Phenytoin',
    mechanism:       'May alter levels of both drugs',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Valsartan',
    drug_b:          'Aliskiren',
    mechanism:       'Additive hyperkalemia risk',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Zolpidem',
    drug_b:          'Ciprofloxacin',
    mechanism:       'May increase zolpidem levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Amitriptyline',
    drug_b:          'Phenelzine',
    mechanism:       'Increased risk of serotonin syndrome',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Bupropion',
    drug_b:          'Levodopa',
    mechanism:       'May increase risk of hypertension and side effects',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Ciprofloxacin',
    drug_b:          'Theophylline',
    mechanism:       'CYP1A2 inhibition may increase theophylline levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Diclofenac',
    drug_b:          'Lithium',
    mechanism:       'May increase lithium levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Escitalopram',
    drug_b:          'Linezolid',
    mechanism:       'Potential increased risk of serotonin syndrome',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  }
] AS row
MATCH (a:Drug {name: row.drug_a})-[r:INTERACTS_WITH]-(b:Drug {name: row.drug_b})
WHERE r.mechanism = row.mechanism
  AND r.source = 'core'
SET r.mechanism_group = row.mechanism_group,
    r.effect_polarity  = row.effect_polarity;

// Chunk 2/2
UNWIND [
  {
    drug_a:          'Fluconazole',
    drug_b:          'Alfentanil',
    mechanism:       'May increase alfentanil levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Glipizide',
    drug_b:          'Fluconazole',
    mechanism:       'May increase glipizide levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Hydralazine',
    drug_b:          'Diazoxide',
    mechanism:       'Additive hypotensive effect',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Isoniazid',
    drug_b:          'Carbamazepine',
    mechanism:       'May increase carbamazepine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Levothyroxine',
    drug_b:          'Sucralfate',
    mechanism:       'Binding in GI tract',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Metronidazole',
    drug_b:          'Warfarin',
    mechanism:       'May increase INR',
    mechanism_group: 'Haematological',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Nifedipine',
    drug_b:          'Quinidine',
    mechanism:       'May increase quinidine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Oxcarbazepine',
    drug_b:          'Felodipine',
    mechanism:       'May decrease felodipine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Paroxetine',
    drug_b:          'Procyclidine',
    mechanism:       'May increase procyclidine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Quinine',
    drug_b:          'Digoxin',
    mechanism:       'May increase digoxin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Rifampin',
    drug_b:          'Verapamil',
    mechanism:       'CYP induction may decrease verapamil levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Salmeterol',
    drug_b:          'Timolol',
    mechanism:       'Antagonism of bronchodilator effect',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Telithromycin',
    drug_b:          'Midazolam',
    mechanism:       'CYP3A4 inhibition may increase midazolam levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Valproic Acid',
    drug_b:          'Meropenem',
    mechanism:       'May decrease valproic acid levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Dronedarone',
    mechanism:       'May increase INR',
    mechanism_group: 'Haematological',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Atenolol',
    drug_b:          'Diphenhydramine',
    mechanism:       'Additive sedative effects',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Cephalexin',
    drug_b:          'Metformin',
    mechanism:       'May slightly increase metformin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Codeine',
    drug_b:          'Chlorpromazine',
    mechanism:       'Additive CNS depression',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Diazepam',
    drug_b:          'Isoniazid',
    mechanism:       'May slightly increase diazepam levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Enalapril',
    drug_b:          'Amiloride',
    mechanism:       'Additive hyperkalemia risk',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Famotidine',
    drug_b:          'Cetirizine',
    mechanism:       'No significant interaction expected',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Guaifenesin',
    drug_b:          'Dextromethorphan',
    mechanism:       'No significant interaction expected',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Hydrocortisone',
    drug_b:          'Indapamide',
    mechanism:       'Additive hypokalemia risk',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Ibuprofen',
    drug_b:          'Pseudoephedrine',
    mechanism:       'No significant interaction expected',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Lactulose',
    drug_b:          'Electrolyte Supplements',
    mechanism:       'May alter electrolyte absorption',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Mupirocin',
    drug_b:          'Betamethasone',
    mechanism:       'No significant interaction expected',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Naproxen',
    drug_b:          'Penicillin VK',
    mechanism:       'No significant interaction expected',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Olopatadine',
    drug_b:          'Loratadine',
    mechanism:       'Additive anticholinergic effects',
    mechanism_group: 'CNS',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Pantoprazole',
    drug_b:          'Sucralfate',
    mechanism:       'May decrease absorption of PPI',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Quetiapine',
    drug_b:          'Ramipril',
    mechanism:       'Potential for additive hypotension',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Ranitidine',
    drug_b:          'Furosemide',
    mechanism:       'No significant interaction expected',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Sennosides',
    drug_b:          'Docusate',
    mechanism:       'No significant interaction expected',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Tetracycline',
    drug_b:          'Zinc Supplements',
    mechanism:       'Chelation; decreased absorption of both',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Ursodiol',
    drug_b:          'Cholestyramine',
    mechanism:       'Binds ursodiol; decreased efficacy',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Vitamin C',
    drug_b:          'Fluphenazine',
    mechanism:       'May decrease fluphenazine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Ginseng',
    mechanism:       'May decrease anticoagulant effect',
    mechanism_group: 'Haematological',
    effect_polarity: 'Beneficial'
  },
  {
    drug_a:          'Xylometazoline',
    drug_b:          'Phenylephrine',
    mechanism:       'Additive vasoconstrictive effects',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Zinc',
    drug_b:          'Ciprofloxacin',
    mechanism:       'Chelation; decreased ciprofloxacin absorption',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Amoxicillin',
    drug_b:          'Allopurinol',
    mechanism:       'Increased risk of amoxicillin rash',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Bisoprolol',
    drug_b:          'Rivastigmine',
    mechanism:       'Additive bradycardia risk',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Chlorthalidone',
    drug_b:          'Naproxen',
    mechanism:       'NSAIDs may decrease diuretic efficacy',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Doxycycline',
    drug_b:          'Barbiturates',
    mechanism:       'CYP induction may decrease doxycycline levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Erythromycin',
    drug_b:          'Bromocriptine',
    mechanism:       'May increase bromocriptine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Fluoxetine',
    drug_b:          'Perphenazine',
    mechanism:       'May increase perphenazine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Glyburide',
    drug_b:          'Colestipol',
    mechanism:       'Binds glyburide; decreased absorption',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Haloperidol',
    drug_b:          'Methyldopa',
    mechanism:       'Additive hypotensive effects',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Insulin',
    drug_b:          'Clonidine',
    mechanism:       'May decrease insulin secretion',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Ketoconazole',
    drug_b:          'Buspirone',
    mechanism:       'May increase buspirone levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Levofloxacin',
    drug_b:          'Didanosine',
    mechanism:       'Chelation with buffered didanosine',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Metoclopramide',
    drug_b:          'Levodopa',
    mechanism:       'Antagonizes levodopa\'s effect',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Nystatin',
    drug_b:          'Clotrimazole',
    mechanism:       'No significant interaction expected',
    mechanism_group: 'Pharmacodynamic — Other',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Omeprazole',
    drug_b:          'Ketoconazole',
    mechanism:       'Increased gastric pH may decrease ketoconazole absorption',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Phenytoin',
    drug_b:          'Pyridoxine',
    mechanism:       'May decrease phenytoin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Quetiapine',
    drug_b:          'Thioridazine',
    mechanism:       'Additive QT prolongation risk',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Risperidone',
    drug_b:          'Carbamazepine',
    mechanism:       'CYP induction may decrease risperidone levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Spironolactone',
    drug_b:          'Digoxin',
    mechanism:       'May slightly increase digoxin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Telmisartan',
    drug_b:          'Digoxin',
    mechanism:       'May slightly increase digoxin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Valaciclovir',
    drug_b:          'Cimetidine',
    mechanism:       'May increase valaciclovir levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Avocado',
    mechanism:       'Vitamin K content may decrease anticoagulant effect',
    mechanism_group: 'Haematological',
    effect_polarity: 'Beneficial'
  },
  {
    drug_a:          'Zafirlukast',
    drug_b:          'Theophylline',
    mechanism:       'May increase theophylline levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Alendronate',
    drug_b:          'Calcium Carbonate',
    mechanism:       'Binding; decreased alendronate absorption',
    mechanism_group: 'Pharmacokinetic — Absorption/Excretion',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Bumetanide',
    drug_b:          'Lithium',
    mechanism:       'Diuretic-induced sodium loss may increase lithium levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Cimetidine',
    drug_b:          'Metronidazole',
    mechanism:       'May increase metronidazole levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Diclofenac',
    drug_b:          'Colchicine',
    mechanism:       'May increase colchicine levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Esomeprazole',
    drug_b:          'Voriconazole',
    mechanism:       'May increase voriconazole levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Folic Acid',
    drug_b:          'Phenytoin',
    mechanism:       'May decrease phenytoin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Glimepiride',
    drug_b:          'Rifampin',
    mechanism:       'CYP induction may decrease glimepiride levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Hydroxychloroquine',
    drug_b:          'Digoxin',
    mechanism:       'May increase digoxin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Itraconazole',
    drug_b:          'Alprazolam',
    mechanism:       'May increase alprazolam levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Linagliptin',
    drug_b:          'Rifampin',
    mechanism:       'May slightly decrease linagliptin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Neutral/Variable'
  },
  {
    drug_a:          'Montelukast',
    drug_b:          'Gemfibrozil',
    mechanism:       'May increase montelukast levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Nitroglycerin',
    drug_b:          'Sildenafil',
    mechanism:       'Additive hypotensive effect (Major if taken within 24h)',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Ondansetron',
    drug_b:          'Apomorphine',
    mechanism:       'Additive hypotensive effect',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Propranolol',
    drug_b:          'Chlorpromazine',
    mechanism:       'May increase levels of both drugs',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Quinine',
    drug_b:          'Atorvastatin',
    mechanism:       'May increase atorvastatin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Rosuvastatin',
    drug_b:          'Fenofibrate',
    mechanism:       'Increased risk of myopathy',
    mechanism_group: 'Metabolic / Endocrine',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Sitagliptin',
    drug_b:          'Digoxin',
    mechanism:       'May slightly increase digoxin levels',
    mechanism_group: 'Pharmacokinetic — Enzyme',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Tamsulosin',
    drug_b:          'Tadalafil',
    mechanism:       'Additive hypotensive effect',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Vardenafil',
    drug_b:          'Nicardipine',
    mechanism:       'Additive hypotensive effect',
    mechanism_group: 'Cardiovascular',
    effect_polarity: 'Harmful'
  },
  {
    drug_a:          'Warfarin',
    drug_b:          'Ginkgo Biloba',
    mechanism:       'May increase bleeding risk',
    mechanism_group: 'Haematological',
    effect_polarity: 'Harmful'
  }
] AS row
MATCH (a:Drug {name: row.drug_a})-[r:INTERACTS_WITH]-(b:Drug {name: row.drug_b})
WHERE r.mechanism = row.mechanism
  AND r.source = 'core'
SET r.mechanism_group = row.mechanism_group,
    r.effect_polarity  = row.effect_polarity;

// ── Verify ───────────────────────────────────────────────────
// MATCH ()-[r:INTERACTS_WITH {source: 'core'}]->()
// RETURN r.mechanism_group AS group, r.effect_polarity AS polarity, count(r) AS total
// ORDER BY group, polarity;