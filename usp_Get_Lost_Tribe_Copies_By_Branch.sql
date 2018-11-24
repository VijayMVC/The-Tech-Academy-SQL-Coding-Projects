USE [library]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.usp_Get_Lost_Tribe_Copies_By_Branch'))
   EXEC('CREATE PROCEDURE [dbo].[usp_Get_Lost_Tribe_Copies_By_Branch] AS BEGIN SET NOCOUNT ON; END')
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-----------------------------------------------------------------------------------------------------------
	Author:		Andrew Lorenz
	Date:		11/23/2018
	Usage:		EXEC usp_Get_Lost_Tribe_Copies_By_Branch
	Purpose:	Return the number of copies of the book titled "The Lost Tribe"  owned by each library branch 
	Note:		Create & Alter procedure statements are used to avoid dropping the procedure and having to reapply
				any grants previously applied
-----------------------------------------------------------------------------------------------------------
*/

ALTER PROCEDURE [dbo].[usp_Get_Lost_Tribe_Copies_By_Branch] 
AS

BEGIN

	SET NOCOUNT ON
-- 2.) How many copies of the book titled "The Lost Tribe" are owned by each library branch?

	SELECT b.Title, lb.branchName, bc.NumCopies
	FROM book_copies bc
		JOIN library_branch lb ON bc.BranchID = lb.BranchID
		JOIN books b ON bc.BookID = b.BookID
	WHERE
		b.Title = 'The Lost Tribe'

END
GO
