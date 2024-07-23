USE company



-- sales table data
CREATE TABLE Sales (
    SalesPerson NVARCHAR(50),
    Month NVARCHAR(20),
    SalesAmount DECIMAL(10, 2)
);


INSERT INTO Sales (SalesPerson, Month, SalesAmount)
VALUES
('John Doe', 'January', 1000.00),
('John Doe', 'February', 1200.00),
('Jane Smith', 'January', 900.00),
('Jane Smith', 'February', 1100.00),
('Emily Johnson', 'January', 950.00),
('Emily Johnson', 'February', 1300.00);

SELECT * FROM Sales

-- PIVOT operation -rows to columns
SELECT *
FROM (
    SELECT SalesPerson, Month, SalesAmount
    FROM Sales
) AS SourceTable
PIVOT (
    SUM(SalesAmount)
    FOR Month IN (January, February)
) AS PivotTable;
--OR
SELECT SalesPerson, January,February
FROM Sales
PIVOT
(
  SUM(SalesAmount)
  FOR Month
  IN ([January],[February])
  ) AS PivotTable;

--UNPIVOT-changing columns to rows
  
CREATE TABLE PivotedSales (
    SalesPerson NVARCHAR(50),
    January DECIMAL(10, 2),
    February DECIMAL(10, 2)
);

-- Insert 
INSERT INTO PivotedSales (SalesPerson, January, February)
VALUES
('John Doe', 1000.00, 1200.00),
('Jane Smith', 900.00, 1100.00),
('Emily Johnson', 950.00, 1300.00);


SELECT SalesPerson, Month, SalesAmount
FROM (
    SELECT SalesPerson, January, February
    FROM PivotedSales
) AS PivotedTable
UNPIVOT (
    SalesAmount FOR Month IN (January, February)
) AS UnpivotedTable;


SELECT * FROM PivotedSales
