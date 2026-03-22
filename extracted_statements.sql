-- Extracted SQL Statements from GadgetsOnline Application
-- Source: Entity model [Table] and [Column] attribute mappings + Fluent API ToTable/HasColumnName calls
-- Note: This application uses LINQ-to-Entities queries exclusively through EF6 DbSets.
--       No raw/inline SQL statements were found in the codebase.
--       The following representative SELECT statements are derived from the entity-to-table mappings.

-- Statement 1: Products table (source: Models/Product.cs, Models/GadgetsOnlineEntities.cs)
SELECT ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2: Categories table (source: Models/Category.cs, Models/GadgetsOnlineEntities.cs)
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 3: Carts table (source: Models/Cart.cs, Models/GadgetsOnlineEntities.cs)
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts;

-- Statement 4: Orders table (source: Models/Order.cs, Models/GadgetsOnlineEntities.cs)
SELECT OrderId, OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total FROM dbo.Orders;

-- Statement 5: OrderDetails table (source: Models/OrderDetail.cs, Models/GadgetsOnlineEntities.cs)
SELECT OrderDetailId, OrderId, ProductId, Quantity, UnitPrice FROM dbo.OrderDetails;

-- ============================================================
-- MS SQL Server CREATE TABLE DDL Statements (for equivalency validation)
-- ============================================================

-- DDL 1: Products table
CREATE TABLE dbo.Products (ProductId INT PRIMARY KEY, CategoryId INT NOT NULL, Name NVARCHAR(255) NOT NULL, Price DECIMAL(18,2) NOT NULL, ProductArtUrl NVARCHAR(1024));

-- DDL 2: Categories table
CREATE TABLE dbo.Categories (CategoryId INT PRIMARY KEY, Name NVARCHAR(MAX), Description NVARCHAR(MAX));

-- DDL 3: Carts table
CREATE TABLE dbo.Carts (RecordId INT PRIMARY KEY, CartId NVARCHAR(MAX), ProductId INT NOT NULL, Count INT NOT NULL, DateCreated DATETIME NOT NULL);

-- DDL 4: Orders table
CREATE TABLE dbo.Orders (OrderId INT PRIMARY KEY, OrderDate DATETIME NOT NULL, Username NVARCHAR(MAX), FirstName NVARCHAR(160), LastName NVARCHAR(160), Address NVARCHAR(70), City NVARCHAR(40), State NVARCHAR(40), PostalCode NVARCHAR(10), Country NVARCHAR(40), Phone NVARCHAR(24), Email NVARCHAR(MAX), Total DECIMAL(18,2) NOT NULL);

-- DDL 5: OrderDetails table
CREATE TABLE dbo.OrderDetails (OrderDetailId INT PRIMARY KEY, OrderId INT NOT NULL, ProductId INT NOT NULL, Quantity INT NOT NULL, UnitPrice DECIMAL(18,2) NOT NULL);
