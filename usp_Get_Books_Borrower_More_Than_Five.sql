USE [library]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.usp_Get_Books_Borrower_More_Than_Five'))
   EXEC('CREATE PROCEDURE [dbo].[usp_Get_Books_Borrower_More_Than_Five] AS BEGIN SET NOCOUNT ON; END')
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-----------------------------------------------------------------------------------------------------------
	Author:		Andrew Lorenz
	Date:		11/23/2018
	Usage:		EXEC usp_Get_Books_Borrower_More_Than_Five
	Purpose:	Retrieve total books checked out per borrowwer with more than five books
	Note:		Create & Alter procedure statements are used to avoid dropping the procedure and having to reapply
				any grants previously applied
-----------------------------------------------------------------------------------------------------------
*/

ALTER PROCEDURE [dbo].[usp_Get_Books_Borrower_More_Than_Five] 
AS

BEGIN

	SET NOCOUNT ON

-- 6.) Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out.

	SELECT  BorrowerName, BorrowerAddr, COUNT(*) AS 'Total Checked Out'
	FROM borrower b 
		JOIN book_loans bl ON bl.CardNo = b.CardNo
	GROUP BY b.CardNo, BorrowerName, BorrowerAddr 
	HAVING COUNT(*) > 5

END
GO
