-- =============================================
-- Author:		<Janki patel>
-- Create date: <13-03-2023>
-- Description:	<--password : YEAR + Age + FName last (2 Char) + EMPID+FName (2 AC) >
-- =============================================
alter PROCEDURE Set_AddEmployeNewDataLoginpassword
--Employee personalDetails
@Fname nvarchar(100),@LastName Nvarchar(100),@DOB datetime,@Age int,@FatherHusbandName nvarchar (100),@Gender nvarchar (20),
@Maritalstatus nvarchar(100),@Citizenship int,@Height decimal (10,2),@Weight int ,@BloodGroupId int,@CasteId int,@SubCasteId int,@ReligionId int,
@CreateBy int,@CreateOn datetime,@UpDateBy int,@UpdateOn datetime,@IsActive bit,
--employee Bank details
@AccountNO Nvarchar(50),@BankName nvarchar(100),@Employeename nvarchar (100),@Branch nvarchar (20),@AccountType nvarchar 
(10),@IFSCCode nvarchar(30),@MICRno nvarchar(50),
--Employee ContactDetails
@Mobileno nvarchar(20),@EmailID nvarchar(100),@homeaddress nvarchar (100),@LandlineNO nvarchar (30),@skyeid nvarchar (20),@LinkedinId nvarchar(100),
@OfficeAddress nvarchar(100),@OfficeNo nvarchar(20) ,@CountryId int ,@StateId int,@CityId int,
--EmployeeEducationDetails
@Qualification nvarchar(50),@School nvarchar(50),@CollegeUniversity nvarchar(50),@PassOutYear int,@Field nvarchar(50),@Percentage decimal,
--ExperienceDetails
@occupation nvarchar(50),@Dateofjoining datetime,@experience nvarchar(50),@Designation nvarchar(50),
@Currentcompany nvarchar(50),@previouscompany nvarchar(50),
@mode int,
@employeeid int

--password : YEAR + Age + FName last (2 Char) + EMPID+FName (2 AC) 

as
begin
if(@mode=1)
begin
 declare @GID int;
 declare @IsCheck int;

                    DECLARE @UserName nvarchar(100);
					DECLARE @Password nvarchar(100);
					declare @year nvarchar(100) ;
					declare @agee nvarchar(100);
			
				    declare @fnamee1 nvarchar (100)
					declare @fnamee2 nvarchar (100);
					declare @emplD int;
					


					set @UserName =@EmailId;
					set @year =(select(year(getdate())));
					set @agee= (select(datediff(year,@DOB,GETDATe())));
					set @fname = (select(Right(@Fname,2)));
					set @fnamee1=(select (ASCII(Left(@Fname,1))));
					set @fnamee2=(select ascii(SUBSTRING(@Fname,2,1)));
					
					
			       set @emplD=(Select MAX(employeeid) From EmployeePersonalDetails)+1

					set @Password= (select concat(@year,@agee,@fname,@fnamee1,@emplD,@fnamee2))



 	SET @Ischeck=(SELECT count(*) from EmployeePersonalDetails where FirstName=@Fname and DateOfBirth=@DOB)
	IF (@Ischeck=0)
				BEGIN
						insert into EmployeePersonalDetails (CreateOn,FirstName,LastName,DateOfBirth,IsActive)
						values(GETDATE(),@Fname,@LastName,@DOB,@isactive)
						set @gid=@@IDENTITY

						insert into EmployeeBankDetails (EmployeeId,BankName,EmployeeName,BankAccountNo,AccountType)
						values(@GID,@Employeename,@Bankname,@AccountNo,@AccountType)
					
					insert into EmployeeContactDetails (EmployeeId,MobileNo,EmailId,OfficeAddress)
					values(@GID,@MobileNo,@EmailID,@officeAddress)

					insert into LogIinTable (UserName,Password,EmployId,RollID,IsActive)
					 values(@UserName,@Password,@GID,1,1)
					 

							 Select @Gid UserId
                END
			 Else
			 Begin
			      Select '-1' UserId, @Ischeck UserCount,@fname,@lastname,@DOB
			 END
       END
if (@mode=2)
begin
 update EmployeePersonalDetails set FirstName=@Fname,LastName=@LastName,DateOfBirth=@DOB
 where EmployeeId=@employeeId
 update EmployeeBankDetails set BankName=@Bankname,BankAccountNo=@AccountNo,AccountType=@AccountType,EmployeeName=@Employeename
 where EmployeeId=@employeeId
 update EmployeeContactDetails set MobileNo=@MobileNo,EmailId=@EmailID,OfficeAddress=@officeAddress 
 where EmployeeId=@employeeid
 update LogIinTable set UserName=@EmailID,Password=@Password
 where EmployID=@employeeid 
 end
 end

 -- =============================================
-- Author:		<Janki patel>
-- Create date: <13-03-2023>
-- Description:	<Update Employe add login(exists)>

Create PROCEDURE [dbo].[sp_setLogin]
(
	@UserName varchar(50),
	@Password varchar(50)
)
AS
Begin
	IF EXISTS(SELECT LoginId from [dbo].[LogIinTable] where [UserName]=@UserName and [Password]=@Password and isActive=1)	
			BEGIN
				  Select *From EmployeePersonalDetails EP join [dbo].[LogIinTable]  TL
				  on TL.EmployID=ep.EmployeeId where TL.UserName=@UserName and TL.Password=@Password and
				  EP.IsActive=1 and TL.IsActive=1
			END
	Else
	Begin
		select -1 LoginId
	End
END
--FunctionSalarySlip
Alter function GetSalary_sleepOfEmployee
(
@employeID int
)
Returns @netPay Table
(
houseAllowances decimal(10,3),
conveyanceallowence decimal(10,3),
medicalallowence int,
specialallowence int,
grosssalary int,
EPF int,
Healthinsurance int,
ProfessionalTax int,
TDS int,
salary decimal(10,3)
)
As
Begin
Declare @houseAllowances decimal
Declare @conveyanceallowence decimal
Declare @medicalallowence int
Declare @specialallowence int
Declare @grosssalary int
Declare @EPF int
Declare @Healthinsurance int
Declare @ProfessionalTax int
Declare @TDS int
declare @salary decimal

set @salary =(select Salary from EmployeePersonalDetails where EmployeeId=@employeID)
set @houseAllowances =(((select Salary from EmployeePersonalDetails where EmployeeId=@employeID)-(@salary))*15)/100
set @conveyanceallowence =(((select Salary from EmployeePersonalDetails where EmployeeId=@employeID)-(@salary))*15)/100

insert into @netpay (houseAllowances,conveyanceallowence ,medicalallowence,specialallowence,grosssalary 
,EPF ,Healthinsurance ,ProfessionalTax ,TDS,salary)
values (@houseAllowances,@conveyanceallowence,@medicalallowence,@specialallowence,@grosssalary,@EPF,@Healthinsurance,
@ProfessionalTax,@TDS,@salary)
return
end

-- =============================================
-- Author:		<Janki patel>
-- Create date: <09-03-2023>
-- Description:	<Add Employe New Data>
-- =============================================
ALTER PROCEDURE Set_AddEmployeNewDataISCheck
--Employee personalDetails
@Fname nvarchar(100),@LastName Nvarchar(100),@DOB datetime,@Age int,@FatherHusbandName nvarchar (100),@Gender nvarchar (20),
@Maritalstatus nvarchar(100),@Citizenship int,@Height decimal (10,2),@Weight int ,@BloodGroupId int,@CasteId int,@SubCasteId int,@ReligionId int,
@CreateBy int,@CreateOn datetime,@UpDateBy int,@UpdateOn datetime,@IsActive bit,
--employee Bank details
@AccountNO Nvarchar(50),@BankName nvarchar(100),@Employeename nvarchar (100),@Branch nvarchar (20),@AccountType nvarchar 
(10),@IFSCCode nvarchar(30),@MICRno nvarchar(50),
--Employee ContactDetails
@Mobileno nvarchar(20),@EmailID nvarchar(100),@homeaddress nvarchar (100),@LandlineNO nvarchar (30),@skyeid nvarchar (20),@LinkedinId nvarchar(100),
@OfficeAddress nvarchar(100),@OfficeNo nvarchar(20) ,@CountryId int ,@StateId int,@CityId int,
--EmployeeEducationDetails
@Qualification nvarchar(50),@School nvarchar(50),@CollegeUniversity nvarchar(50),@PassOutYear int,@Field nvarchar(50),@Percentage decimal,
--ExperienceDetails
@occupation nvarchar(50),@Dateofjoining datetime,@experience nvarchar(50),@Designation nvarchar(50),
@Currentcompany nvarchar(50),@previouscompany nvarchar(50)
as
begin
 declare @GID int;
 declare @IsCheck int
 	SET @Ischeck=(SELECT count(*) from EmployeePersonalDetails where FirstName=@Fname and DateOfBirth=@DOB)
	IF (@Ischeck=0)
				BEGIN
						insert into EmployeePersonalDetails (CreateOn,FirstName,LastName,DateOfBirth,IsActive)
						values(GETDATE(),@Fname,@LastName,@DOB,@isactive)
						set @gid=@@IDENTITY

						insert into EmployeeBankDetails (EmployeeId,BankName,EmployeeName,BankAccountNo,AccountType)
						values(@GID,@Employeename,@Bankname,@AccountNo,@AccountType)
					
					insert into EmployeeContactDetails (EmployeeId,MobileNo,EmailId,OfficeAddress)
					values(@GID,@MobileNo,@EmailID,@officeAddress)
							 Select @Gid UserId
                END
			 Else
			 Begin
			      Select -1 UserId, @Ischeck UserCount,@fname,@lastname,@DOB
			 END
       
end

--Jions 12 table os employee
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
