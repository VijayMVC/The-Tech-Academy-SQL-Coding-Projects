USE [library]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.usp_Get_Lost_Tribe_Copies_By_Sharpstown'))
   EXEC('CREATE PROCEDURE [dbo].[usp_Get_Lost_Tribe_Copies_By_Sharpstown] AS BEGIN SET NOCOUNT ON; END')
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
-----------------------------------------------------------------------------------------------------------
	Author:		Andrew Lorenz
	Date:		11/23/2018
	Usage:		EXEC usp_Get_Lost_Tribe_Copies_By_Sharpstown
	Purpose:	Return the number of copies of the book titled "The Lost Tribe"  owned by the library branch "Sharpstown"
	Note:		Create & Alter procedure statements are used to avoid dropping the procedure and having to reapply
				any grants previously applied
-----------------------------------------------------------------------------------------------------------
*/

ALTER PROCEDURE [dbo].[usp_Get_Lost_Tribe_Copies_By_Sharpstown] 
AS

BEGIN

	SET NOCOUNT ON

	SELECT lb.BranchName, b.Title, bc.NumCopies
	FROM book_copies bc
		JOIN library_branch lb on bc.BranchID = lb.BranchID
		JOIN books b ON bc.BookID = b.BookID
	WHERE
		b.Title = 'The Lost Tribe'
		AND lb.BranchName = 'Sharpstown'
END
GO
