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

 exec  Set_AddEmployeNewDataLoginpassword  @fname='hemnt',@lastname='shah',@mobileno='47014471178',@EmailId='lkgnhs@gmail.com',
 @AccountNO ='BOB256816',@BankNAme='BOB',@DOB='1947/02/03',@Age=52,@FatherHusbandName='Maahesh',@homeaddress='Sunpharma road',@LandlineNO='234569823',
@skyeid='hf12@kjgg',@Employeename='kavaita',@Branch='Vadodra',@AccountType='saving',
@Gender ='female',@Maritalstatus='single' ,@Citizenship=1 ,@Height='180' ,@Weight=66 ,
@BloodGroupId=5,@CasteId=1,@SubCasteId=4 ,@ReligionId=4,
@CreateBy=1 ,@CreateOn='2023/03/02' ,@UpDateBy=2,@UpdateOn='2022/05/01' ,@IsActive=1,
@LinkedinId ='jdfd@kf',@OfficeAddress='Sunphsrms road' ,@OfficeNo='25624622'  ,@CountryId=7 ,@StateId=7 ,@CityId=1 , 
@IFSCCode='BOB36438',@MICRno='2581k',@Qualification ='B.Sc' ,@School='Bright day school',@CollegeUniversity='Navrachna university' ,
@PassOutYear=2022,@Field='science', @Percentage=85,@occupation='Manager' ,@Dateofjoining='2023/02/01' ,@experience='2year',@Designation='senior' ,
@Currentcompany='ABB',@previouscompany='BGSS',@mode=1,@employeeid=''

select*from LogIinTable