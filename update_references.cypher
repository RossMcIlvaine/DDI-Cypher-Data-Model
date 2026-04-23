// =============================================================
//  DDI Graph — Add reference_url property (core dataset only)
//  Keeps existing 'reference' text unchanged.
//  Adds 'reference_url' with a hyperlink where one exists,
//  or an empty string if no public URL is available.
//  Matches edges by drug_a + drug_b + mechanism + source='core'
//  Safe to run on existing database — uses SET only
// =============================================================

// Chunk 1/2
UNWIND [
  {
    drug_a:        'Warfarin',
    drug_b:        'Ibuprofen',
    mechanism:     'Increased bleeding risk (antiplatelet effect, GI irritation)',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Simvastatin',
    drug_b:        'Clarithromycin',
    mechanism:     'CYP3A4 inhibition → increased statin levels → myopathy',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Sertraline',
    drug_b:        'Tramadol',
    mechanism:     'Increased serotonin levels',
    reference_url: 'https://www.fda.gov/drugs/questions-and-answers-fdas-adverse-event-reporting-system-faers'
  },
  {
    drug_a:        'Clopidogrel',
    drug_b:        'Omeprazole',
    mechanism:     'CYP2C19 inhibition → decreased clopidogrel efficacy',
    reference_url: 'https://link.springer.com/journal/40262'
  },
  {
    drug_a:        'Digoxin',
    drug_b:        'Verapamil',
    mechanism:     'P-gp inhibition → increased digoxin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Lithium',
    drug_b:        'Ibuprofen',
    mechanism:     'Decreased renal lithium clearance → increased lithium levels',
    reference_url: 'https://onlinelibrary.wiley.com/journal/16000447'
  },
  {
    drug_a:        'Codeine',
    drug_b:        'Paroxetine',
    mechanism:     'CYP2D6 inhibition → decreased conversion to morphine',
    reference_url: 'https://ascpt.onlinelibrary.wiley.com/journal/15326535'
  },
  {
    drug_a:        'Theophylline',
    drug_b:        'Ciprofloxacin',
    mechanism:     'CYP1A2 inhibition → increased theophylline levels',
    reference_url: 'https://journal.chestnet.org'
  },
  {
    drug_a:        'Rifampin',
    drug_b:        'Warfarin',
    mechanism:     'CYP induction → decreased warfarin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Sildenafil',
    drug_b:        'Nitroglycerin',
    mechanism:     'Profound hypotension',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Valproic Acid',
    drug_b:        'Lamotrigine',
    mechanism:     'Inhibits lamotrigine metabolism',
    reference_url: 'https://onlinelibrary.wiley.com/journal/15281167'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Fluconazole',
    mechanism:     'CYP2C9 inhibition → increased warfarin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Cyclosporine',
    drug_b:        'St. John\'s Wort',
    mechanism:     'CYP3A4 induction → decreased cyclosporine levels',
    reference_url: 'https://jamanetwork.com/journals/jama'
  },
  {
    drug_a:        'Methotrexate',
    drug_b:        'Ibuprofen',
    mechanism:     'Decreased methotrexate renal excretion',
    reference_url: 'https://onlinelibrary.wiley.com/journal/15290131'
  },
  {
    drug_a:        'Citalopram',
    drug_b:        'Tamoxifen',
    mechanism:     'CYP2D6 inhibition → decreased conversion to active endoxifen',
    reference_url: 'https://ascopubs.org/journal/jco'
  },
  {
    drug_a:        'Allopurinol',
    drug_b:        'Azathioprine',
    mechanism:     'XO inhibition → increased azathioprine levels',
    reference_url: 'https://ard.bmj.com'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Sulfamethoxazole/Trimethoprim',
    mechanism:     'CYP2C9 inhibition + other mechanisms → increased warfarin effect',
    reference_url: 'https://jamanetwork.com/journals/jamainternalmedicine'
  },
  {
    drug_a:        'Quetiapine',
    drug_b:        'Ketoconazole',
    mechanism:     'CYP3A4 inhibition → increased quetiapine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Ethinyl Estradiol',
    drug_b:        'Carbamazepine',
    mechanism:     'CYP induction → decreased contraceptive levels',
    reference_url: 'https://www.contraceptionjournal.org'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Amiodarone',
    mechanism:     'CYP2C9 inhibition → increased warfarin levels',
    reference_url: 'https://www.nejm.org'
  },
  {
    drug_a:        'Metformin',
    drug_b:        'Iodinated Contrast Dye',
    mechanism:     'Increased risk of contrast-induced lactic acidosis',
    reference_url: ''
  },
  {
    drug_a:        'Tacrolimus',
    drug_b:        'Voriconazole',
    mechanism:     'CYP3A4 inhibition → increased tacrolimus levels',
    reference_url: 'https://journals.lww.com/drug-monitoring/pages/default.aspx'
  },
  {
    drug_a:        'Venlafaxine',
    drug_b:        'Tramadol',
    mechanism:     'Increased serotonin levels',
    reference_url: 'https://link.springer.com/journal/40263'
  },
  {
    drug_a:        'Colchicine',
    drug_b:        'Clarithromycin',
    mechanism:     'P-gp/CYP3A4 inhibition → increased colchicine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Duloxetine',
    drug_b:        'Tramadol',
    mechanism:     'Increased serotonin levels',
    reference_url: 'https://www.fda.gov/drugs/questions-and-answers-fdas-adverse-event-reporting-system-faers'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Fluoxetine',
    mechanism:     'CYP2C9 inhibition → increased warfarin levels',
    reference_url: 'https://www.bmj.com'
  },
  {
    drug_a:        'Lithium',
    drug_b:        'Hydrochlorothiazide',
    mechanism:     'Decreased renal lithium clearance → increased lithium levels',
    reference_url: 'https://ajp.psychiatryonline.org'
  },
  {
    drug_a:        'Risperidone',
    drug_b:        'Carbamazepine',
    mechanism:     'CYP induction → decreased risperidone levels',
    reference_url: 'https://journals.lww.com/psychopharmacology/pages/default.aspx'
  },
  {
    drug_a:        'Salmeterol',
    drug_b:        'Propranolol',
    mechanism:     'Antagonism of bronchodilator effect',
    reference_url: 'https://www.atsjournals.org/journal/ajrccm'
  },
  {
    drug_a:        'Dextromethorphan',
    drug_b:        'Phenelzine',
    mechanism:     'Increased serotonin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Paroxetine',
    drug_b:        'Tamoxifen',
    mechanism:     'CYP2D6 inhibition → decreased conversion to active endoxifen',
    reference_url: 'https://academic.oup.com/jnci'
  },
  {
    drug_a:        'Atorvastatin',
    drug_b:        'Itraconazole',
    mechanism:     'CYP3A4 inhibition → increased statin levels',
    reference_url: 'https://ascpt.onlinelibrary.wiley.com/journal/15326535'
  },
  {
    drug_a:        'Levodopa',
    drug_b:        'Metoclopramide',
    mechanism:     'Dopamine receptor antagonism → decreased levodopa efficacy',
    reference_url: 'https://movementdisorders.onlinelibrary.wiley.com/journal/15318257'
  },
  {
    drug_a:        'Sodium Valproate',
    drug_b:        'Meropenem',
    mechanism:     'Decreased valproate levels',
    reference_url: 'https://www.sciencedirect.com/journal/epilepsy-and-behavior'
  },
  {
    drug_a:        'Linezolid',
    drug_b:        'Sertraline',
    mechanism:     'MAO inhibition + SSRI → increased serotonin levels',
    reference_url: 'https://www.fda.gov/safety/medwatch-fda-safety-information-and-adverse-event-reporting-program'
  },
  {
    drug_a:        'Pimozide',
    drug_b:        'Clarithromycin',
    mechanism:     'CYP3A4 inhibition → increased pimozide levels',
    reference_url: 'https://www.fda.gov/drugs/drug-safety-and-availability/drug-safety-communications'
  },
  {
    drug_a:        'Tizanidine',
    drug_b:        'Ciprofloxacin',
    mechanism:     'CYP1A2 inhibition → increased tizanidine levels',
    reference_url: 'https://ascpt.onlinelibrary.wiley.com/journal/15326535'
  },
  {
    drug_a:        'Thioridazine',
    drug_b:        'Paroxetine',
    mechanism:     'CYP2D6 inhibition → increased thioridazine levels',
    reference_url: 'https://www.fda.gov/drugs/drug-safety-and-availability/drug-safety-communications'
  },
  {
    drug_a:        'Donepezil',
    drug_b:        'Glycopyrrolate',
    mechanism:     'Pharmacodynamic antagonism',
    reference_url: 'https://agsjournals.onlinelibrary.wiley.com/journal/15325415'
  },
  {
    drug_a:        'Isotretinoin',
    drug_b:        'Tetracycline',
    mechanism:     'Increased risk of benign intracranial hypertension',
    reference_url: 'https://www.jaad.org'
  },
  {
    drug_a:        'Rivaroxaban',
    drug_b:        'Carbamazepine',
    mechanism:     'CYP3A4/P-gp induction → decreased rivaroxaban levels',
    reference_url: 'https://onlinelibrary.wiley.com/journal/15387836'
  },
  {
    drug_a:        'Alfuzosin',
    drug_b:        'Ketoconazole',
    mechanism:     'CYP3A4 inhibition → increased alfuzosin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Phenelzine',
    drug_b:        'Meperidine',
    mechanism:     'Increased serotonin levels',
    reference_url: 'https://www.sciencedirect.com/journal/psychosomatics'
  },
  {
    drug_a:        'Sildenafil',
    drug_b:        'Ritonavir',
    mechanism:     'CYP3A4 inhibition → increased sildenafil levels',
    reference_url: 'https://www.fda.gov/drugs/drug-approvals-and-databases/drugs-fda-data-files'
  },
  {
    drug_a:        'Digoxin',
    drug_b:        'Quinidine',
    mechanism:     'P-gp inhibition → increased digoxin levels',
    reference_url: ''
  },
  {
    drug_a:        'Isosorbide Mononitrate',
    drug_b:        'Riociguat',
    mechanism:     'Additive hypotension',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Apixaban',
    mechanism:     'Additive anticoagulant effect',
    reference_url: ''
  },
  {
    drug_a:        'Verapamil',
    drug_b:        'Atenolol',
    mechanism:     'Additive bradycardia and hypotension',
    reference_url: 'https://www.ajconline.org'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Dabigatran',
    mechanism:     'Additive anticoagulant effect',
    reference_url: ''
  },
  {
    drug_a:        'Lithium',
    drug_b:        'ACE Inhibitors (e.g., Lisinopril)',
    mechanism:     'Decreased renal lithium clearance → increased lithium levels',
    reference_url: 'https://ajp.psychiatryonline.org'
  },
  {
    drug_a:        'Clozapine',
    drug_b:        'Ciprofloxacin',
    mechanism:     'CYP1A2 inhibition → increased clozapine levels',
    reference_url: 'https://www.psychiatrist.com/jcp'
  },
  {
    drug_a:        'Triamterene',
    drug_b:        'Indomethacin',
    mechanism:     'Increased risk of nephrotoxicity & hyperkalemia',
    reference_url: 'https://www.bmj.com'
  },
  {
    drug_a:        'Fluoxetine',
    drug_b:        'Risperidone',
    mechanism:     'CYP2D6 inhibition → increased risperidone levels',
    reference_url: 'https://journals.lww.com/psychopharmacology/pages/default.aspx'
  },
  {
    drug_a:        'Methadone',
    drug_b:        'Phenytoin',
    mechanism:     'CYP induction → decreased methadone levels',
    reference_url: 'https://jamanetwork.com/journals/jama'
  },
  {
    drug_a:        'Tacrolimus',
    drug_b:        'St. John\'s Wort',
    mechanism:     'CYP3A4 induction → decreased tacrolimus levels',
    reference_url: 'https://journals.lww.com/transplantjournal/pages/default.aspx'
  },
  {
    drug_a:        'Cisapride',
    drug_b:        'Erythromycin',
    mechanism:     'CYP3A4 inhibition → increased cisapride levels',
    reference_url: 'https://www.fda.gov/drugs/drug-safety-and-availability/drug-safety-communications'
  },
  {
    drug_a:        'Bupropion',
    drug_b:        'Tamoxifen',
    mechanism:     'CYP2D6 inhibition → decreased conversion to active endoxifen',
    reference_url: 'https://ascopubs.org/journal/jco'
  },
  {
    drug_a:        'Amiodarone',
    drug_b:        'Simvastatin',
    mechanism:     'CYP3A4 inhibition → increased statin levels',
    reference_url: 'https://www.ahajournals.org/journal/circ'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Imatinib',
    mechanism:     'CYP2C9 inhibition → increased warfarin levels',
    reference_url: 'https://ascopubs.org/journal/jco'
  },
  {
    drug_a:        'Duloxetine',
    drug_b:        'Linezolid',
    mechanism:     'MAO inhibition + SSRI → increased serotonin levels',
    reference_url: 'https://www.fda.gov/safety/medwatch-fda-safety-information-and-adverse-event-reporting-program'
  },
  {
    drug_a:        'Rifampin',
    drug_b:        'Verapamil',
    mechanism:     'CYP induction → decreased verapamil levels',
    reference_url: 'https://ascpt.onlinelibrary.wiley.com/journal/15326535'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Nafcillin',
    mechanism:     'CYP induction → decreased warfarin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Trimipramine',
    drug_b:        'Phenelzine',
    mechanism:     'Increased serotonin levels',
    reference_url: 'https://link.springer.com/journal/213'
  },
  {
    drug_a:        'Atorvastatin',
    drug_b:        'Azithromycin',
    mechanism:     'Weak CYP3A4 inhibition may slightly increase atorvastatin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Sertraline',
    drug_b:        'Aspirin',
    mechanism:     'Increased antiplatelet effect',
    reference_url: ''
  },
  {
    drug_a:        'Levothyroxine',
    drug_b:        'Iron Sulfate',
    mechanism:     'Binding in GI tract',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Metformin',
    drug_b:        'Cephalexin',
    mechanism:     'May increase metformin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Omeprazole',
    drug_b:        'Clopidogrel',
    mechanism:     'CYP2C19 inhibition may decrease clopidogrel efficacy',
    reference_url: 'https://link.springer.com/journal/40262'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Acetaminophen',
    mechanism:     'Regular high doses may increase INR',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Citalopram',
    drug_b:        'Tramadol',
    mechanism:     'Potential increased serotonin levels',
    reference_url: 'https://www.fda.gov/drugs/questions-and-answers-fdas-adverse-event-reporting-system-faers'
  },
  {
    drug_a:        'Amlodipine',
    drug_b:        'Simvastatin',
    mechanism:     'May slightly increase simvastatin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Digoxin',
    drug_b:        'Omeprazole',
    mechanism:     'May slightly increase digoxin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Venlafaxine',
    drug_b:        'Ibuprofen',
    mechanism:     'May increase risk of bleeding',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Lisinopril',
    drug_b:        'Spironolactone',
    mechanism:     'Additive hyperkalemia risk',
    reference_url: ''
  },
  {
    drug_a:        'Metoprolol',
    drug_b:        'Diltiazem',
    mechanism:     'Additive effect on heart rate',
    reference_url: 'https://www.ajconline.org'
  },
  {
    drug_a:        'Quetiapine',
    drug_b:        'Lurasidone',
    mechanism:     'Additive CNS effects',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Duloxetine',
    drug_b:        'Meloxicam',
    mechanism:     'May increase risk of bleeding',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Alprazolam',
    drug_b:        'Cimetidine',
    mechanism:     'CYP3A4 inhibition may increase alprazolam levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Escitalopram',
    drug_b:        'Warfarin',
    mechanism:     'May increase INR',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Furosemide',
    drug_b:        'Lisinopril',
    mechanism:     'Potential for first-dose hypotension',
    reference_url: 'https://www.nejm.org'
  },
  {
    drug_a:        'Gabapentin',
    drug_b:        'Hydrocodone',
    mechanism:     'Additive CNS depression',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Hydrochlorothiazide',
    drug_b:        'Ibuprofen',
    mechanism:     'NSAIDs may decrease diuretic efficacy',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Insulin',
    drug_b:        'Pramlintide',
    mechanism:     'Additive effect on glucose control',
    reference_url: 'https://diabetesjournals.org/care'
  },
  {
    drug_a:        'Lamotrigine',
    drug_b:        'Valproic Acid',
    mechanism:     'Valproic acid inhibits lamotrigine metabolism',
    reference_url: 'https://onlinelibrary.wiley.com/journal/15281167'
  },
  {
    drug_a:        'Losartan',
    drug_b:        'Ibuprofen',
    mechanism:     'NSAIDs may decrease antihypertensive efficacy',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Memantine',
    drug_b:        'Carbonic Anhydrase Inhibitors',
    mechanism:     'May increase risk of renal stone formation',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Nitrofurantoin',
    drug_b:        'Magnesium Trisilicate',
    mechanism:     'Antacids may decrease nitrofurantoin absorption',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Olanzapine',
    drug_b:        'Diazepam',
    mechanism:     'Additive CNS depression',
    reference_url: 'https://link.springer.com/journal/213'
  },
  {
    drug_a:        'Pantoprazole',
    drug_b:        'Warfarin',
    mechanism:     'May slightly increase INR',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Quetiapine',
    drug_b:        'Fluoxetine',
    mechanism:     'May increase quetiapine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Ranitidine',
    drug_b:        'Warfarin',
    mechanism:     'May slightly increase INR',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Sertraline',
    drug_b:        'Tolbutamide',
    mechanism:     'May increase tolbutamide levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Trazodone',
    drug_b:        'Phenytoin',
    mechanism:     'May alter levels of both drugs',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Valsartan',
    drug_b:        'Aliskiren',
    mechanism:     'Additive hyperkalemia risk',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Zolpidem',
    drug_b:        'Ciprofloxacin',
    mechanism:     'May increase zolpidem levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Amitriptyline',
    drug_b:        'Phenelzine',
    mechanism:     'Increased risk of serotonin syndrome',
    reference_url: 'https://link.springer.com/journal/213'
  },
  {
    drug_a:        'Bupropion',
    drug_b:        'Levodopa',
    mechanism:     'May increase risk of hypertension and side effects',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Ciprofloxacin',
    drug_b:        'Theophylline',
    mechanism:     'CYP1A2 inhibition may increase theophylline levels',
    reference_url: 'https://journal.chestnet.org'
  },
  {
    drug_a:        'Diclofenac',
    drug_b:        'Lithium',
    mechanism:     'May increase lithium levels',
    reference_url: 'https://onlinelibrary.wiley.com/journal/16000447'
  },
  {
    drug_a:        'Escitalopram',
    drug_b:        'Linezolid',
    mechanism:     'Potential increased risk of serotonin syndrome',
    reference_url: 'https://www.fda.gov/safety/medwatch-fda-safety-information-and-adverse-event-reporting-program'
  }
] AS row
MATCH (a:Drug {name: row.drug_a})-[r:INTERACTS_WITH]-(b:Drug {name: row.drug_b})
WHERE r.mechanism = row.mechanism
  AND r.source = 'core'
SET r.reference_url = CASE row.reference_url
  WHEN '' THEN null
  ELSE row.reference_url
END;

// Chunk 2/2
UNWIND [
  {
    drug_a:        'Fluconazole',
    drug_b:        'Alfentanil',
    mechanism:     'May increase alfentanil levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Glipizide',
    drug_b:        'Fluconazole',
    mechanism:     'May increase glipizide levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Hydralazine',
    drug_b:        'Diazoxide',
    mechanism:     'Additive hypotensive effect',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Isoniazid',
    drug_b:        'Carbamazepine',
    mechanism:     'May increase carbamazepine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Levothyroxine',
    drug_b:        'Sucralfate',
    mechanism:     'Binding in GI tract',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Metronidazole',
    drug_b:        'Warfarin',
    mechanism:     'May increase INR',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Nifedipine',
    drug_b:        'Quinidine',
    mechanism:     'May increase quinidine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Oxcarbazepine',
    drug_b:        'Felodipine',
    mechanism:     'May decrease felodipine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Paroxetine',
    drug_b:        'Procyclidine',
    mechanism:     'May increase procyclidine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Quinine',
    drug_b:        'Digoxin',
    mechanism:     'May increase digoxin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Rifampin',
    drug_b:        'Verapamil',
    mechanism:     'CYP induction may decrease verapamil levels',
    reference_url: 'https://ascpt.onlinelibrary.wiley.com/journal/15326535'
  },
  {
    drug_a:        'Salmeterol',
    drug_b:        'Timolol',
    mechanism:     'Antagonism of bronchodilator effect',
    reference_url: 'https://www.atsjournals.org/journal/ajrccm'
  },
  {
    drug_a:        'Telithromycin',
    drug_b:        'Midazolam',
    mechanism:     'CYP3A4 inhibition may increase midazolam levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Valproic Acid',
    drug_b:        'Meropenem',
    mechanism:     'May decrease valproic acid levels',
    reference_url: 'https://www.sciencedirect.com/journal/epilepsy-and-behavior'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Dronedarone',
    mechanism:     'May increase INR',
    reference_url: 'https://academic.oup.com/eurheartj'
  },
  {
    drug_a:        'Atenolol',
    drug_b:        'Diphenhydramine',
    mechanism:     'Additive sedative effects',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Cephalexin',
    drug_b:        'Metformin',
    mechanism:     'May slightly increase metformin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Codeine',
    drug_b:        'Chlorpromazine',
    mechanism:     'Additive CNS depression',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Diazepam',
    drug_b:        'Isoniazid',
    mechanism:     'May slightly increase diazepam levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Enalapril',
    drug_b:        'Amiloride',
    mechanism:     'Additive hyperkalemia risk',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Famotidine',
    drug_b:        'Cetirizine',
    mechanism:     'No significant interaction expected',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Guaifenesin',
    drug_b:        'Dextromethorphan',
    mechanism:     'No significant interaction expected',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Hydrocortisone',
    drug_b:        'Indapamide',
    mechanism:     'Additive hypokalemia risk',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Ibuprofen',
    drug_b:        'Pseudoephedrine',
    mechanism:     'No significant interaction expected',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Lactulose',
    drug_b:        'Electrolyte Supplements',
    mechanism:     'May alter electrolyte absorption',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Mupirocin',
    drug_b:        'Betamethasone',
    mechanism:     'No significant interaction expected',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Naproxen',
    drug_b:        'Penicillin VK',
    mechanism:     'No significant interaction expected',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Olopatadine',
    drug_b:        'Loratadine',
    mechanism:     'Additive anticholinergic effects',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Pantoprazole',
    drug_b:        'Sucralfate',
    mechanism:     'May decrease absorption of PPI',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Quetiapine',
    drug_b:        'Ramipril',
    mechanism:     'Potential for additive hypotension',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Ranitidine',
    drug_b:        'Furosemide',
    mechanism:     'No significant interaction expected',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Sennosides',
    drug_b:        'Docusate',
    mechanism:     'No significant interaction expected',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Tetracycline',
    drug_b:        'Zinc Supplements',
    mechanism:     'Chelation; decreased absorption of both',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Ursodiol',
    drug_b:        'Cholestyramine',
    mechanism:     'Binds ursodiol; decreased efficacy',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Vitamin C',
    drug_b:        'Fluphenazine',
    mechanism:     'May decrease fluphenazine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Ginseng',
    mechanism:     'May decrease anticoagulant effect',
    reference_url: 'https://journals.sagepub.com/home/aop'
  },
  {
    drug_a:        'Xylometazoline',
    drug_b:        'Phenylephrine',
    mechanism:     'Additive vasoconstrictive effects',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Zinc',
    drug_b:        'Ciprofloxacin',
    mechanism:     'Chelation; decreased ciprofloxacin absorption',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Amoxicillin',
    drug_b:        'Allopurinol',
    mechanism:     'Increased risk of amoxicillin rash',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Bisoprolol',
    drug_b:        'Rivastigmine',
    mechanism:     'Additive bradycardia risk',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Chlorthalidone',
    drug_b:        'Naproxen',
    mechanism:     'NSAIDs may decrease diuretic efficacy',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Doxycycline',
    drug_b:        'Barbiturates',
    mechanism:     'CYP induction may decrease doxycycline levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Erythromycin',
    drug_b:        'Bromocriptine',
    mechanism:     'May increase bromocriptine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Fluoxetine',
    drug_b:        'Perphenazine',
    mechanism:     'May increase perphenazine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Glyburide',
    drug_b:        'Colestipol',
    mechanism:     'Binds glyburide; decreased absorption',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Haloperidol',
    drug_b:        'Methyldopa',
    mechanism:     'Additive hypotensive effects',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Insulin',
    drug_b:        'Clonidine',
    mechanism:     'May decrease insulin secretion',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Ketoconazole',
    drug_b:        'Buspirone',
    mechanism:     'May increase buspirone levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Levofloxacin',
    drug_b:        'Didanosine',
    mechanism:     'Chelation with buffered didanosine',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Metoclopramide',
    drug_b:        'Levodopa',
    mechanism:     'Antagonizes levodopa\'s effect',
    reference_url: 'https://movementdisorders.onlinelibrary.wiley.com/journal/15318257'
  },
  {
    drug_a:        'Nystatin',
    drug_b:        'Clotrimazole',
    mechanism:     'No significant interaction expected',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Omeprazole',
    drug_b:        'Ketoconazole',
    mechanism:     'Increased gastric pH may decrease ketoconazole absorption',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Phenytoin',
    drug_b:        'Pyridoxine',
    mechanism:     'May decrease phenytoin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Quetiapine',
    drug_b:        'Thioridazine',
    mechanism:     'Additive QT prolongation risk',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Risperidone',
    drug_b:        'Carbamazepine',
    mechanism:     'CYP induction may decrease risperidone levels',
    reference_url: 'https://journals.lww.com/psychopharmacology/pages/default.aspx'
  },
  {
    drug_a:        'Spironolactone',
    drug_b:        'Digoxin',
    mechanism:     'May slightly increase digoxin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Telmisartan',
    drug_b:        'Digoxin',
    mechanism:     'May slightly increase digoxin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Valaciclovir',
    drug_b:        'Cimetidine',
    mechanism:     'May increase valaciclovir levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Avocado',
    mechanism:     'Vitamin K content may decrease anticoagulant effect',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Zafirlukast',
    drug_b:        'Theophylline',
    mechanism:     'May increase theophylline levels',
    reference_url: 'https://journals.sagepub.com/home/aop'
  },
  {
    drug_a:        'Alendronate',
    drug_b:        'Calcium Carbonate',
    mechanism:     'Binding; decreased alendronate absorption',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Bumetanide',
    drug_b:        'Lithium',
    mechanism:     'Diuretic-induced sodium loss may increase lithium levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Cimetidine',
    drug_b:        'Metronidazole',
    mechanism:     'May increase metronidazole levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Diclofenac',
    drug_b:        'Colchicine',
    mechanism:     'May increase colchicine levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Esomeprazole',
    drug_b:        'Voriconazole',
    mechanism:     'May increase voriconazole levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Folic Acid',
    drug_b:        'Phenytoin',
    mechanism:     'May decrease phenytoin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Glimepiride',
    drug_b:        'Rifampin',
    mechanism:     'CYP induction may decrease glimepiride levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Hydroxychloroquine',
    drug_b:        'Digoxin',
    mechanism:     'May increase digoxin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Itraconazole',
    drug_b:        'Alprazolam',
    mechanism:     'May increase alprazolam levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Linagliptin',
    drug_b:        'Rifampin',
    mechanism:     'May slightly decrease linagliptin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Montelukast',
    drug_b:        'Gemfibrozil',
    mechanism:     'May increase montelukast levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Nitroglycerin',
    drug_b:        'Sildenafil',
    mechanism:     'Additive hypotensive effect (Major if taken within 24h)',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Ondansetron',
    drug_b:        'Apomorphine',
    mechanism:     'Additive hypotensive effect',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Propranolol',
    drug_b:        'Chlorpromazine',
    mechanism:     'May increase levels of both drugs',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Quinine',
    drug_b:        'Atorvastatin',
    mechanism:     'May increase atorvastatin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Rosuvastatin',
    drug_b:        'Fenofibrate',
    mechanism:     'Increased risk of myopathy',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Sitagliptin',
    drug_b:        'Digoxin',
    mechanism:     'May slightly increase digoxin levels',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Tamsulosin',
    drug_b:        'Tadalafil',
    mechanism:     'Additive hypotensive effect',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Vardenafil',
    drug_b:        'Nicardipine',
    mechanism:     'Additive hypotensive effect',
    reference_url: 'https://doi.org/10.1093/nar/gkad976'
  },
  {
    drug_a:        'Warfarin',
    drug_b:        'Ginkgo Biloba',
    mechanism:     'May increase bleeding risk',
    reference_url: 'https://journals.sagepub.com/home/aop'
  }
] AS row
MATCH (a:Drug {name: row.drug_a})-[r:INTERACTS_WITH]-(b:Drug {name: row.drug_b})
WHERE r.mechanism = row.mechanism
  AND r.source = 'core'
SET r.reference_url = CASE row.reference_url
  WHEN '' THEN null
  ELSE row.reference_url
END;

// ── Verify ───────────────────────────────────────────────────
// MATCH ()-[r:INTERACTS_WITH {source: 'core'}]->()
// RETURN r.reference AS original, r.reference_url AS url
// ORDER BY original LIMIT 20;