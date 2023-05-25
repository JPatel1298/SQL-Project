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

exec Set_AddEmployeNewDataISCheck  @fname='riya',@lastname='patel',@mobileno='7956234178',@EmailId='kajol34@gmail.com',@AccountNO ='BOB256866',@BankNAme='BOB',@DOB='1997/02/03',@Age=26,@FatherHusbandName='Mahesh',@homeaddress='Sunpharma road',@LandlineNO='234569823',
@skyeid='hfyt',@Employeename='kajol',@Branch='Vadodra',@AccountType='saving',
@Gender ='female',@Maritalstatus='single' ,@Citizenship=2 ,@Height='180' ,@Weight=56 ,
@BloodGroupId=5,@CasteId=1,@SubCasteId=4 ,@ReligionId=4,
@CreateBy=1 ,@CreateOn='2023/03/02' ,@UpDateBy=2,@UpdateOn='2022/01/01' ,@IsActive=1,
@LinkedinId ='jdfd@kf',@OfficeAddress='Sunphsrms road' ,@OfficeNo='2562432'  ,@CountryId=2 ,@StateId=2 ,@CityId=1 , 
@IFSCCode='BOB36438',@MICRno='2581k',@Qualification ='M.Sc' ,@School='Bright day school',@CollegeUniversity='Navrachna university' ,
@PassOutYear=2022,@Field='science', @Percentage=85,@occupation='Manager' ,@Dateofjoining='2023/02/01' ,@experience='2year',@Designation='senior' ,
@Currentcompany='ABB',@previouscompany='BGSS'
 

select*from EmployeePersonalDetails where FirstName='janki'

select*from EmployeeBankDetails where EmployeeName='janki gandhi'