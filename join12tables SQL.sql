 select distinct EPD.FirstName+' '+EPD.LastName [employ name],BD.BankName,SCM.SubCasteName,
CM.CasteName,RM.ReligionId,CDM.ContactId,BOD.BloodGroupName,CIM.StateId,COM.CountryId,SM.StateId
from EmployeePersonalDetails EPD 
left join EmployeeBankDetails BD on EPD.EmployeeId=BD.EmployeeId
left join EmployeeEducationDetails ED on EPD.EmployeeId=ED.EmployeeId
LEFT join BloodGroupMaster BOD on EPD.BloodGroupId=BOD.BloodGroupId
left join SubCasteMasterTable SCM on EPD.SubCasteId=SCM.SubCasteId
left join CasteMasterTable CM on EPD.CasteId=CM.CasteId
left join ReligionMasterTable RM on EPD.ReligionId=RM.ReligionId
left join EmployeeContactDetails CDM on CDM.EmployeeId=EPD.EmployeeId


left join StateMasterTable SM on CDM.StateId=SM.StateId
left join CountryMasterTable COM on COM.CountryId=CDM.CountryId
left join CityMasterTable CIM on CIM.StateId=CDM.StateId