
--konse country me kitane  employee h
select  CM.CountryName,count(EC.EmployeeId)
from CountryMasterTable CM left join EmployeeContactDetails EC on EC.CountryId=CM.CountryId
group by CM.CountryName

--konse State me kite  employee h
select  SM.StateNames,count(EC.EmployeeId)
from StateMasterTable SM left join EmployeeContactDetails EC on EC.StateId=SM.StateId
group by sm.StateNames

--konse city me kite  employee h
select CMt.CityNames ,count(EC.EmployeeId)
from CityMasterTable CMT left join EmployeeContactDetails EC on EC.CityId=CMT.CityId
group by CMT.CityNames

--konse religion ke kitane employee h
select RM.ReligionName,count(EP.EmployeeId) from ReligionMasterTable RM 
left join EmployeePersonalDetails EP on RM.ReligionId=EP.ReligionId
group by RM.ReligionName

--konse BloodGroup ke kitane employee h
select BM.BloodGroupName,count(EP.EmployeeId) from BloodGroupMaster BM
left join EmployeePersonalDetails EP on BM.BloodGroupId=EP.BloodGroupId
group by BM.BloodGroupName

--konse Cast ke kitane employee h
select CM.CasteName,count(EP.EmployeeId) from CasteMasterTable CM
left join EmployeePersonalDetails EP on CM.CasteId=EP.CasteId
group by CM.CasteName

--konse SubCast ke kitane employee h
select SCM.SubCasteName,count(EP.EmployeeId) from SubCasteMasterTable SCM
left join EmployeePersonalDetails EP on SCM.SubCasteId=EP.SubCasteId
group by SCM.SubCasteName

--konse country me konse state me kitne employee h
select  CM.CountryName,SM.StateNames, count(EC.EmployeeId)
from  EmployeeContactDetails EC
left join CountryMasterTable CM on EC.CountryId=CM.CountryId
left join StateMasterTable SM on EC.StateId=SM.StateId
group by CM.CountryName,SM.StateNames
order by CountryName DESC

