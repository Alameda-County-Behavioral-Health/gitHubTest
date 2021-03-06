/*
Hello World
Reporting Units End Date
- For active RUs the REPORTING_UNIT_END_DATE will be NULL or 1858-11-17 00:00:00.000
- all other RUs are inactive
*/

-- MHS
SELECT TOP 100 reporting_unit as RU
	,REPORTING_UNIT_END_DATE
	,	* 
FROM InSyst_MHS_E5.dbo.PROVIDER_MASTER
where 
	1=1
	--and (REPORTING_UNIT_END_DATE = '1858-11-17 00:00:00.000'
	--or REPORTING_UNIT_END_DATE is null)
	--and provider_name like '%tri-city%'
	--and reporting_unit = '01IB1'



-- SUD
SELECT TOP 100 reporting_unit as RU
	,REPORTING_UNIT_END_DATE
	,	* 
FROM InSyst_SUD_E6.dbo.PROVIDER_MASTER
where 1=1
	--and (REPORTING_UNIT_END_DATE = '1858-11-17 00:00:00.000'
	--or REPORTING_UNIT_END_DATE is null)
	--and provider_name like '%la clinica%'
	and provider_name like '%tri-city%'


-- Family Bridges (none)
-- West Oakland Health Council (none), there is west oakland...

with cte
as
(
SELECT reporting_unit as RU
	,provider_name as PROV_NAME
	,REPORTING_UNIT_END_DATE AS REPORT_END_DATE
	,'SUD' AS PLAN_TYPE
	,	* 
FROM InSyst_SUD_E6.dbo.PROVIDER_MASTER
where 1=1
	and provider_name like '%Cherry hil%'
	or provider_name like '%Sausa%'
	or provider_name like '%Bonita House%'
	or provider_name like '%la familia%'	
	or provider_name like '%Lifelong%'
	or provider_name like '%tri-city%'
	or provider_name like '%alameda hlth%'
	or provider_name like '%axis comm%'
	or provider_name like '%native amer%'
	or provider_name like '%la clinica%'
	or provider_name like '%alameda hlth%'
	or cds_provider_name like '%WEST OAKLAND HEALTH COUN%'
union
SELECT reporting_unit as RU
	,provider_name as PROV_NAME
	,REPORTING_UNIT_END_DATE AS REPORT_END_DATE
	,'MHS' AS PLAN_TYPE
	,	* 
FROM InSyst_MHS_E5.dbo.PROVIDER_MASTER
where 1=1
	and provider_name like '%Cherry hil%'
	or provider_name like '%Sausa%'
	or provider_name like '%BONITA HOUSE%'
	or provider_name like '%la familia%'
	or provider_name like '%Lifelong%'
	or provider_name like '%tri-city%'
	or provider_name like '%alameda hlth%'
	or provider_name like '%axis comm%'
	or provider_name like '%native amer%'
	or cds_provider_name like '%WEST OAKLAND HEALTH COUN%'
)
,
cte2
as
(
select RU	
	,PLAN_TYPE
	,PROV_NAME
	,CDS_PROVIDER_NAME
	,REPORT_END_DATE
	,COUNTY_DIMENSION_ONE
	,COUNTY_DIMENSION_TWO
from cte
where 1=1
	and	REPORTING_UNIT_END_DATE = '1858-11-17 00:00:00.000'
	or REPORTING_UNIT_END_DATE is null
)
select *
from cte2
where 1=1
	and COUNTY_DIMENSION_TWO is null
	or COUNTY_DIMENSION_TWO = '0'
order by plan_type
	,PROV_NAME
