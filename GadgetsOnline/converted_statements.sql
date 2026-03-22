-- ============================================================================
-- Converted SQL Statements Catalog (PostgreSQL)
-- Application: GadgetsOnline
-- Migration: MS SQL Server to PostgreSQL
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Failure Reason: Metadata model creation failed - No objects were found
--                     according to the specified selection rules.
-- All 16 statements were passed through the DMS MCP tool THREE times (as required).
-- DMS Attempt 1 (2026-03-22 ~20:51): All 16 failed
-- DMS Attempt 2 (2026-03-22 ~21:14-21:20): All 16 failed again
-- DMS Attempt 3 (2026-03-22 ~21:49-21:53): All 16 failed again
-- DMS failed for all 16 with error: "Metadata model creation failed:
--   {'default_error_details': {'message': 'No objects were found according to
--   the specified selection rules. Please review your selection rules and try again.'}}"
-- Manual conversion applied with lowercase schema mapping.
-- Schema mapping: [dbo] -> gadgetsonline_dbo (matching existing EF6 configuration)
-- DMS Conversion Attempts: 16/16 attempted (x3), 0/16 succeeded, 16/16 failed
-- Total Statements: 16
-- ============================================================================

-- ============================================================================
-- Statement 1: GetBestSellers (Inventory.cs)
-- Original: SELECT TOP(@p0) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products];
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:49:06.162654
-- Changes: TOP(@p0) -> LIMIT @p0, [dbo].[Products] -> gadgetsonline_dbo.products, all identifiers lowercased
-- ============================================================================
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @p0;

-- ============================================================================
-- Statement 2: GetAllCategories (Inventory.cs)
-- Original: SELECT [CategoryId], [Name], [Description] FROM [dbo].[Categories];
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:49:20.454077
-- Changes: [dbo].[Categories] -> gadgetsonline_dbo.categories, all identifiers lowercased
-- ============================================================================
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Original: SELECT p.[ProductId], p.[CategoryId], p.[Name], p.[Price], p.[ProductArtUrl] FROM [dbo].[Products] p INNER JOIN [dbo].[Categories] c ON p.[CategoryId] = c.[CategoryId] WHERE c.[Name] = @p0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:49:34.678781
-- Changes: [dbo] tables -> gadgetsonline_dbo schema, all identifiers lowercased
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @p0;

-- ============================================================================
-- Statement 4: GetProductById (Inventory.cs)
-- Original: SELECT TOP(1) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products] WHERE [ProductId] = @p0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:49:48.896649
-- Changes: TOP(1) -> LIMIT 1, [dbo].[Products] -> gadgetsonline_dbo.products, all identifiers lowercased
-- ============================================================================
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @p0 LIMIT 1;

-- ============================================================================
-- Statement 5: AddToCart - Find existing cart item (ShoppingCart.cs)
-- Original: SELECT TOP(1) [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @p0 AND [ProductId] = @p1;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:50:17.680826
-- Changes: TOP(1) -> LIMIT 1, [dbo].[Carts] -> gadgetsonline_dbo.carts, all identifiers lowercased
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0 AND productid = @p1 LIMIT 1;

-- ============================================================================
-- Statement 6: AddToCart - Insert new cart item (ShoppingCart.cs)
-- Original: INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@p0, @p1, @p2, @p3);
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:50:32.065480
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all identifiers lowercased
-- ============================================================================
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@p0, @p1, @p2, @p3);

-- ============================================================================
-- Statement 7: AddToCart/RemoveFromCart - Update cart count (ShoppingCart.cs)
-- Original: UPDATE [dbo].[Carts] SET [Count] = @p0 WHERE [RecordId] = @p1;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:50:46.151855
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all identifiers lowercased
-- ============================================================================
UPDATE gadgetsonline_dbo.carts SET count = @p0 WHERE recordid = @p1;

-- ============================================================================
-- Statement 8: GetCount (ShoppingCart.cs)
-- Original: SELECT SUM([Count]) FROM [dbo].[Carts] WHERE [CartId] = @p0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:51:00.500539
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all identifiers lowercased
-- ============================================================================
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @p0;

-- ============================================================================
-- Statement 9: RemoveFromCart/EmptyCart - Delete cart item (ShoppingCart.cs)
-- Original: DELETE FROM [dbo].[Carts] WHERE [RecordId] = @p0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:51:29.824516
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all identifiers lowercased
-- ============================================================================
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @p0;

-- ============================================================================
-- Statement 10: GetTotal (ShoppingCart.cs)
-- Original: SELECT SUM(c.[Count] * p.[Price]) FROM [dbo].[Carts] c INNER JOIN [dbo].[Products] p ON c.[ProductId] = p.[ProductId] WHERE c.[CartId] = @p0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:51:44.094209
-- Changes: [dbo] tables -> gadgetsonline_dbo schema, all identifiers lowercased
-- ============================================================================
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @p0;

-- ============================================================================
-- Statement 11: GetCartItems/EmptyCart - Select cart items (ShoppingCart.cs)
-- Original: SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @p0;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:51:58.406217
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all identifiers lowercased
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @p0;

-- ============================================================================
-- Statement 12: ProcessOrder - Insert order (OrderProcessing.cs)
-- Original: INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:52:12.722548
-- Changes: [dbo].[Orders] -> gadgetsonline_dbo.orders, all identifiers lowercased
-- ============================================================================
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);

-- ============================================================================
-- Statement 13: CreateOrder - Insert order detail (ShoppingCart.cs)
-- Original: INSERT INTO [dbo].[OrderDetails] ([ProductId], [OrderId], [UnitPrice], [Quantity]) VALUES (@p0, @p1, @p2, @p3);
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:52:41.003115
-- Changes: [dbo].[OrderDetails] -> gadgetsonline_dbo.orderdetails, all identifiers lowercased
-- ============================================================================
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@p0, @p1, @p2, @p3);

-- ============================================================================
-- Statement 14: CreateOrder - Update order total (ShoppingCart.cs)
-- Original: UPDATE [dbo].[Orders] SET [Total] = @p0 WHERE [OrderId] = @p1;
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:52:55.295109
-- Changes: [dbo].[Orders] -> gadgetsonline_dbo.orders, all identifiers lowercased
-- ============================================================================
UPDATE gadgetsonline_dbo.orders SET total = @p0 WHERE orderid = @p1;

-- ============================================================================
-- Statement 15: Seed - Insert category (GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@p0, @p1, @p2);
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:53:09.554194
-- Changes: [dbo].[Categories] -> gadgetsonline_dbo.categories, all identifiers lowercased
-- ============================================================================
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@p0, @p1, @p2);

-- ============================================================================
-- Statement 16: Seed - Insert product (GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@p0, @p1, @p2, @p3, @p4);
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects were found according to the specified selection rules.
-- DMS Attempt 3 Timestamp: 2026-03-22T21:53:24.142082
-- Changes: [dbo].[Products] -> gadgetsonline_dbo.products, all identifiers lowercased
-- ============================================================================
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@p0, @p1, @p2, @p3, @p4);
