CREATE DATABASE user_management;
USE user_management;

CREATE DATABASE user_management;
USE user_management;

CREATE TABLE signup (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(15),
    address VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE login (
    login_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    password VARCHAR(255) NOT NULL,
    login_time DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES signup(user_id)
);
 
 INSERT INTO signup (username, email, password_hash, first_name, last_name, phone_number, address)
VALUES ('johndoe', 'johndoe@example.com', 'hashed_password', 'John', 'Doe', '1234567890', '123 Main St');

INSERT INTO login (user_id, password)
VALUES (1, 'hashed_password');

SELECT * FROM signup;

SELECT * FROM login WHERE user_id = 1;
--UPDATE
UPDATE signup
SET email = 'newemail@example.com', phone_number = '0987654321', address = '456 Elm St'
WHERE user_id = 1;

SELECT * FROM signup;


UPDATE login
SET password = 'new_hashed_password'
WHERE login_id = 1;

--DELETE
DELETE FROM login WHERE login_id = 1;

DELETE FROM signup WHERE user_id = 1;

--PROCEDURE


CREATE PROCEDURE spSignUpUser
    @p_username VARCHAR(50),
    @p_email VARCHAR(100),
    @p_password_hash VARCHAR(255),
    @p_first_name VARCHAR(50),
    @p_last_name VARCHAR(50),
    @p_phone_number VARCHAR(15),
    @p_address VARCHAR(255)
AS
BEGIN
    INSERT INTO signup (username, email, password_hash, first_name, last_name, phone_number, address)
    VALUES ( @p_username, @p_email, @p_password_hash, @p_first_name,@p_last_name, @p_phone_number, @p_address);
END 

EXEC spSignUpUser 'arun', 'kumar@example.com', 'kumar_password', 'arun', 'kumar', '98765435210', '598 annanagar street';
select * from signup






















