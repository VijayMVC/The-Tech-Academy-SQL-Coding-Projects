USE [library]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.usp_Get_Books_Loaned_By_Branch'))
   EXEC('CREATE PROCEDURE [dbo].[usp_Get_Books_Loaned_By_Branch] AS BEGIN SET NOCOUNT ON; END')
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-----------------------------------------------------------------------------------------------------------
	Author:		Andrew Lorenz
	Date:		11/23/2018
	Usage:		EXEC usp_Get_Books_Loaned_By_Branch
	Purpose:	Retrieve total number of books loaned out by branch
	Note:		Create & Alter procedure statements are used to avoid dropping the procedure and having to reapply
				any grants previously applied
-----------------------------------------------------------------------------------------------------------
*/

ALTER PROCEDURE [dbo].[usp_Get_Books_Loaned_By_Branch] 
AS

BEGIN

	SET NOCOUNT ON

-- 5.) For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

	SELECT BranchName, SUM(NumCopies) AS 'Total Books'
	FROM library_branch lb
		JOIN book_copies bc ON bc.BranchID = lb.BranchID
	GROUP BY BranchName

END
GO