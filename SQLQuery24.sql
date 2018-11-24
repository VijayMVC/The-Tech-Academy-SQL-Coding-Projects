-- 1.) How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

SELECT lb.BranchName, b.Title, bc.NumCopies
FROM book_copies bc
	JOIN library_branch lb on bc.BranchID = lb.BranchID
	JOIN books b ON bc.BookID = b.BookID
WHERE
	b.Title = 'The Lost Tribe'
	AND lb.BranchName = 'Sharpstown'


-- 2.) How many copies of the book titled "The Lost Tribe" are owned by each library branch?

SELECT b.Title, lb.branchName, bc.NumCopies
FROM book_copies bc
	JOIN library_branch lb ON bc.BranchID = lb.BranchID
	JOIN books b ON bc.BookID = b.BookID
WHERE
	b.Title = 'The Lost Tribe'

-- 3.) Retrieve the names of all borrowers who do not have any books checked out.

SELECT BorrowerName
FROM borrower bor
	LEFT OUTER JOIN book_loans bl ON bor.CardNo = bl.CardNo
WHERE bl.CardNo IS NULL

--or

SELECT BorrowerName
FROM borrower bor
WHERE NOT EXISTS (SELECT 1 FROM book_loans bl WHERE bl.CardNo = bor.CardNo)


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

-- 5.) For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

SELECT BranchName, SUM(NumCopies) AS 'Total Books'
FROM library_branch lb
	JOIN book_copies bc ON bc.BranchID = lb.BranchID
GROUP BY BranchName

-- 6.) Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out.

SELECT  BorrowerName, BorrowerAddr, COUNT(*) AS 'Total Checked Out'
FROM borrower b 
	JOIN book_loans bl ON bl.CardNo = b.CardNo
GROUP BY b.CardNo, BorrowerName, BorrowerAddr 
HAVING COUNT(*) > 5

-- 7.) For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the 
--     library branch whose name is "Central".

SELECT  lb.BranchName, b.Title, bc.NumCopies 
FROM book_authors ba
	JOIN books b ON b.BookID = ba.BookID
	JOIN book_copies bc ON bc.BookID = b.BookID
	JOIN library_branch lb ON lb.BranchID = bc.BranchID
WHERE 
	AuthorName like '%Stephen King%'
	AND lb.BranchName = 'Central'



update book_loans 
set DateOut = convert(DATE,'2018-11-2'), 
DateDue = CONVERT(DATE, '2018-11-23'),
BranchID = 1  
where BookID = 5 and BranchID = 4

