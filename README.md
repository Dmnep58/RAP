📚 Library Management System (LMS)
This Library Management System (LMS) is designed to manage library operations such as book availability, issuance, and defaulter tracking. The system is implemented using SAP ABAP and consists of three primary entities, represented by separate tables: Books Data, Book Allotment, and Defaulters Data.

⚙️ System Overview
The LMS system handles three main entities:

Books Data (zbooks)
Book Allotment (zbookallotment)
Defaulters Data (zdefaulters)
The system ensures efficient library management by tracking:

Available books and their details.
The issuance and return process for borrowed books.
Defaulters and fines for overdue books.
🗂️ Table Structures
1. Books Data Table (zbooks)
This table stores essential information about the books available in the library, including book details and their current status.

Key Fields:
bookid: Unique identifier for each book.
bookname: The title of the book.
bookauthor: The author of the book.
quantity: Number of copies available in the library.
status: Indicates whether the book is available, issued, or reserved.
2. Book Allotment Table (zbookallotment)
This table tracks the allotment (borrowing) of books by users (students). It records both the issuance and the expected return date for each borrowed book.

Key Fields:
bookallotmentids: Unique identifier for each book allotment.
bookids: Foreign key referencing the zbooks table.
studentids: Unique identifier for the student borrowing the book.
allotment_date: Date the book was issued.
submission_date: Expected date for returning the book.
3. Defaulters Data Table (zdefaulters)
This table tracks students who fail to return books by the due date and calculates penalties (fines) based on late submissions.

Key Fields:
defaulterid: Unique identifier for each defaulter.
bookids: Foreign key referencing the zbooks table (book being defaulted on).
studentids: Foreign key referencing the student table (student who defaulted).
penalty: Amount of fine to be paid by the defaulter.
currencycode: Currency in which the fine is calculated.
🚦 System Workflow
1. Book Issuance:
When a student borrows a book:

An entry is made in the zbookallotment table, recording the book’s ID, student’s ID, the date of issue, and the due date for return.
2. Book Return:
When the book is returned on or before the due date, the zbookallotment record is updated.
If the book is returned late, an entry is made in the zdefaulters table, calculating the fine based on the delay.
3. Tracking Defaulters:
The system regularly checks overdue books and updates the zdefaulters table with the penalty amount.
The penalty is calculated based on the overdue period, referencing the student and book IDs.
🎯 Key Benefits
Efficient Management of Book Inventory: The system keeps track of the current status and availability of each book.
Automated Allotment and Return Tracking: The system records and monitors the borrowing process seamlessly.
Fine Calculation for Defaulters: Automatically calculates and tracks fines for overdue books, ensuring better accountability.
🚀 Conclusion
This Library Management System (LMS) helps streamline the library management process, making it easier to track issued items, manage book inventory, and handle overdue penalties effectively.

![image](https://github.com/user-attachments/assets/99527874-b588-485c-a693-45b0792837fe)

![image](https://github.com/user-attachments/assets/020aeb4c-384c-4324-af10-aabe17e0e02c)


📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

Feel free to clone or fork the repository and contribute to the project!

🔗 Connect with Me
If you have any questions or suggestions, feel free to reach out via LinkedIn or GitHub.

Tags
SAP ABAP Library Management System Book Allotment Defaulters Data Inventory Management

This README file summarizes the LMS and provides an overview of how the system operates, highlighting the key entities and workflow.
