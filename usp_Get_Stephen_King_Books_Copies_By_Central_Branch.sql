USE [library]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.usp_Get_Stephen_King_Books_Copies_By_Central_Branch'))
   EXEC('CREATE PROCEDURE [dbo].[usp_Get_Stephen_King_Books_Copies_By_Central_Branch] AS BEGIN SET NOCOUNT ON; END')
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-----------------------------------------------------------------------------------------------------------
	Author:		Andrew Lorenz
	Date:		11/23/2018
	Usage:		EXEC usp_Get_Stephen_King_Books_Copies_By_Central_Branch
	Purpose:	Retrieve Title and #copies of books authored/coauthored by Stephen King at the Central library branch
	Note:		Create & Alter procedure statements are used to avoid dropping the procedure and having to reapply
				any grants previously applied
-----------------------------------------------------------------------------------------------------------
*/

ALTER PROCEDURE [dbo].[usp_Get_Stephen_King_Books_Copies_By_Central_Branch] 
AS

BEGIN

	SET NOCOUNT ON

-- 7.) For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the 
--     library branch whose name is "Central".

	SELECT  lb.BranchName, ba.AuthorName, b.Title, bc.NumCopies 
	FROM book_authors ba
		JOIN books b ON b.BookID = ba.BookID
		JOIN book_copies bc ON bc.BookID = b.BookID
		JOIN library_branch lb ON lb.BranchID = bc.BranchID
	WHERE 
		ba.AuthorName like '%Stephen King%'
		AND lb.BranchName = 'Central'

END
GO