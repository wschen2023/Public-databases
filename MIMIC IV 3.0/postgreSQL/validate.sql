-- Validate the MIMIC-IV tables built correctly by checking against known row counts of MIMIC-IV v3.0
-- Included derivative tables created by MIT-LCP/mimic-code
-- https://github.com/MIT-LCP/mimic-code
WITH expected AS
(
    -- hosp data
	  SELECT 'admissions' AS tbl,         546028 AS row_count UNION ALL
    SELECT 'd_hcpcs' AS tbl,            89208 AS row_count UNION ALL
    SELECT 'd_icd_diagnoses' AS tbl,    112107 AS row_count UNION ALL
    SELECT 'd_icd_procedures' AS tbl,   86423 AS row_count UNION ALL
    SELECT 'd_labitems' AS tbl,         1650 AS row_count UNION ALL
    SELECT 'diagnoses_icd' AS tbl,      6364520 AS row_count UNION ALL
    SELECT 'drgcodes' AS tbl,           761860 AS row_count UNION ALL
    SELECT 'emar' AS tbl,               42808593 AS row_count UNION ALL
    SELECT 'emar_detail' AS tbl,        87371064 AS row_count UNION ALL
    SELECT 'hcpcsevents' AS tbl,        186074 AS row_count UNION ALL
    SELECT 'labevents' AS tbl,          158478383 AS row_count UNION ALL
    SELECT 'microbiologyevents' AS tbl, 3988224 AS row_count UNION ALL
    SELECT 'omr' AS tbl,                7753027 AS row_count UNION ALL
    SELECT 'patients' AS tbl,           364627 AS row_count UNION ALL
    SELECT 'pharmacy' AS tbl,           17847567 AS row_count UNION ALL
    SELECT 'poe' AS tbl,                52212109 AS row_count UNION ALL
    SELECT 'poe_detail' AS tbl,         8504982 AS row_count UNION ALL
    SELECT 'prescriptions' AS tbl,      20292611 AS row_count UNION ALL
    SELECT 'procedures_icd' AS tbl,     859655 AS row_count UNION ALL
	  SELECT 'provider' AS tbl,     		42244 AS row_count UNION ALL
    SELECT 'services' AS tbl,           593071 AS row_count UNION ALL
    SELECT 'transfers' AS tbl,          2413589 AS row_count UNION ALL
    -- icu data
	  SELECT 'caregiver' AS tbl,           17984 AS row_count UNION ALL
    SELECT 'icustays' AS tbl,           94458 AS row_count UNION ALL
    SELECT 'd_items' AS tbl,            4095 AS row_count UNION ALL
    SELECT 'chartevents' AS tbl,        432997491 AS row_count UNION ALL
    SELECT 'datetimeevents' AS tbl,     9979761 AS row_count UNION ALL
	  SELECT 'ingredientevents' AS tbl,     14253480 AS row_count UNION ALL
    SELECT 'inputevents' AS tbl,        10953713 AS row_count UNION ALL
    SELECT 'outputevents' AS tbl,       5359395 AS row_count UNION ALL
    SELECT 'procedureevents' AS tbl,    808706 AS row_count UNION ALL
	  -- derived data
  	SELECT 'acei' AS tbl,           135153 AS row_count UNION ALL
  	SELECT 'age' AS tbl,           546028 AS row_count UNION ALL
  	SELECT 'antibiotic' AS tbl,           949901 AS row_count UNION ALL
  	SELECT 'apsiii' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'bg' AS tbl,           697418 AS row_count UNION ALL
  	SELECT 'blood_differential' AS tbl,           4154226 AS row_count UNION ALL
  	SELECT 'cardiac_marker' AS tbl,           380131 AS row_count UNION ALL
  	SELECT 'charlson' AS tbl,           546028 AS row_count UNION ALL
  	SELECT 'chemistry' AS tbl,           4976408 AS row_count UNION ALL
  	SELECT 'coagulation' AS tbl,           1991167 AS row_count UNION ALL
  	SELECT 'complete_blood_count' AS tbl,           4377900 AS row_count UNION ALL
  	SELECT 'creatinine_baseline' AS tbl,           546028 AS row_count UNION ALL
  	SELECT 'crrt' AS tbl,           475214 AS row_count UNION ALL
  	SELECT 'dobutamine' AS tbl,           10264 AS row_count UNION ALL
  	SELECT 'dopamine' AS tbl,           18085 AS row_count UNION ALL
  	SELECT 'enzyme' AS tbl,           2187060 AS row_count UNION ALL
  	SELECT 'epinephrine' AS tbl,           31495 AS row_count UNION ALL
  	SELECT 'first_day_bg' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'first_day_bg_art' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'first_day_gcs' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'first_day_height' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'first_day_lab' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'first_day_rrt' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'first_day_sofa' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'first_day_urine_output' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'first_day_vitalsign' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'first_day_weight' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'gcs' AS tbl,           2217787 AS row_count UNION ALL
  	SELECT 'height' AS tbl,           43342 AS row_count UNION ALL
  	SELECT 'icp' AS tbl,           243283 AS row_count UNION ALL
  	SELECT 'icustay_detail' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'icustay_hourly' AS tbl,           10485609 AS row_count UNION ALL
  	SELECT 'icustay_times' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'inflammation' AS tbl,           174269 AS row_count UNION ALL
  	SELECT 'invasive_line' AS tbl,           108165 AS row_count UNION ALL
  	SELECT 'kdigo_creatinine' AS tbl,           811585 AS row_count UNION ALL
  	SELECT 'kdigo_stages' AS tbl,           5099899 AS row_count UNION ALL
  	SELECT 'kdigo_uo' AS tbl,           4127634 AS row_count UNION ALL
  	SELECT 'lods' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'meld' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'milrinone' AS tbl,           10668 AS row_count UNION ALL
  	SELECT 'neuroblock' AS tbl,           19430 AS row_count UNION ALL
  	SELECT 'norepinephrine' AS tbl,           459800 AS row_count UNION ALL
  	SELECT 'norepinephrine_equivalent_dose' AS tbl,           783613 AS row_count UNION ALL
  	SELECT 'nsaid' AS tbl,           293253 AS row_count UNION ALL
  	SELECT 'oasis' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'oxygen_delivery' AS tbl,           794232 AS row_count UNION ALL
  	SELECT 'phenylephrine' AS tbl,           209376 AS row_count UNION ALL
  	SELECT 'rhythm' AS tbl,           7887354 AS row_count UNION ALL
  	SELECT 'rrt' AS tbl,           4098630 AS row_count UNION ALL
  	SELECT 'sapsii' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'sepsis3' AS tbl,           41295 AS row_count UNION ALL
  	SELECT 'sirs' AS tbl,           94458 AS row_count UNION ALL
  	SELECT 'sofa' AS tbl,           8219121 AS row_count UNION ALL
  	SELECT 'suspicion_of_infection' AS tbl,           949901 AS row_count UNION ALL
  	SELECT 'urine_output' AS tbl,           4127634 AS row_count UNION ALL
  	SELECT 'urine_output_rate' AS tbl,           4126485 AS row_count UNION ALL	
  	SELECT 'vasoactive_agent' AS tbl,           839543 AS row_count UNION ALL
  	SELECT 'vasopressin' AS tbl,           37163 AS row_count UNION ALL
  	SELECT 'ventilation' AS tbl,           144813 AS row_count UNION ALL
  	SELECT 'ventilator_setting' AS tbl,           1377514 AS row_count UNION ALL
  	SELECT 'vitalsign' AS tbl,           13519533 AS row_count UNION ALL
  	SELECT 'weight_durations' AS tbl,           401850 AS row_count
)
, observed as
(
    -- hosp data
	  SELECT 'admissions' AS tbl, count(*) AS row_count FROM mimiciv_hosp.admissions UNION ALL
    SELECT 'd_hcpcs' AS tbl, count(*) AS row_count FROM mimiciv_hosp.d_hcpcs UNION ALL
    SELECT 'd_icd_diagnoses' AS tbl, count(*) AS row_count FROM mimiciv_hosp.d_icd_diagnoses UNION ALL
    SELECT 'd_icd_procedures' AS tbl, count(*) AS row_count FROM mimiciv_hosp.d_icd_procedures UNION ALL
    SELECT 'd_labitems' AS tbl, count(*) AS row_count FROM mimiciv_hosp.d_labitems UNION ALL
    SELECT 'diagnoses_icd' AS tbl, count(*) AS row_count FROM mimiciv_hosp.diagnoses_icd UNION ALL
    SELECT 'drgcodes' AS tbl, count(*) AS row_count FROM mimiciv_hosp.drgcodes UNION ALL
    SELECT 'emar' AS tbl, count(*) AS row_count FROM mimiciv_hosp.emar UNION ALL
    SELECT 'emar_detail' AS tbl, count(*) AS row_count FROM mimiciv_hosp.emar_detail UNION ALL
    SELECT 'hcpcsevents' AS tbl, count(*) AS row_count FROM mimiciv_hosp.hcpcsevents UNION ALL
    SELECT 'labevents' AS tbl, count(*) AS row_count FROM mimiciv_hosp.labevents UNION ALL
    SELECT 'microbiologyevents' AS tbl, count(*) AS row_count FROM mimiciv_hosp.microbiologyevents UNION ALL
    SELECT 'omr' AS tbl, count(*) AS row_count FROM mimiciv_hosp.omr UNION ALL
    SELECT 'patients' AS tbl, count(*) AS row_count FROM mimiciv_hosp.patients UNION ALL
    SELECT 'pharmacy' AS tbl, count(*) AS row_count FROM mimiciv_hosp.pharmacy UNION ALL
    SELECT 'poe' AS tbl, count(*) AS row_count FROM mimiciv_hosp.poe UNION ALL
    SELECT 'poe_detail' AS tbl, count(*) AS row_count FROM mimiciv_hosp.poe_detail UNION ALL
    SELECT 'prescriptions' AS tbl, count(*) AS row_count FROM mimiciv_hosp.prescriptions UNION ALL
    SELECT 'procedures_icd' AS tbl, count(*) AS row_count FROM mimiciv_hosp.procedures_icd UNION ALL
	  SELECT 'provider' AS tbl, count(*) AS row_count FROM mimiciv_hosp.provider UNION ALL
    SELECT 'services' AS tbl, count(*) AS row_count FROM mimiciv_hosp.services UNION ALL
    SELECT 'transfers' AS tbl, count(*) AS row_count FROM mimiciv_hosp.transfers UNION ALL
    -- icu data
    SELECT 'caregiver' AS tbl, count(*) AS row_count FROM mimiciv_icu.caregiver UNION ALL
	  SELECT 'icustays' AS tbl, count(*) AS row_count FROM mimiciv_icu.icustays UNION ALL
    SELECT 'chartevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.chartevents UNION ALL
    SELECT 'd_items' AS tbl, count(*) AS row_count FROM mimiciv_icu.d_items UNION ALL
    SELECT 'datetimeevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.datetimeevents UNION ALL
	  SELECT 'ingredientevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.ingredientevents UNION ALL
    SELECT 'inputevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.inputevents UNION ALL
    SELECT 'outputevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.outputevents UNION ALL
    SELECT 'procedureevents' AS tbl, count(*) AS row_count FROM mimiciv_icu.procedureevents UNION ALL
	  -- derived data
  	SELECT 'acei' AS tbl, count(*) AS row_count FROM mimiciv_derived.acei UNION ALL
  	SELECT 'age' AS tbl, count(*) AS row_count FROM mimiciv_derived.age UNION ALL 
  	SELECT 'antibiotic' AS tbl, count(*) AS row_count FROM mimiciv_derived.antibiotic UNION ALL  
  	SELECT 'apsiii' AS tbl, count(*) AS row_count FROM mimiciv_derived.apsiii UNION ALL  
  	SELECT 'bg' AS tbl, count(*) AS row_count FROM mimiciv_derived.bg UNION ALL  
  	SELECT 'blood_differential' AS tbl, count(*) AS row_count FROM mimiciv_derived.blood_differential UNION ALL  
  	SELECT 'cardiac_marker' AS tbl, count(*) AS row_count FROM mimiciv_derived.cardiac_marker UNION ALL 
  	SELECT 'charlson' AS tbl, count(*) AS row_count FROM mimiciv_derived.charlson UNION ALL 
  	SELECT 'chemistry' AS tbl, count(*) AS row_count FROM mimiciv_derived.chemistry UNION ALL 
  	SELECT 'coagulation' AS tbl, count(*) AS row_count FROM mimiciv_derived.coagulation UNION ALL 
  	SELECT 'complete_blood_count' AS tbl, count(*) AS row_count FROM mimiciv_derived.complete_blood_count UNION ALL 
  	SELECT 'creatinine_baseline' AS tbl, count(*) AS row_count FROM mimiciv_derived.creatinine_baseline UNION ALL  
  	SELECT 'crrt' AS tbl, count(*) AS row_count FROM mimiciv_derived.crrt UNION ALL 
  	SELECT 'dobutamine' AS tbl, count(*) AS row_count FROM mimiciv_derived.dobutamine UNION ALL 
  	SELECT 'dopamine' AS tbl, count(*) AS row_count FROM mimiciv_derived.dopamine UNION ALL 
  	SELECT 'enzyme' AS tbl, count(*) AS row_count FROM mimiciv_derived.enzyme UNION ALL  
  	SELECT 'epinephrine' AS tbl, count(*) AS row_count FROM mimiciv_derived.epinephrine UNION ALL 
  	SELECT 'first_day_bg' AS tbl, count(*) AS row_count FROM mimiciv_derived.first_day_bg UNION ALL 
  	SELECT 'first_day_bg_art' AS tbl, count(*) AS row_count FROM mimiciv_derived.first_day_bg_art UNION ALL 
  	SELECT 'first_day_gcs' AS tbl, count(*) AS row_count FROM mimiciv_derived.first_day_gcs UNION ALL  
  	SELECT 'first_day_height' AS tbl, count(*) AS row_count FROM mimiciv_derived.first_day_height UNION ALL 
  	SELECT 'first_day_lab' AS tbl, count(*) AS row_count FROM mimiciv_derived.first_day_lab UNION ALL 
  	SELECT 'first_day_rrt' AS tbl, count(*) AS row_count FROM mimiciv_derived.first_day_rrt UNION ALL  
  	SELECT 'first_day_sofa' AS tbl, count(*) AS row_count FROM mimiciv_derived.first_day_sofa UNION ALL 
  	SELECT 'first_day_urine_output' AS tbl, count(*) AS row_count FROM mimiciv_derived.first_day_urine_output UNION ALL 
  	SELECT 'first_day_vitalsign' AS tbl, count(*) AS row_count FROM mimiciv_derived.first_day_vitalsign UNION ALL 
  	SELECT 'first_day_weight' AS tbl, count(*) AS row_count FROM mimiciv_derived.first_day_weight UNION ALL 
  	SELECT 'gcs' AS tbl, count(*) AS row_count FROM mimiciv_derived.gcs UNION ALL  
  	SELECT 'height' AS tbl, count(*) AS row_count FROM mimiciv_derived.height UNION ALL  
  	SELECT 'icp' AS tbl, count(*) AS row_count FROM mimiciv_derived.icp UNION ALL  
  	SELECT 'icustay_detail' AS tbl, count(*) AS row_count FROM mimiciv_derived.icustay_detail UNION ALL   
  	SELECT 'icustay_hourly' AS tbl, count(*) AS row_count FROM mimiciv_derived.icustay_hourly UNION ALL 
  	SELECT 'icustay_times' AS tbl, count(*) AS row_count FROM mimiciv_derived.icustay_times UNION ALL 
  	SELECT 'inflammation' AS tbl, count(*) AS row_count FROM mimiciv_derived.inflammation UNION ALL  
  	SELECT 'invasive_line' AS tbl, count(*) AS row_count FROM mimiciv_derived.invasive_line UNION ALL   
  	SELECT 'kdigo_creatinine' AS tbl, count(*) AS row_count FROM mimiciv_derived.kdigo_creatinine UNION ALL 
  	SELECT 'kdigo_stages' AS tbl, count(*) AS row_count FROM mimiciv_derived.kdigo_stages UNION ALL 
  	SELECT 'kdigo_uo' AS tbl, count(*) AS row_count FROM mimiciv_derived.kdigo_uo UNION ALL 
  	SELECT 'lods' AS tbl, count(*) AS row_count FROM mimiciv_derived.lods UNION ALL  
  	SELECT 'meld' AS tbl, count(*) AS row_count FROM mimiciv_derived.meld UNION ALL  
  	SELECT 'milrinone' AS tbl, count(*) AS row_count FROM mimiciv_derived.milrinone UNION ALL   
  	SELECT 'neuroblock' AS tbl, count(*) AS row_count FROM mimiciv_derived.neuroblock UNION ALL  
  	SELECT 'norepinephrine' AS tbl, count(*) AS row_count FROM mimiciv_derived.norepinephrine UNION ALL 
  	SELECT 'norepinephrine_equivalent_dose' AS tbl, count(*) AS row_count FROM mimiciv_derived.norepinephrine_equivalent_dose UNION ALL 
  	SELECT 'nsaid' AS tbl, count(*) AS row_count FROM mimiciv_derived.nsaid UNION ALL 
  	SELECT 'oasis' AS tbl, count(*) AS row_count FROM mimiciv_derived.oasis UNION ALL 
  	SELECT 'oxygen_delivery' AS tbl, count(*) AS row_count FROM mimiciv_derived.oxygen_delivery UNION ALL 
  	SELECT 'phenylephrine' AS tbl, count(*) AS row_count FROM mimiciv_derived.phenylephrine UNION ALL 
  	SELECT 'rhythm' AS tbl, count(*) AS row_count FROM mimiciv_derived.rhythm UNION ALL 
  	SELECT 'rrt' AS tbl, count(*) AS row_count FROM mimiciv_derived.rrt UNION ALL  
  	SELECT 'sapsii' AS tbl, count(*) AS row_count FROM mimiciv_derived.sapsii UNION ALL  
  	SELECT 'sepsis3' AS tbl, count(*) AS row_count FROM mimiciv_derived.sepsis3 UNION ALL 
  	SELECT 'sirs' AS tbl, count(*) AS row_count FROM mimiciv_derived.sirs UNION ALL  
  	SELECT 'sofa' AS tbl, count(*) AS row_count FROM mimiciv_derived.sofa UNION ALL 
  	SELECT 'suspicion_of_infection' AS tbl, count(*) AS row_count FROM mimiciv_derived.suspicion_of_infection UNION ALL 
  	SELECT 'urine_output' AS tbl, count(*) AS row_count FROM mimiciv_derived.urine_output UNION ALL 
  	SELECT 'urine_output_rate' AS tbl, count(*) AS row_count FROM mimiciv_derived.urine_output_rate UNION ALL 
  	SELECT 'vasoactive_agent' AS tbl, count(*) AS row_count FROM mimiciv_derived.vasoactive_agent UNION ALL 
  	SELECT 'vasopressin' AS tbl, count(*) AS row_count FROM mimiciv_derived.vasopressin UNION ALL   
  	SELECT 'ventilation' AS tbl, count(*) AS row_count FROM mimiciv_derived.ventilation UNION ALL  
  	SELECT 'ventilator_setting' AS tbl, count(*) AS row_count FROM mimiciv_derived.ventilator_setting UNION ALL   
  	SELECT 'vitalsign' AS tbl, count(*) AS row_count FROM mimiciv_derived.vitalsign UNION ALL   
  	SELECT 'weight_durations' AS tbl, count(*) AS row_count FROM mimiciv_derived.weight_durations
)
SELECT
    exp.tbl
    , exp.row_count AS expected_count
    , obs.row_count AS observed_count
    , CASE
        WHEN exp.row_count = obs.row_count
        THEN 'PASSED'
        ELSE 'FAILED'
    END AS ROW_COUNT_CHECK
FROM expected exp
INNER JOIN observed obs
  ON exp.tbl = obs.tbl
ORDER BY exp.tbl
;
