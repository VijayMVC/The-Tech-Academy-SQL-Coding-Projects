USE [library]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.usp_Get_Books_Borrower_Due_Today_At_Sharpstown'))
   EXEC('CREATE PROCEDURE [dbo].[usp_Get_Books_Borrower_Due_Today_At_Sharpstown] AS BEGIN SET NOCOUNT ON; END')
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-----------------------------------------------------------------------------------------------------------
	Author:		Andrew Lorenz
	Date:		11/23/2018
	Usage:		EXEC usp_Get_Books_Borrower_Due_Today_At_Sharpstown
	Purpose:	Return books and borrowers for books due today at Sharpstown branch 
	Note:		Create & Alter procedure statements are used to avoid dropping the procedure and having to reapply
				any grants previously applied
-----------------------------------------------------------------------------------------------------------
*/

ALTER PROCEDURE [dbo].[usp_Get_Books_Borrower_Due_Today_At_Sharpstown] 
AS

BEGIN

	SET NOCOUNT ON

-- 4.) For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, 
--	   retrieve the book title, the borrower's name, and the borrower's address.

	SELECT lb.BranchName, b.Title, bor.BorrowerName, bor.BorrowerAddr, bl.DateDue
	FROM books b 
		JOIN book_loans bl ON b.BookID = bl.BookID
		JOIN borrower bor ON bor.CardNo = bl.CardNo
		JOIN library_branch lb ON lb.BranchID = bl.BranchID
	WHERE 
		bl.DateDue = CONVERT(DATE, GETDATE())
		AND lb.BranchName = 'Sharpstown'

END
GO
