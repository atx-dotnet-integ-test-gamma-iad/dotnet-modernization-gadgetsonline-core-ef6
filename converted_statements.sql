-- ============================================================================
-- CONVERTED SQL STATEMENTS - GadgetsOnline Application
-- MS SQL Server to PostgreSQL Conversion
-- Total Statements: 16
-- DMS Tool Status: ALL 16 statements submitted to DMS, ALL 16 FAILED
-- DMS Error: "Metadata model creation failed: The selected objects were not found."
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Schema Mapping: dbo -> gadgetsonline_dbo
-- ============================================================================

-- ============================================================================
-- Source File: Services/Inventory.cs
-- 5 Statements
-- ============================================================================

-- Statement 1 (GetBestSellers)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   SELECT TOP(@p0) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
-- Converted PostgreSQL:
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @p0;

-- Statement 2 (GetAllCategories)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   SELECT CategoryId, Name, Description FROM dbo.Categories;
-- Converted PostgreSQL:
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3 (GetAllProductsInCategory)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @p0;
-- Converted PostgreSQL:
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @p0;

-- Statement 4 (GetProductById)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @p0;
-- Converted PostgreSQL:
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @p0 LIMIT 1;

-- Statement 5 (GetProductNameById)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   SELECT TOP(1) Name FROM dbo.Products WHERE ProductId = @p0;
-- Converted PostgreSQL:
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @p0 LIMIT 1;

-- ============================================================================
-- Source File: Services/ShoppingCart.cs
-- 10 Statements
-- ============================================================================

-- Statement 6 (GetCartItems)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @p0;
-- Converted PostgreSQL:
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0;

-- Statement 7 (GetCount)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @p0;
-- Converted PostgreSQL:
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @p0;

-- Statement 8 (GetTotal)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @p0;
-- Converted PostgreSQL:
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @p0;

-- Statement 9 (AddToCart SELECT)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @p0 AND ProductId = @p1;
-- Converted PostgreSQL:
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0 AND productid = @p1 LIMIT 1;

-- Statement 10 (AddToCart INSERT)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@p0, @p1, @p2, @p3);
-- Converted PostgreSQL:
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@p0, @p1, @p2, @p3);

-- Statement 11 (RemoveFromCart SELECT)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @p0 AND ProductId = @p1;
-- Converted PostgreSQL:
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0 AND productid = @p1 LIMIT 1;

-- Statement 12 (RemoveFromCart DELETE)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   DELETE FROM dbo.Carts WHERE RecordId = @p0;
-- Converted PostgreSQL:
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @p0;

-- Statement 13 (EmptyCart DELETE)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   DELETE FROM dbo.Carts WHERE CartId = @p0;
-- Converted PostgreSQL:
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @p0;

-- Statement 14 (CreateOrder INSERT OrderDetails)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@p0, @p1, @p2, @p3);
-- Converted PostgreSQL:
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@p0, @p1, @p2, @p3);

-- Statement 15 (CreateOrder UPDATE Order Total)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   UPDATE dbo.Orders SET Total = @p0 WHERE OrderId = @p1;
-- Converted PostgreSQL:
UPDATE gadgetsonline_dbo.orders SET total = @p0 WHERE orderid = @p1;

-- ============================================================================
-- Source File: Services/OrderProcessing.cs
-- 1 Statement
-- ============================================================================

-- Statement 16 (ProcessOrder INSERT)
-- DMS Status: FAILED - "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Original MS SQL:
--   INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);
-- Converted PostgreSQL:
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);
