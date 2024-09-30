-- Dobutamine information for eICU Collaborative Research Database 2.0
-- 20240930
-- Modified to make it work with postgreSQL
-- ORIGINALLY FROM Xiaoli Liu
-- Because using dobutamine drug, will be considered as very serious, no needing to consider value or unit
drop table if exists eicu_crd.dobutamine_info_eicu;
create table eicu_crd.dobutamine_info_eicu as

with infusiondrug_new_0 as (
  select infusiondrugid, patientunitstayid, infusionoffset, drugname
  , cast(drugrate as numeric) as drugrate, infusionrate, drugamount, volumeoffluid, patientweight
  from eicu_crd.infusiondrug
  where (
    drugname like '%Dobutamine%'
    or drugname like '%DOBUTamine%'
  )
  and drugrate != ''
)

select infusiondrugid
, patientunitstayid
, infusionoffset
, drugname
, round(drugrate,4) as rate_dobutamine
, infusionrate
, drugamount
, volumeoffluid
, patientweight 
from infusiondrug_new_0
order by patientunitstayid
, infusionoffset;