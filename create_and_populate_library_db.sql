USE [master]
GO
/* -------------------------------------- */
/* CREATE THE LIBRARY DATABASE            */
/* -------------------------------------- */
CREATE DATABASE [library]
GO

/* Set compatibility level to MS SQL 2014 */
ALTER DATABASE [library] SET COMPATIBILITY_LEVEL = 120
GO

/* -------------------------------------------------------------------------------------------------------- */
/*  Create tables with Primary Keys First, then the tables with foreign keys that reference those tables    */
/* -------------------------------------------------------------------------------------------------------- */

CREATE TABLE library..library_branch (
		BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		BranchName VARCHAR(50) NOT NULL,
		BranchAddr VARCHAR(75)
		);

CREATE TABLE library..publisher (
		PublisherName VARCHAR(75) PRIMARY KEY NOT NULL,
		PublisherAddr VARCHAR(75),
		Phone VARCHAR(15) -- accomodates international numbers 
		);

CREATE TABLE library..books (
		BookID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		Title VARCHAR(75) NOT NULL,
		PublisherName VARCHAR(75) NOT NULL CONSTRAINT FK__books__publisher FOREIGN KEY REFERENCES library..publisher(PublisherName) ON UPDATE CASCADE ON DELETE CASCADE,
		);
		--ALTER TABLE library..books ALTER COLUMN [Title] VARCHAR(75) NOT NULL

CREATE TABLE library..borrower (
		CardNo INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		BorrowerName VARCHAR(75),
		BorrowerAddr VARCHAR(75) NOT NULL,
		Phone VARCHAR(15) -- accomodates international numbers 
		);

CREATE TABLE library..book_copies (
		BookID INT NOT NULL CONSTRAINT FK__book_copies__books FOREIGN KEY REFERENCES library..books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT NOT NULL CONSTRAINT FK__book_copies__library_branch FOREIGN KEY REFERENCES library..library_branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		NumCopies INT NOT NULL
		);

CREATE TABLE library..book_loans (
		BookID INT NOT NULL CONSTRAINT FK__book_loans__books FOREIGN KEY REFERENCES library..books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT NOT NULL CONSTRAINT FK__book_loans__library_branch FOREIGN KEY REFERENCES library..library_branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		CardNo INT NOT NULL CONSTRAINT FK__book_loans__borrower FOREIGN KEY REFERENCES library..borrower(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
		DateOut DATE,
		DateDue DATE
		);

CREATE TABLE library..book_authors (
		BookID INT NOT NULL CONSTRAINT FK__book_authors__books FOREIGN KEY REFERENCES library..books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		AuthorName VARCHAR(75)
		);
GO

/* ----------------------------------------------------------------------------------------------- */
/* ----------------------------------- POPULATE LIBRARY_BRANCH ----------------------------------- */
/* ----------------------------------------------------------------------------------------------- */

INSERT INTO library..library_branch
VALUES
	('Sharpstown','2300 NW Thurnam St, Portland OR 97210'),
	('Central','801 SW 10th Ave, Portland OR 97205'),
	('Albina','3605 NE 15th Ave, Portland OR 97212'),
	('Hollywood','4040 NE Tilamook St, Portland OR 97212'),
	('Belmont','1038 SE Cesar Chavez Blvd, Portland OR 97214')
;

--select * from library..library_branch

/* ------------------------------------------------------------------------------------------------ */
/* ----------------------------------- POPULATE PUBLISHER ----------------------------------------- */
/* ------------------------------------------------------------------------------------------------ */

INSERT INTO library..publisher
VALUES
	('Penguin Random House','1234 W Elm Lane, Mayberry, VA 12345','(355) 672-2755'),
	('Hachette Livre','595 W. Lafayette St. Chardon, OH 44024','(633) 532-9372'),
	('HarperCollins','9776 San Pablo Rd. Zion, IL 60099','(960) 558-2487'),
	('Simon Schuster','526 Grant Circle Trumbull, CT 06611','(895) 276-6481'),
	('Doubleday','693 Amerige St. Lowell, MA 01851','(275) 397-3926'), -- Stephen King The Shining
	('Viking Press','7568 Oklahoma Road Uniondale, NY 11553','(474) 720-3439') -- Stephen King Misery
;

--select * from library..publisher

--update A 
--set contact_name = (select value from B where B.invoice_id = A.invoice_id);

/* ----------------------------------------------------------------------------------------------- */
/* ----------------------------------- POPULATE BOOKS -------------------------------------------- */
/* ----------------------------------------------------------------------------------------------- */

INSERT INTO library..books
VALUES
	('The Lost Tribe','Viking Press'),
	('The Shining','Doubleday'),
	('Misery','Viking Press'),
	('Misadventures with a Professor','Simon Schuster'),	
	('The Art of Crash Landing','Penguin Random House'),
	('Past Tense','Hachette Livre'),
	('Ivy Granger Psychic Detective','HarperCollins'),
	('Worthy Brown''s Daughter','Simon Schuster'),
	('Patient Zero','Penguin Random House'),
	('The Light We Lost','Hachette Livre'),
	('Look Alive Twenty-Five','HarperCollins'),
	('Elevation','Doubleday'),
	('Two Sisters','Simon Schuster'),
	('Little Big Love','Penguin Random House'),
	('Summer Seduction','Hachette Livre'),
	('The Hate U Give','HarperCollins'),
	('Highlander Most Wanted','Doubleday'),
	('Killing the SS','Doubleday'),
	('Heads You Win','Penguin Random House'),
	('The Devil in Winter','Hachette Livre'),
	('Unsheltered','HarperCollins'),
	('On the Front Line','Simon Schuster')

--select * from library..books

--update library..books
--set Title = 'The Hate U Give'
--where Title = 'Eisenhower in War and PeaSimon Schusterce'

/* ----------------------------------------------------------------------------------------------- */
/* ----------------------------------- POPULATE BOOK_AUTHORS ------------------------------------- */
/* ----------------------------------------------------------------------------------------------- */

INSERT INTO library..book_authors SELECT BookID, 'Stephen King' FROM library..books WHERE Title = 'Misery'
INSERT INTO library..book_authors SELECT BookID, 'Stephen King' FROM library..books WHERE Title = 'The Shining'
INSERT INTO library..book_authors SELECT BookID, 'Edward Marriott' FROM library..books WHERE Title = 'The Lost Tribe'
INSERT INTO library..book_authors SELECT BookID, 'Sierra Simone' FROM library..books WHERE Title = 'Misadventures with a Professor'
INSERT INTO library..book_authors SELECT BookID, 'Melissa DeCarlo' FROM library..books WHERE Title = 'The Art of Crash Landing'
INSERT INTO library..book_authors SELECT BookID, 'Lee Child' FROM library..books WHERE Title = 'Past Tense'
INSERT INTO library..book_authors SELECT BookID, 'EJ Stevens' FROM library..books WHERE Title = 'Ivy Granger Psychic Detective'
INSERT INTO library..book_authors SELECT BookID, 'Phillip Margolin' FROM library..books WHERE Title = 'Worthy Brown''s Daughter'
INSERT INTO library..book_authors SELECT BookID, 'Jonathan Maberry' FROM library..books WHERE Title = 'Patient Zero'
INSERT INTO library..book_authors SELECT BookID, 'Jill Santopolo' FROM library..books WHERE Title = 'The Light We Lost'
INSERT INTO library..book_authors SELECT BookID, 'Janet Evanovich' FROM library..books WHERE Title = 'Look Alive Twenty-Five'
INSERT INTO library..book_authors SELECT BookID, 'Stephen King' FROM library..books WHERE Title = 'Elevation'
INSERT INTO library..book_authors SELECT BookID, 'Asne Seierstad' FROM library..books WHERE Title = 'Two Sisters'
INSERT INTO library..book_authors SELECT BookID, 'Katy Regan' FROM library..books WHERE Title = 'Little Big Love'
INSERT INTO library..book_authors SELECT BookID, 'Rachel Van Dyken' FROM library..books WHERE Title = 'Summer Seduction'
INSERT INTO library..book_authors SELECT BookID, 'Angie Thomas' FROM library..books WHERE Title = 'The Hate U Give'
INSERT INTO library..book_authors SELECT BookID, 'Vanessa Kelly' FROM library..books WHERE Title = 'Highlander Most Wanted'
INSERT INTO library..book_authors SELECT BookID, 'Bill O''Reilly & Martin Dugard' FROM library..books WHERE Title = 'Killing the SS'
INSERT INTO library..book_authors SELECT BookID, 'Jeffrey Archer' FROM library..books WHERE Title = 'Heads You Win'
INSERT INTO library..book_authors SELECT BookID, 'Lisa Kleypas' FROM library..books WHERE Title = 'The Devil in Winter'
INSERT INTO library..book_authors SELECT BookID, 'Barbara Kingsolver' FROM library..books WHERE Title = 'Unsheltered'
INSERT INTO library..book_authors SELECT BookID, 'Stacey Dooley' FROM library..books WHERE Title = 'On the Front Line'

--select * from library..book_authors order by 2

/* ----------------------------------------------------------------------------------------------- */
/*----------------------------------- POPULATE BORROWER ------------------------------------------ */
/* ----------------------------------------------------------------------------------------------- */


INSERT INTO library..borrower
VALUES
('James Cagney','10 San Pablo Dr. Stoughton, MA 02072','(542) 363-6408'),
('Madonna','18 West Magnolia Lane Benton Harbor, MI 49022','(849) 571-2246'),
('George Clooney','50 West Bay Meadows Lane Parkersburg, WV 26101','(477) 372-6069'),
('Andy Riley','795 S. Fawn Lane Dover, NH 03820','(264) 569-1555'),
('David Roach','8058 Mechanic Lane Leominster, MA 01453','(917) 477-4118'),
('Lisa Lucy','22 East Walnutwood St. Coachella, CA 92236','(359) 277-1236'),
('King Kong','364 Pulaski Court La Vergne, TN 37086','(409) 572-8435'),
('Mothra','11 Pleasant Street Annapolis, MD 21401','(414) 287-7058'),
('Homer Simpson','932 Orchard Rd. Lewis Center, OH 43035','(363) 719-0882'),
('Lisa Simpson','9747 Schoolhouse St. Yorktown, VA 23693','(523) 309-3856'),
('Dori','2242 Wallaby Ln. Sydney, FL 33527','(533) 929-4837'),
('Janis Joplin','310 Cactus Lane Flemington, NJ 08822','(795) 662-2744'),
('Edgar Casey','27985 Fawn Street Ashland, OH 44805','(405) 332-2317'),
('Elon Musk','29922 Rocky River Ave. Daphne, AL 36526','(213) 419-5436'),
('Oprah Winfrey','90 West Glenwood Street Grand Haven, MI 49417','(395) 706-6656')
;

--select * from library..borrower

/* ----------------------------------------------------------------------------------------------- */
/* ----------------------------------- POPULATE BOOK_COPIES -------------------------------------- */
/* ----------------------------------------------------------------------------------------------- */


-- Populate book_copies
-- Need to make sure we maintain referential integrity with both foreign keys
-- Doing this programmatically with a cursor that loops through all the library branches.  For each library branch,
-- we assign a random number of titles (between 10 and the total titles existing), and a random number of copies of that
-- title (between 2 and 5)
DECLARE @num_titles INT,	-- a random number of titles to assign to a library branch (minimum is 10, max is total available titles)
		@BranchID INT,		-- branch ID of current cursor position
		@BookID	INT,
		@total_titles INT,	-- total number of titles available
		@cntr INT,			-- counter for a WHILE loop
		@min_titles INT = 10, -- minuimum number of titles per branch
		@num_copies INT,	--  a random number of copies of a title to assign to a branch between 2 and 5
		@min_copies INT = 2,
		@max_copies INT = 5

DECLARE branch_cur CURSOR FOR 
SELECT BranchID 
FROM library..library_branch

-- Get total number of titles available
SELECT @total_titles = (SELECT COUNT(*) FROM library..books)

OPEN branch_cur
FETCH NEXT FROM branch_cur into @BranchID

WHILE @@FETCH_STATUS = 0
  BEGIN
--	SELECT  BranchName from library..library_branch where BranchID = @BranchID
	-- pick a random number between 10 and the total available titles
	-- 10 (minimum) is a design requirement
	SELECT @num_titles = (SELECT FLOOR(RAND() * (@total_titles - @min_titles+1)) + @min_titles)
	
--	SELECT @num_titles

	SELECT @cntr = 1
	WHILE  @cntr <=  @num_titles
	BEGIN
		--pick random title not already assigned to this branch
		SELECT @BookID = 
			(SELECT TOP 1 BookID FROM library..books b 
			 WHERE NOT EXISTS (SELECT * FROM library..book_copies bc WHERE b.BookID = bc.BookID AND bc.BranchID = @BranchID)
			 ORDER BY NEWID()) -- This clause creates the randomness
		-- pick random number of copies
		SELECT @num_copies = (SELECT FLOOR(RAND() * (@max_copies - @min_copies+1)) + @min_copies)

		-- add the row 
		INSERT INTO library..book_copies
		VALUES
			(@BookID, @BranchID, @num_copies)
		SELECT @cntr = @cntr + 1
	END
	-- get next library branch
	FETCH NEXT FROM branch_cur into @BranchID
  END

CLOSE branch_cur
DEALLOCATE branch_cur
GO

/* ----------------------------------------------------------------------------------------------- */
/* ----------------------------------- POPULATE BOOK_LOANS --------------------------------------- */
/* ----------------------------------------------------------------------------------------------- */

-- Requirement: Ensure there are at least 50 entries
-- As my own personal challenge:
--	1) do not allocate more book copies than are available for checkout at a particular branch
--	2) borrowers can not have concurrent duplicate titles
--	3) Set the checkout date to between 1 and 21 days before db population date
--	   and due date to 21 days from checkout date

-- copy data from book_copies to temp table so we can decrement the number of copies
-- without affecting the original table
-- select sum(NumCopies) from library..book_copies
SELECT * INTO #book_copies FROM library..book_copies 

-- select * from #book_copies
-- select sum(NumCopies) from #book_copies 
-- drop table #book_copies

-- select * from library..book_loans

DECLARE @CurCardNo INT,  -- current borrower as we loop with cursor
		@BorrowerName VARCHAR(75),
		@BookID INT,
		@BranchID INT,
		@DateOut DATE,	-- Book checkout date
		@DateDue DATE,	-- Due date

		@num_books INT,	-- number of books current borrower can have checked out.  Will be between @max_books and @min_books
		@max_books INT = 5, -- upper limit for random # of books
		@min_books INT = 2, -- lower limit for random # of books

		@max_days INT = 21, -- upper limit for random number of days to subract from current date -- 3 weeks is normal checkout period
		@min_days INT = 1,  -- lower limit for random number of days
		@num_days INT, -- Will hold random number between 1 and 21 days and will be subtracted from curent date to simulate checkout date.

		@cntr INT; -- loop counter to keep track of books loaned out to a borrower
		
DECLARE borrower_cur CURSOR FOR 
	SELECT CardNo 
	FROM library..borrower
	WHERE BorrowerName NOT IN ('Homer Simpson') -- Homer Simpson doesn't read books, so he will have 0 books borrowed

OPEN borrower_cur
FETCH NEXT FROM borrower_cur INTO @CurCardNo

WHILE @@FETCH_STATUS = 0
	BEGIN
		--pick a random number of books to checkout
		SELECT @num_books = (SELECT FLOOR(RAND() * (@max_books - @min_books+1)) + @min_books)
		SELECT @cntr = 1

		--special case - req'ts say we need at least to  borrowers  with 5 or more books checked out
		SELECT @BorrowerName = (SELECT BorrowerName from library..borrower WHERE CardNo = @CurCardNo)
		IF @BorrowerName = 'Mothra'  -- Mothra likes to read to her caterpillars
			SELECT @num_books = 8
		ELSE IF @BorrowerName = 'King Kong' -- King Kong likes to hoard books and takes what he wants
			SELECT @num_books = 18


		WHILE @cntr <= @num_books -- This is per borrower
		BEGIN
			-- Get random entry from #book_copies where number of available copies i.e., NumCopies > 0 and not already checked out by borrower
			-- Use a CTE because we need two variables. We can only assign one var with a subselect since subselects are treated as expressions
			WITH cteBookBranch (BookID, BranchID) AS
				(SELECT TOP 1 BookID, BranchID FROM library..book_copies bc 
				WHERE NumCopies > 0  
					AND NOT EXISTS (SELECT * FROM library..book_loans bl WHERE bl.BookID = bc.BookID AND bl.CardNo = @CurCardNo)
				ORDER BY NEWID())
			
			SELECT	@BookID = BookID, 
					@BranchID = BranchID 
			FROM cteBookBranch

			-- Get a random number of days between 1 and 21 to simulate checkout date 
			SELECT @num_days = (SELECT FLOOR(RAND() * (@max_days - @min_days+1)) + @min_days)

			-- calculate checkout and due dates
			SELECT @DateOut = DATEADD(DAY, -@num_days, GETDATE())	-- subract up to 21 days from current date
			SELECT @DateDue = DATEADD(DAY, @max_days, @DateOut)		-- add 3 weeks to checkout date for due date

			INSERT INTO library..book_loans
			VALUES
				(@BookID, @BranchID, @CurCardNo, @DateOut, @DateDue)
			
			-- increment the number of books allocated to borrower; 
			SELECT @cntr = @cntr + 1
	
			-- decrement the number of copies avaialable 
			UPDATE #book_copies
			SET 
				NumCopies = NumCopies - 1 
			WHERE
				BookID = @BookID
				AND BranchID = @BranchID
		END

		-- get the next borrower
		FETCH NEXT FROM borrower_cur INTO @CurCardNo
	END
	
CLOSE borrower_cur
DEALLOCATE borrower_cur

DROP TABLE #book_copies
GO

-- select * from library..book_loans
-- check for duplicate titles allocated to a borrower
--	select CardNo, BookID, count(*) from library..book_loans group by CardNo, BookID having count(*) > 1
--	delete from library..book_loans

