This Library Management System (LMS) consists of three primary entities: Books Data, Book Allotment, and Defaulters Data. Each of these entities is represented by a separate SAP ABAP table—zbooks, zbookallotment, and zdefaulters. The system is designed to manage library operations such as book availability, issuance, and defaulter tracking.

1. Books Data Table (zbooks)
Description:
This table stores essential information about the books available in the library, including the name, author, quantity, and status (available or issued). The library uses this table to manage its inventory.

Key Fields:

bookid: Unique identifier for each book.
bookname: The title of the book.
bookauthor: The author of the book.
quantity: Number of copies available in the library.
status: Indicates whether the book is available, issued, or reserved.
2. Book Allotment Table (zbookallotment)
Description:
This table tracks the allotment (borrowing) of books by users (students). It records the issue and expected submission (return) date for each issued book.

Key Fields:

bookallotmentids: Unique identifier for each book allotment.
bookids: Foreign key referencing the zbooks table.
studentids: Unique identifier for the student borrowing the book.
allotment_date: Date the book was issued.
submission_date: Expected date for returning the book.
3. Defaulters Data Table (zdefaulters)
Description:
This table keeps track of students who fail to return books by the due date and calculates penalties (fines) based on late submissions.

Key Fields:

defaulterid: Unique identifier for each defaulter.
bookids: Foreign key referencing the zbooks table (book being defaulted on).
studentids: Foreign key referencing the student table (student who defaulted).
penalty: Amount of fine to be paid by the defaulter.
currencycode: Currency in which the fine is calculated.
System Workflow:
Book Issuance:
When a student borrows a book, an entry is made in the zbookallotment table, recording the book's ID, the student’s ID, the date of issue, and the due date for return.

Book Return:
When the book is returned on or before the due date, the allotment record is updated with the return date. If the book is returned late, an entry is made in the zdefaulters table, calculating the fine based on the delay.

Tracking Defaulters:
The system checks overdue books and updates the zdefaulters table with the penalty amount, referencing the student and book IDs.

Key Benefits:
Efficient management of book inventory.
Automated tracking of book allotments and returns.
Fine calculation for defaulters, improving accountability.
This system helps libraries streamline the process of managing books, tracking issued items, and handling overdue penalties efficiently.

