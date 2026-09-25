# SQL Lab Assignment – ALTER TABLE

## Title

Alter the Student Table

## Objective

To learn how to modify an existing table using the SQL `ALTER TABLE` command.

## Problem Statement

The `Student` table already exists with the following fields:

| Field | Data Type |
|---|---|
| StudentID | INT(5) |
| StudentName | VARCHAR(20) |
| DOB | DATE |
| Gender | VARCHAR(10) |
| DepartmentID | INT(5) |

Alter the `Student` table by adding the following columns:

| New Column | Data Type |
|---|---|
| Email | VARCHAR(30) |
| PhoneNumber | INT(10) |

Finally, display the modified table structure.

## Instructions

1. Open `student_solution.sql`.
2. Write the required `ALTER TABLE` statement.
3. Add the `Email` column.
4. Add the `PhoneNumber` column.
5. Display the modified table structure using `DESC Student;`.
6. Do not rename `student_solution.sql`.
7. Commit and push your changes.
8. GitHub Actions will automatically evaluate your solution.

## Marks Distribution

| Test Case | Marks |
|---|---:|
| Student table exists | 2 |
| Email column exists | 2 |
| Email is VARCHAR(30) | 2 |
| PhoneNumber exists | 2 |
| PhoneNumber datatype | 2 |
| **Total** | **10** |

## Submission

Complete and submit only:

```text
student_solution.sql
