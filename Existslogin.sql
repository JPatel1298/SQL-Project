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