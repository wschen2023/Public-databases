-- Dopamine information for eICU Collaborative Research Database 2.0
-- 20240930
-- Modified to make it work with postgreSQL
-- ORIGINALLY FROM Xiaoli Liu
-- get all of dopamine information with drugrate units of mcg/kg/min 
-- 1. add information of unit with 'Dopamine ()'
-- process of 'Dopamine ()' |  5020
-- we notice that 'drugname = 'Norepinephrine ()'' might happen when :
-- 1) no value -- 0; 2) lose unit for saving time; 3) no-known reasons
-- so : we will solve the 2) by adding units considering the units before and after
drop table if exists eicu_crd.dopamine_info_eicu;
create table eicu_crd.dopamine_info_eicu as

with infusiondrug_new_0 as (
  select infusiondrugid, patientunitstayid, infusionoffset, drugname
  , cast(drugrate as numeric) as drugrate, infusionrate, drugamount, volumeoffluid, patientweight
  from eicu_crd.infusiondrug
  where 
  (
    drugname like '%dopamine%'
    or drugname like '%Dopamine%'
    or drugname like '%DOPamine%'
  )
  and drugrate not in (
        'OFF'
        , 'ERROR'
        , 'UD'
        , ''
  )
  and drugrate not like '%Time Correction%'
)

, dopamine_in_part_0 as (
  select patientunitstayid
  from infusiondrug_new_0
  where drugname = 'Dopamine ()'  -- |  5020
  group by patientunitstayid
)

, dopamine_in_part_1 as (
  select ifd.infusiondrugid
  , ifd.patientunitstayid
  , ifd.infusionoffset
  , ifd.drugname
  , case 
  when ifd.drugname = 'Dopamine (mcg/kg/hr)' then 1
  when ifd.drugname = 'Dopamine (mcg/kg/min)' then 2
  when ifd.drugname = 'Dopamine (ml/hr)' then 3
  when ifd.drugname = 'Dopamine' then 4
  else null end as unit_flag   -- the imputation function is fit for float value
  from infusiondrug_new_0 ifd
  inner join dopamine_in_part_0 nip
  on ifd.patientunitstayid = nip.patientunitstayid
  where ifd.drugname like '%Dopamine%'
)

, dopamine_in_part_2_pre as (
  select distinct on (patientunitstayid)
  patientunitstayid
  , last_value(unit_flag) over (partition by patientunitstayid order by infusionoffset rows between unbounded preceding and unbounded following) as unit_flag_locf
  , last_value(unit_flag) over (partition by patientunitstayid order by infusionoffset desc rows between unbounded preceding and unbounded following) as unit_flag_focb
  from (
    select *
	from dopamine_in_part_1
	where unit_flag is not null
	) as foo
  order by 
	patientunitstayid
)

, dopamine_in_part_2 as (
  select dip_1.infusiondrugid
  , dip_1.patientunitstayid
  , dip_1.infusionoffset
  , dip_1.drugname 
  , dip_1.unit_flag
  , dip_2.unit_flag_locf
  , dip_2.unit_flag_focb
  from dopamine_in_part_1 dip_1
  left join dopamine_in_part_2_pre dip_2
    on dip_1.patientunitstayid = dip_2.patientunitstayid
)

, dopamine_in_part_3 as (
  select nip.infusiondrugid
  , nip.patientunitstayid
  , nip.infusionoffset
  , nip.drugname 
  , nip.unit_flag
  , coalesce(nip.unit_flag_locf, nip.unit_flag_focb) as unit_flag_new
  from dopamine_in_part_2 nip 
)

, dopamine_in_part_4 as (
  select nip.infusiondrugid
  , nip.patientunitstayid
  , nip.infusionoffset
  , nip.drugname 
  , nip.unit_flag
  , case
  when nip.unit_flag_new = 1 then 'Dopamine (mcg/kg/hr)'
  when nip.unit_flag_new = 2 then 'Dopamine (mcg/kg/min)'
  when nip.unit_flag_new = 3 then 'Dopamine (ml/hr)'
  when nip.unit_flag_new = 4 then 'Dopamine'
  else null end as drugname_new 
  from dopamine_in_part_3 nip  
)

, dopamine_in_part_5 as ( -- exist the units of Dopamine ()
  select nip.infusiondrugid
  , nip.patientunitstayid
  , nip.infusionoffset
  , nip.drugname_new as drugname
  , ifd.drugrate
  , ifd.infusionrate
  , ifd.drugamount
  , ifd.volumeoffluid
  , ifd.patientweight
  from dopamine_in_part_4 nip
  inner join infusiondrug_new_0 ifd 
  on nip.infusiondrugid = ifd.infusiondrugid
)

, dopamine_in_part_6 as (
  select ifd.infusiondrugid
  , ifd.patientunitstayid
  , ifd.infusionoffset
  , ifd.drugname as drugname
  , ifd.drugrate
  , ifd.infusionrate
  , ifd.drugamount
  , ifd.volumeoffluid
  , ifd.patientweight
  from infusiondrug_new_0 ifd
  where ifd.drugname like '%dopamine%'
  and ifd.patientunitstayid not in (select * from dopamine_in_part_0)
)

, dopamine_in_part as (
  select distinct *
  from (
    select *
    from dopamine_in_part_5
    union all 
    select *
    from dopamine_in_part_6
  ) as foo
)

-- 2. Unified unit to mcg/kg/min
, dopamine_1 as (
  select idn.infusiondrugid
  , idn.patientunitstayid
  , idn.infusionoffset
  , idn.drugname
  , idn.infusionrate
  , idn.drugamount
  , idn.volumeoffluid
  , idn.patientweight 
  , case
  when idn.drugname in (
   'DOPamine MAX 800 mg Dextrose 5% 250 ml  Premix (mcg/kg/min)' --   | 	151
   , 'dopamine (mcg/kg/min)'   --   |  	21
   , 'DOPamine STD 15 mg Dextrose 5% 250 ml  Premix (mcg/kg/min)'  --  | 	2
   , 'Dopamine (mcg/kg/min)'  --  |	29215
   , 'DOPamine STD 400 mg Dextrose 5% 500 ml  Premix (mcg/kg/min)'  -- |  2 
   , 'DOPamine STD 400 mg Dextrose 5% 250 ml  Premix (mcg/kg/min)'  -- |  544
  )
    then idn.drugrate 
  when idn.drugname = 'Dopamine (mcg/kg/hr)'  --  |	 5
    then idn.drugrate/60 
  when idn.drugname = 'Dopamine (mcg/hr)'  --  |  8
    then idn.drugrate/(60 * coalesce(coalesce(wi.admissionweight, wi.dischargeweight),80))
  when idn.drugname = 'Dopamine (mcg/min)'  -- |   3
    then idn.drugrate/(coalesce(coalesce(wi.admissionweight, wi.dischargeweight),80))
  when idn.drugname = 'Dopamine (mg/hr)'  -- |	2
    then 1000 * idn.drugrate/(60 * coalesce(coalesce(wi.admissionweight, wi.dischargeweight),80))
  when idn.drugname = 'Dopamine (nanograms/kg/min)' -- |  1
    then idn.drugrate/1000
  else null end as rate_dopamine
  from dopamine_in_part idn
  left join eicu_crd.weight_icustay_detail_modify_eicu wi 
  on idn.patientunitstayid = wi.patientunitstayid
  where idn.drugname in (
    'DOPamine MAX 800 mg Dextrose 5% 250 ml  Premix (mcg/kg/min)'      -- | 151 
    , 'dopamine (mcg/kg/min)'     -- | 21
    , 'DOPamine STD 15 mg Dextrose 5% 250 ml  Premix (mcg/kg/min)'    -- |  2
    , 'Dopamine (mcg/kg/min)'  -- |  29215
    , 'DOPamine STD 400 mg Dextrose 5% 500 ml  Premix (mcg/kg/min)'   -- |  2
    , 'DOPamine STD 400 mg Dextrose 5% 250 ml  Premix (mcg/kg/min)'   -- |  544
    , 'Dopamine (mcg/kg/hr)'          -- |  5
    , 'Dopamine (mcg/hr)'             -- |  8
    , 'Dopamine (mcg/min)'            -- |  3 
    , 'Dopamine (mg/hr)'             --  |  2
    , 'Dopamine (nanograms/kg/min)'  --  |   2
    )
)

-- without considering Dopamine	1684
, dopamine_2 as (
  select idn.infusiondrugid
  , idn.patientunitstayid
  , idn.infusionoffset
  , idn.drugname
  , idn.infusionrate
  , idn.drugamount
  , idn.volumeoffluid
  , idn.patientweight
  , 1000*idn.drugrate*4/(250*60*coalesce(coalesce(wi.admissionweight, wi.dischargeweight),80)) as rate_dopamine -- set mL available : 250ml, maybe not right 
  from dopamine_in_part idn
  left join eicu_crd.weight_icustay_detail_modify_eicu wi 
  on idn.patientunitstayid = wi.patientunitstayid  
  where drugname = 'Dopamine (ml/hr)'  -- |  56099  
)	

, dopamine as (
    select distinct *
    from (
        select *
        from dopamine_1
        union all
        select *
        from dopamine_2
    ) as foo
)

select infusiondrugid
, patientunitstayid
, infusionoffset
, drugname
, round(rate_dopamine,4) as rate_dopamine
, infusionrate
, drugamount
, volumeoffluid
, patientweight 
from dopamine
order by patientunitstayid, infusionoffset;




