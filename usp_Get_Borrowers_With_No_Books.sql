USE [library]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.usp_Get_Borrowers_With_No_Books'))
   EXEC('CREATE PROCEDURE [dbo].[usp_Get_Borrowers_With_No_Books] AS BEGIN SET NOCOUNT ON; END')
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-----------------------------------------------------------------------------------------------------------
	Author:		Andrew Lorenz
	Date:		11/23/2018
	Usage:		EXEC usp_Get_Borrowers_With_No_Books
	Purpose:	Retrieve borrows names with no books checked out 
	Note:		Create & Alter procedure statements are used to avoid dropping the procedure and having to reapply
				any grants previously applied
-----------------------------------------------------------------------------------------------------------
*/

ALTER PROCEDURE [dbo].[usp_Get_Borrowers_With_No_Books] 
AS

BEGIN

	SET NOCOUNT ON
-- 3.) Retrieve the names of all borrowers who do not have any books checked out.

	SELECT BorrowerName
	FROM borrower bor
		LEFT OUTER JOIN book_loans bl ON bor.CardNo = bl.CardNo
	WHERE bl.CardNo IS NULL

	--or

	SELECT BorrowerName
	FROM borrower bor
	WHERE NOT EXISTS (SELECT 1 FROM book_loans bl WHERE bl.CardNo = bor.CardNo)

END
GO
