create database single_store_proc
use single_store_proc

CREATE TABLE student (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    enrollment_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
);

INSERT INTO student (first_name, last_name, email, enrollment_date, status)
VALUES
    ('John', 'Doe', 'johndoe@example.com', '2024-08-01', 'Enrolled'),
    ('Jane', 'Smith', 'janesmith@example.com', '2024-08-15', 'Enrolled'),
    ('Alice', 'Johnson', 'alicejohnson@example.com', '2024-09-01', 'Pending');


	CREATE PROCEDURE sp_ManageStudent
    @operation_type VARCHAR(10), -- 'INSERT', 'SELECT', 'UPDATE', 'DELETE'
    @student_id INT = NULL,
    @first_name VARCHAR(50) = NULL,
    @last_name VARCHAR(50) = NULL,
    @email VARCHAR(100) = NULL,
    @enrollment_date DATE = NULL,
    @status VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @operation_type = 'INSERT'
    BEGIN
        -- Insert new student record
        INSERT INTO student (first_name, last_name, email, enrollment_date, status)
        VALUES (@first_name, @last_name, @email, @enrollment_date, @status);
    END
    ELSE IF @operation_type = 'SELECT'
    BEGIN
        -- Select student records
        IF @student_id IS NOT NULL
        BEGIN
            -- Select a specific student by student_id
            SELECT student_id, first_name, last_name, email, enrollment_date, status
            FROM student
            WHERE student_id = @student_id;
        END
        ELSE
        BEGIN
            -- Select all student records
            SELECT student_id, first_name, last_name, email, enrollment_date, status
            FROM student;
        END
    END
    ELSE IF @operation_type = 'UPDATE'
    BEGIN
        -- Update student record
        IF @student_id IS NOT NULL
        BEGIN
            UPDATE student
            SET
                first_name = COALESCE(@first_name, first_name),
                last_name = COALESCE(@last_name, last_name),
                email = COALESCE(@email, email),
                enrollment_date = COALESCE(@enrollment_date, enrollment_date),
                status = COALESCE(@status, status)
            WHERE student_id = @student_id;
        END
        ELSE
        BEGIN
            RAISERROR('student_id is required for UPDATE operation.', 16, 1);
        END
    END
    ELSE IF @operation_type = 'DELETE'
    BEGIN
        -- Delete student record
        IF @student_id IS NOT NULL
        BEGIN
            DELETE FROM student
            WHERE student_id = @student_id;
        END
        ELSE
        BEGIN
            RAISERROR('student_id is required for DELETE operation.', 16, 1);
        END
    END
    ELSE
    BEGIN
        RAISERROR('Invalid operation type. Use INSERT, SELECT, UPDATE, or DELETE.', 16, 1);
    END
END;

EXEC sp_ManageStudent
    @operation_type = 'INSERT',
    @first_name = 'Michael',
    @last_name = 'Brown',
    @email = 'michaelbrown@example.com',
    @enrollment_date = '2024-10-01',
    @status = 'Enrolled';

	EXEC sp_ManageStudent
    @operation_type = 'SELECT',
    @student_id = 1;  -- student_id


	--EXEC sp_ManageStudent
    --@operation_type = 'SELECT';


	EXEC sp_ManageStudent
    @operation_type = 'UPDATE',
    @student_id = 1,  --  student_id
    @first_name = 'Johnathan',
    @status = 'Graduated';

	EXEC sp_ManageStudent
    @operation_type = 'DELETE',
    @student_id = 1;  -- student_id


	select * from student







