-- ===================================================================
-- Converted SQL Statements Catalog
-- Application: GadgetsOnline
-- Source Database: Microsoft SQL Server (dbo schema)
-- Target Database: PostgreSQL (gadgetsonline_dbo schema)
-- Conversion Date: 2026-03-23
-- Total Statements: 14
-- 
-- DMS Tool Status: ALL 14 statements submitted to DMS MCP tool (retry attempt 2)
-- DMS Result: ALL FAILED with error: "Metadata model creation failed: 
--   No objects were found according to the specified selection rules."
-- DMS Timestamps: 2026-03-23T20:30:51 through 2026-03-23T20:36:06
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Manual Conversion Rules Applied:
--   - Schema: dbo → gadgetsonline_dbo
--   - Table names: PascalCase → lowercase (Products → products)
--   - Column names: PascalCase → lowercase (ProductId → productid)
--   - SQL syntax: TOP N → LIMIT N (moved to end of query)
--   - Parameter prefix: @ retained (compatible with Npgsql)
-- ===================================================================

-- ===================================================================
-- Statement 1: GetBestSellers (Inventory.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:30:51.134063
-- ===================================================================
-- ORIGINAL (MS SQL):
-- SELECT TOP 5 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
-- CONVERTED (PostgreSQL):
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT 5;

-- ===================================================================
-- Statement 2: GetAllCategories (Inventory.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:31:14.561669
-- ===================================================================
-- ORIGINAL (MS SQL):
-- SELECT CategoryId, Name, Description FROM dbo.Categories;
-- CONVERTED (PostgreSQL):
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- ===================================================================
-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:31:39.005550
-- ===================================================================
-- ORIGINAL (MS SQL):
-- SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
-- CONVERTED (PostgreSQL):
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- ===================================================================
-- Statement 4: GetProductById (Inventory.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:32:02.088598
-- ===================================================================
-- ORIGINAL (MS SQL):
-- SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
-- CONVERTED (PostgreSQL):
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ===================================================================
-- Statement 5: GetProductNameById (Inventory.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:32:24.393406
-- ===================================================================
-- ORIGINAL (MS SQL):
-- SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;
-- CONVERTED (PostgreSQL):
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ===================================================================
-- Statement 6: GetCartItems (ShoppingCart.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:32:47.731102
-- ===================================================================
-- ORIGINAL (MS SQL):
-- SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;
-- CONVERTED (PostgreSQL):
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ===================================================================
-- Statement 7: GetCount (ShoppingCart.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:33:09.744818
-- ===================================================================
-- ORIGINAL (MS SQL):
-- SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;
-- CONVERTED (PostgreSQL):
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ===================================================================
-- Statement 8: GetTotal (ShoppingCart.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:33:33.843344
-- ===================================================================
-- ORIGINAL (MS SQL):
-- SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;
-- CONVERTED (PostgreSQL):
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- ===================================================================
-- Statement 9: AddToCart SELECT (ShoppingCart.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:33:58.061445
-- ===================================================================
-- ORIGINAL (MS SQL):
-- SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- CONVERTED (PostgreSQL):
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId;

-- ===================================================================
-- Statement 10: AddToCart INSERT (ShoppingCart.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:34:22.710178
-- ===================================================================
-- ORIGINAL (MS SQL):
-- INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, @count, @dateCreated);
-- CONVERTED (PostgreSQL):
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, @count, @dateCreated);

-- ===================================================================
-- Statement 11: RemoveFromCart SELECT (ShoppingCart.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:34:45.947412
-- ===================================================================
-- ORIGINAL (MS SQL):
-- SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- CONVERTED (PostgreSQL):
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId;

-- ===================================================================
-- Statement 12: EmptyCart DELETE (ShoppingCart.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:35:08.179479
-- ===================================================================
-- ORIGINAL (MS SQL):
-- DELETE FROM dbo.Carts WHERE CartId = @cartId;
-- CONVERTED (PostgreSQL):
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ===================================================================
-- Statement 13: CreateOrder INSERT (ShoppingCart.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:35:30.571212
-- ===================================================================
-- ORIGINAL (MS SQL):
-- INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);
-- CONVERTED (PostgreSQL):
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- ===================================================================
-- Statement 14: ProcessOrder INSERT (OrderProcessing.cs)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- DMS Attempt Timestamp: 2026-03-23T20:35:53.230325
-- ===================================================================
-- ORIGINAL (MS SQL):
-- INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
-- CONVERTED (PostgreSQL):
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
