/*Day 1
https://www.namastesql.com/coding-problem/8-library-borrowing-habits?page=1&pageSize=10

Imagine you're working for a library and you're tasked with generating a report on the borrowing habits of patrons. You have two tables in your database: Books and Borrowers.
Write an SQL to display the name of each borrower along with a comma-separated list of the books they have borrowed in alphabetical order, display the output in ascending order of Borrower Name.

## Tables
- **Books**:
  | Column Name | Data Type   |
  |-------------|-------------|
  | BookID      | int         |
  | BookName    | varchar(30) |
  | Genre       | varchar(20) |
- **Borrowers**:
  | Column Name  | Data Type   |
  |--------------|-------------|
  | BorrowerID   | int         |
  | BorrowerName | varchar(10) |
  | BookID       | int         |
*/

SELECT
	Borrowers.BorrowerName,
    string_agg(Books.BookName, ', ' ORDER BY Books.BookName) AS list_books
FROM Borrowers
LEFT JOIN Books ON Books.BookID=Borrowers.BookID
GROUP BY BorrowerName
ORDER BY Borrowers.BorrowerName;
