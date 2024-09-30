<h1>📚 Library Management System (LMS)</h1>
<p>This Library Management System (LMS) is designed to manage library operations such as book availability, issuance, and defaulter tracking. The system is implemented using SAP ABAP and consists of three primary entities, represented by separate tables: Books Data, Book Allotment, and Defaulters Data.</p>

<h4>⚙️ System Overview</h4>
<p>The LMS system handles three main entities:</p>

<h5>Books Data (zbooks)<br>
Book Allotment (zbookallotment)<br>
Defaulters Data (zdefaulters)</h5>
<p>The system ensures efficient library management by tracking:</p>

<p>Available books and their details.<br>
The issuance and return process for borrowed books.<br>
Defaulters and fines for overdue books.</p>
<h4>🗂️ Table Structures</h4>
<h5>1. Books Data Table (zbooks)</h5>
This table stores essential information about the books available in the library, including book details and their current status.

<h5>Key Fields:</h5>
<p><b>bookid:</b> Unique identifier for each book.<br>
<b>bookname:</b> The title of the book.<br>
<b>bookauthor:</b> The author of the book.<br>
<b>quantity:</b> Number of copies available in the library.<br>
<b>status:</b> Indicates whether the book is available, issued, or reserved.</p>
<h4>2. Book Allotment Table (zbookallotment)</h4>
<p>This table tracks the allotment (borrowing) of books by users (students). It records both the issuance and the expected return date for each borrowed book.
</p>
<p>
  <b> Key Fields:</b>
<b>bookallotmentids: </b>Unique identifier for each book allotment.<br>
<b>bookids:</b> Foreign key referencing the zbooks table.<br>
<b>studentids:</b> Unique identifier for the student borrowing the book.<br>
<b>allotment_date:</b> Date the book was issued.<br>
<b>submission_date:</b> Expected date for returning the book.<br>
</p>
<h5>3. Defaulters Data Table (zdefaulters)</h5>
<P>This table tracks students who fail to return books by the due date and calculates penalties (fines) based on late submissions.
</P>
<p>
<b>  Key Fields:</b>
<b>defaulterid:</b> Unique identifier for each defaulter.<br>
<b>bookids:</b> Foreign key referencing the zbooks table (book being defaulted on).<br>
<b>studentids:</b> Foreign key referencing the student table (student who defaulted).<br>
<b>penalty:</b> Amount of fine to be paid by the defaulter.<br>
<b>currencycode:</b> Currency in which the fine is calculated.</p>

<h4>🚦 System Workflow</h4>
<h5>1. Book Issuance:</h5>
<p>
  When a student borrows a book: <br>

An entry is made in the zbookallotment table, recording the book’s ID, student’s ID, the date of issue, and the due date for return.
</p>
<h5>2. Book Return:</h5>
<p>
  When the book is returned on or before the due date, the zbookallotment record is updated.<br>
If the book is returned late, an entry is made in the zdefaulters table, calculating the fine based on the delay.
</p>
<h5>3. Tracking Defaulters:</h5>
<p>
  The system regularly checks overdue books and updates the zdefaulters table with the penalty amount.<br>
The penalty is calculated based on the overdue period, referencing the student and book IDs.
</p>
<h3>🎯 Key Benefits</h3>
<p>Efficient Management of Book Inventory: The system keeps track of the current status and availability of each book.<br>
Automated Allotment and Return Tracking: The system records and monitors the borrowing process seamlessly.<br>
Fine Calculation for Defaulters: Automatically calculates and tracks fines for overdue books, ensuring better accountability.</p>

<h3>🚀 Conclusion</h3>
<p>This Library Management System (LMS) helps streamline the library management process, making it easier to track issued items, manage book inventory, and handle overdue penalties effectively.
</p>

![image](https://github.com/user-attachments/assets/99527874-b588-485c-a693-45b0792837fe)

![image](https://github.com/user-attachments/assets/020aeb4c-384c-4324-af10-aabe17e0e02c)


<h4>📄 License</h4>
<p>This project is licensed under the MIT License - see the LICENSE file for details.<br>

Feel free to clone or fork the repository and contribute to the project!</p>

<h4>🔗 Connect with Me</h4>
<p>If you have any questions or suggestions, feel free to reach out via <a href = "https://www.linkedin.com/in/devi-prasad-mishra-07048b217">LinkeDin</a> or GitHub.</p>

<h4>Tags</h4>
<p>
  SAP ABAP Library Management System Book Allotment Defaulters Data Inventory Management<br>

This README file summarizes the LMS and provides an overview of how the system operates, highlighting the key entities and workflow.
</p>
