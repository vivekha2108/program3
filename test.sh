#!/bin/bash

MYSQL="mysql -h127.0.0.1 -P3306 -uroot -proot"

echo "========================================"
echo " ALTER TABLE Student Assignment"
echo "========================================"

# Check whether student SQL file exists
if [ ! -f "student_solution.sql" ]; then
    echo "FAIL: student_solution.sql file not found."
    exit 1
fi

echo "Creating fresh CollegeDB database..."

# Create fresh database
$MYSQL -e "DROP DATABASE IF EXISTS CollegeDB;"
$MYSQL -e "CREATE DATABASE CollegeDB;"

# Create the original Student table
echo "Creating original Student table..."

$MYSQL CollegeDB -e "
CREATE TABLE Student (
    StudentID INT(5) PRIMARY KEY,
    StudentName VARCHAR(20),
    DOB DATE,
    Gender VARCHAR(10),
    DepartmentID INT(5)
);
"

echo "Executing student_solution.sql..."

# Execute student's ALTER TABLE statements
if ! $MYSQL CollegeDB < student_solution.sql; then
    echo "FAIL: Error while executing student_solution.sql"
    exit 1
fi

echo ""
echo "Checking modified Student table..."

MARKS=0

# ----------------------------------------
# Test Case 1: Student table exists
# ----------------------------------------

TABLE=$($MYSQL -N -s CollegeDB -e "
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student';
")

if [ "$TABLE" = "Student" ]; then
    echo "PASS: Student table exists."
    MARKS=$((MARKS+2))
else
    echo "FAIL: Student table not found."
    exit 1
fi

# ----------------------------------------
# Test Case 2: Email column exists
# ----------------------------------------

EMAIL=$($MYSQL -N -s -e "
SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='Email';
")

if [ "$EMAIL" = "varchar" ]; then
    echo "PASS: Email column exists."
    MARKS=$((MARKS+2))
else
    echo "FAIL: Email column not found."
fi

# ----------------------------------------
# Test Case 3: Email length is 30
# ----------------------------------------

EMAIL_LENGTH=$($MYSQL -N -s -e "
SELECT CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='Email';
")

if [ "$EMAIL_LENGTH" = "30" ]; then
    echo "PASS: Email is VARCHAR(30)."
    MARKS=$((MARKS+2))
else
    echo "FAIL: Email datatype/length is incorrect."
fi

# ----------------------------------------
# Test Case 4: PhoneNumber column exists
# ----------------------------------------

PHONE=$($MYSQL -N -s -e "
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='PhoneNumber';
")

if [ "$PHONE" = "PhoneNumber" ]; then
    echo "PASS: PhoneNumber column exists."
    MARKS=$((MARKS+2))
else
    echo "FAIL: PhoneNumber column not found."
fi

# ----------------------------------------
# Test Case 5: PhoneNumber datatype
# ----------------------------------------

PHONE_TYPE=$($MYSQL -N -s -e "
SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='CollegeDB'
AND TABLE_NAME='Student'
AND COLUMN_NAME='PhoneNumber';
")

if [ "$PHONE_TYPE" = "int" ]; then
    echo "PASS: PhoneNumber datatype is correct."
    MARKS=$((MARKS+2))
else
    echo "FAIL: PhoneNumber datatype is incorrect."
fi

echo ""
echo "========================================"
echo "Total Marks: $MARKS / 10"
echo "========================================"

if [ "$MARKS" -eq 10 ]; then
    echo "SUCCESS: All test cases passed."
    exit 0
else
    echo "Some test cases failed."
    exit 1
fi
