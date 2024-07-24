CREATE DATABASE SupermarketPOS;
USE SupermarketPOS;

-- Create PRODUCT_CATEGORY Table
CREATE TABLE PRODUCT_CATEGORY (
    CategoryID VARCHAR(255) PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);
 
 desc PRODUCT_CATEGORY;
 
-- Create PRODUCT Table
CREATE TABLE PRODUCT (
    ProductID VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockLevel INT NOT NULL,
    CategoryID VARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES PRODUCT_CATEGORY(CategoryID)
);

desc PRODUCT;


-- Create CUSTOMER Table
CREATE TABLE CUSTOMER (
    CustomerID VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ContactInfo VARCHAR(255)
);

desc CUSTOMER;

-- Create EMPLOYEE Table
CREATE TABLE EMPLOYEE (
    EmployeeID VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Position VARCHAR(255) NOT NULL
);

desc EMPLOYEE;

-- Create SUPPLIER Table
CREATE TABLE SUPPLIER (
    SupplierID VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ContactInfo VARCHAR(255)
);

desc SUPPLIER;


-- Create SALE Table
CREATE TABLE SALE (
    SaleID VARCHAR(255) PRIMARY KEY,
    Date DATE NOT NULL,
    CustomerID VARCHAR(255),
    EmployeeID VARCHAR(255),
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);

desc SALE;

-- Create SALE_DETAIL Table
CREATE TABLE SALE_DETAIL (
    SaleDetailID VARCHAR(255) PRIMARY KEY,
    SaleID VARCHAR(255),
    ProductID VARCHAR(255),
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SaleID) REFERENCES SALE(SaleID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

desc SALE_DETAIL;

-- Insert values in PRODUCT_CATEGORY Table
INSERT INTO PRODUCT_CATEGORY (CategoryID, CategoryName) VALUES
('CAT001', 'Beverages'),
('CAT002', 'Dairy'),
('CAT003', 'Bakery'),
('CAT004', 'Frozen Foods'),
('CAT005', 'Snacks');

SELECT * FROM PRODUCT_CATEGORY;

-- Insert values in PRODUCT Table
INSERT INTO PRODUCT (ProductID, Name, Price, StockLevel, CategoryID) VALUES
('PROD001', 'Organic Milk', 3.50, 100, 'CAT002'),
('PROD002', 'Italian Coffee', 6.99, 50, 'CAT001'),
('PROD003', 'Whole Wheat Bread', 2.99, 75, 'CAT003'),
('PROD004', 'Vanilla Ice Cream', 5.49, 60, 'CAT004'),
('PROD005', 'Potato Chips', 2.50, 120, 'CAT005');

SELECT * FROM PRODUCT;

-- Insert values in CUSTOMER Table
INSERT INTO CUSTOMER (CustomerID, Name, ContactInfo) VALUES
('CUS001', 'John Smith', 'john.smith@example.com'),
('CUS002', 'Jane Doe', 'jane.doe@example.com'),
('CUS003', 'Michael Johnson', 'michael.johnson@example.com'),
('CUS004', 'Emily Davis', 'emily.davis@example.com'),
('CUS005', 'David Wilson', 'david.wilson@example.com');

SELECT * FROM CUSTOMER;

-- Insert values in EMPLOYEE Table
INSERT INTO EMPLOYEE (EmployeeID, Name, Position) VALUES
('EMP001', 'Alice Johnson', 'Manager'),
('EMP002', 'Bob Smith', 'Cashier'),
('EMP003', 'Carol Taylor', 'Stock Clerk'),
('EMP004', 'Dave Brown', 'Sales Associate'),
('EMP005', 'Eve White', 'Customer Service Representative');

SELECT * FROM EMPLOYEE;

-- Insert values in SUPPLIER  Table
INSERT INTO SUPPLIER (SupplierID, Name, ContactInfo) VALUES
('SUP001', 'Fresh Farms Produce', 'contact@freshfarms.com'),
('SUP002', 'Global Beverages Ltd.', 'info@globalbev.com'),
('SUP003', 'Bakery Delights Co.', 'support@bakerydelights.com'),
('SUP004', 'Dairy Essentials Inc.', 'sales@dairyessentials.com'),
('SUP005', 'SnackWorld Distributors', 'hello@snackworld.com');

SELECT * FROM SUPPLIER;

-- Insert values in SALE  Table
INSERT INTO SALE (SaleID, Date, CustomerID, EmployeeID, TotalAmount) VALUES
('SALE001', '2023-02-01', 'CUS001', 'EMP001', 150.00),
('SALE002', '2023-02-02', 'CUS002', 'EMP002', 75.00),
('SALE003', '2023-02-03', 'CUS003', 'EMP003', 200.00),
('SALE004', '2023-02-04', 'CUS004', 'EMP004', 50.00),
('SALE005', '2023-02-05', 'CUS005', 'EMP005', 125.00);

SELECT * FROM SALE;


-- Insert values in SALE_DETAIL  Table
INSERT INTO SALE_DETAIL (SaleDetailID, SaleID, ProductID, Quantity, Subtotal) VALUES
('SDET001', 'SALE001', 'PROD001', 2, 300.00),
('SDET002', 'SALE001', 'PROD002', 1, 150.00),
('SDET003', 'SALE002', 'PROD003', 3, 225.00),
('SDET004', 'SALE003', 'PROD004', 1, 200.00),
('SDET005', 'SALE004', 'PROD005', 2, 100.00);

SELECT * FROM SALE_DETAIL;

-- Joining Tables to Display Sales and Customer Information

SELECT s.SaleID, c.Name AS CustomerName, e.Name AS EmployeeName, s.Date, s.TotalAmount
FROM SALE s
INNER JOIN CUSTOMER c ON s.CustomerID = c.CustomerID
INNER JOIN EMPLOYEE e ON s.EmployeeID = e.EmployeeID;


-- Detailed Report on Sales, Including Product Details

SELECT sd.SaleDetailID, s.SaleID, p.Name AS ProductName, sd.Quantity, sd.Subtotal
FROM SALE_DETAIL sd
INNER JOIN SALE s ON sd.SaleID = s.SaleID
INNER JOIN PRODUCT p ON sd.ProductID = p.ProductID;


-- Products Sold, Aggregated by Category
SELECT pc.CategoryName, COUNT(sd.SaleDetailID) AS UnitsSold
FROM SALE_DETAIL sd
INNER JOIN PRODUCT p ON sd.ProductID = p.ProductID
INNER JOIN PRODUCT_CATEGORY pc ON p.CategoryID = pc.CategoryID
GROUP BY pc.CategoryName;


--  Updating a Product's Stock Level

UPDATE PRODUCT
SET StockLevel = StockLevel - 5 -- Assuming 5 units were sold.
WHERE ProductID = 'PROD001';


-- Deleting a Sale and Maintaining Integrity

-- Delete sale details first
DELETE FROM SALE_DETAIL WHERE SaleID = 'SALE001';

-- Then delete the sale
DELETE FROM SALE WHERE SaleID = 'SALE001';




