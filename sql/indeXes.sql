use signup

-- Create the database


CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY, -- This will be the clustered index by default
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT,
    CreatedAt DATETIME DEFAULT GETDATE()
);


INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES
    ('Laptop', 'Electronics', 999.99, 50),
    ('Smartphone', 'Electronics', 699.99, 150),
    ('Table', 'Furniture', 89.99, 75),
    ('Chair', 'Furniture', 49.99, 200),
    ('Pen', 'Stationery', 1.99, 500),
    ('Notebook', 'Stationery', 2.99, 300);

CREATE NONCLUSTERED INDEX ix_Price_price ON Products (Price);
CREATE UNIQUE NONCLUSTERED INDEX uix_Price_Category ON Products (StockQuantity);

-- using clustered index
SELECT * FROM Products WHERE ProductID = 3;


SELECT * FROM Products WHERE Price > 50;

SELECT COUNT(StockQuantity) as QUANTITY FROM Products 





