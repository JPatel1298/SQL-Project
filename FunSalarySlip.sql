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

select*from GetSalary_sleepOfEmployee (1002)
select*from EmployeePersonalDetails
