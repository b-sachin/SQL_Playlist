# SQL Playlist

This repository contains a structured set of SQL practice exercises covering fundamental to advanced SQL concepts. Each session file (`session_01.sql` to `session_10.sql`) focuses on specific SQL commands and techniques, providing hands-on learning for users.

## Repository Structure

```
SQL_Playlist/
├── session_01.sql   # Basic SQL commands: CREATE, INSERT, SELECT
├── session_02.sql   # DDL & DML Commands: ALTER, RENAME, DROP, UPDATE
├── session_03.sql   # DELETE & TRUNCATE operations
├── session_04.sql   # SELECT, DISTINCT, ORDER BY, Pattern Matching
├── session_05.sql   # Constraints, Aggregate Functions, Grouping & Joins
├── session_06.sql   # Transaction Control (TCL), Views, Indexing
├── session_07.sql   # Stored Procedures and User-Defined Functions (UDFs)
├── session_08.sql   # Loops, Exception Handling, Cursors
├── session_09.sql   # Triggers, Subqueries, and ENUM Data Type
├── session_10.sql   # Window Functions, CTEs, and CASE Statements
├── README.md        # Project documentation
└── LICENSE          # License information
```

## Topics Covered

### **Session 01: Basic SQL Commands**
- Creating databases and tables
- Inserting and retrieving data
- Describing table structures

### **Session 02: DDL & DML Commands**
- ALTER table (Add/Drop/Modify columns)
- RENAME tables
- DELETE, TRUNCATE
- Arithmetic and Comparison Operators

### **Session 03: DELETE & TRUNCATE Operations**
- Deleting individual and multiple records
- Understanding the difference between DELETE and TRUNCATE

### **Session 04: SELECT, DISTINCT, ORDER BY, Pattern Matching**
- Filtering unique values using DISTINCT
- Using ORDER BY for sorting
- Pattern matching with LIKE, %, and _ operators

### **Session 05: Constraints, Aggregation, and Grouping**
- Defining constraints (PRIMARY KEY, FOREIGN KEY, NOT NULL, DEFAULT, CHECK)
- Using aggregate functions (SUM, AVG, MIN, MAX, COUNT)
- GROUP BY and HAVING clauses

### **Session 06: Transaction Control (TCL), Views, Indexing**
- Using COMMIT, ROLLBACK, SAVEPOINT
- Creating and managing views
- Implementing indexing for performance improvement

### **Session 07: Stored Procedures and User-Defined Functions (UDFs)**
- Creating and calling stored procedures
- Conditional expressions (IF-ELSE)
- User-Defined Functions for calculations

### **Session 08: Loops, Exception Handling, Cursors**
- Using LOOP, WHILE, and REPEAT constructs
- Handling errors with exception handling
- Working with cursors to process query results

### **Session 09: Triggers, Subqueries, and ENUM Data Type**
- Automating actions with triggers (BEFORE/AFTER INSERT, UPDATE, DELETE)
- Using subqueries for data retrieval
- Implementing ENUM data type for predefined values

### **Session 10: Window Functions, CTEs, and CASE Statements**
- Using RANK(), ROW_NUMBER(), and DENSE_RANK()
- Aggregating data with SUM(), AVG(), COUNT()
- LEAD() & LAG() for previous and next row comparisons
- Using Common Table Expressions (CTEs) for readable queries
- Implementing CASE statements for conditional logic

## Getting Started

### **Prerequisites**
Ensure you have access to an SQL-compatible database such as:
- MySQL
- PostgreSQL
- SQLite
- Microsoft SQL Server

### **Installation**
1. **Clone the repository:**
   ```bash
   git clone https://github.com/b-sachin/SQL_Playlist.git
   cd SQL_Playlist
   ```
2. **Set up your database environment.**
3. **Run the scripts in sequential order:**
   ```sql
   SOURCE session_01.sql;
   ```

## Contribution Guidelines

1. **Fork the repository**.
2. **Create a new branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make changes and commit them:**
   ```bash
   git commit -m "Added advanced SQL queries"
   ```
4. **Push changes:**
   ```bash
   git push origin feature/your-feature-name
   ```
5. **Open a Pull Request**.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

*This README provides an overview of the SQL Playlist repository, outlining the content and instructions for use. Feel free to enhance it with additional explanations and examples.*

