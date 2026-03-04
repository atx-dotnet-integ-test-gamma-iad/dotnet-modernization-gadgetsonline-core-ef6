-- ============================================================================
-- Converted SQL Statements - PostgreSQL Equivalents
-- Purpose: All MS SQL Server statements converted to PostgreSQL syntax
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Retry Attempt: 2026-03-04T02:12-02:20 UTC (Step 2 re-processing)
-- DMS Error (all 21 statements): "Metadata model creation failed: 
--   {'error': \"Metadata model creation failed: {'default_error_details': 
--   {'message': 'The selected objects were not found.'}}\"}"
-- Reason: DMS tool failed for all statements - source database schema objects
--   (tables in [dbo]) were not accessible to the DMS migration project
-- Target Schema: gadgetsonline_dbo (lowercase)
-- Manual Conversion Rules:
--   [dbo] schema -> gadgetsonline_dbo schema
--   PascalCase identifiers -> lowercase identifiers
--   TOP(N) / TOP(@count) -> LIMIT N / LIMIT @count
--   Square bracket delimiters [] -> Removed
-- ============================================================================

-- ============================================================================
-- Statement 1: GetBestSellers (Inventory.cs)
-- Original: SELECT TOP(@count) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products];
-- DMS Attempt: 2026-03-04T02:12:48 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- ============================================================================
-- Statement 2: GetAllCategories (Inventory.cs)
-- Original: SELECT [CategoryId], [Name], [Description] FROM [dbo].[Categories];
-- DMS Attempt: 2026-03-04T02:13:11 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Original: SELECT [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] INNER JOIN [dbo].[Categories] AS [c] ON [p].[CategoryId] = [c].[CategoryId] WHERE [c].[Name] = @category;
-- DMS Attempt: 2026-03-04T02:13:34 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p INNER JOIN gadgetsonline_dbo.categories AS c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- ============================================================================
-- Statement 4: GetProductById (Inventory.cs)
-- Original: SELECT TOP(1) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products] WHERE [ProductId] = @id;
-- DMS Attempt: 2026-03-04T02:13:58 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- Statement 5: GetProductNameById (Inventory.cs)
-- Original: SELECT TOP(1) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products] WHERE [ProductId] = @id;
-- DMS Attempt: 2026-03-04T02:13:58 - FAILED (same SQL as Statement 4)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- Statement 6: GetCartItems (ShoppingCart.cs)
-- Original: SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @cartId;
-- DMS Attempt: 2026-03-04T02:14:21 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 7: GetCount (ShoppingCart.cs)
-- Original: SELECT SUM([Count]) FROM [dbo].[Carts] WHERE [CartId] = @cartId;
-- DMS Attempt: 2026-03-04T02:14:43 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 8: GetTotal (ShoppingCart.cs)
-- Original: SELECT SUM([c].[Count] * [p].[Price]) FROM [dbo].[Carts] AS [c] INNER JOIN [dbo].[Products] AS [p] ON [c].[ProductId] = [p].[ProductId] WHERE [c].[CartId] = @cartId;
-- DMS Attempt: 2026-03-04T02:15:08 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts AS c INNER JOIN gadgetsonline_dbo.products AS p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- ============================================================================
-- Statement 9: AddToCart - Select existing (ShoppingCart.cs)
-- Original: SELECT TOP(1) [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @cartId AND [ProductId] = @productId;
-- DMS Attempt: 2026-03-04T02:15:31 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId LIMIT 1;

-- ============================================================================
-- Statement 10: AddToCart - Insert new cart item (ShoppingCart.cs)
-- Original: INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@cartId, @productId, @count, @dateCreated);
-- DMS Attempt: 2026-03-04T02:15:53 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, @count, @dateCreated);

-- ============================================================================
-- Statement 11: AddToCart - Update cart count (ShoppingCart.cs)
-- Original: UPDATE [dbo].[Carts] SET [Count] = @count WHERE [RecordId] = @recordId;
-- DMS Attempt: 2026-03-04T02:16:16 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
UPDATE gadgetsonline_dbo.carts SET count = @count WHERE recordid = @recordId;

-- ============================================================================
-- Statement 12: RemoveFromCart - Select cart item (ShoppingCart.cs)
-- Original: SELECT TOP(1) [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @cartId AND [ProductId] = @productId;
-- DMS Attempt: 2026-03-04T02:16:38 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId LIMIT 1;

-- ============================================================================
-- Statement 13: RemoveFromCart - Update count (ShoppingCart.cs)
-- Original: UPDATE [dbo].[Carts] SET [Count] = @count WHERE [RecordId] = @recordId;
-- DMS Attempt: 2026-03-04T02:17:00 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
UPDATE gadgetsonline_dbo.carts SET count = @count WHERE recordid = @recordId;

-- ============================================================================
-- Statement 14: RemoveFromCart - Delete cart item (ShoppingCart.cs)
-- Original: DELETE FROM [dbo].[Carts] WHERE [RecordId] = @recordId;
-- DMS Attempt: 2026-03-04T02:17:23 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @recordId;

-- ============================================================================
-- Statement 15: EmptyCart - Select cart items (ShoppingCart.cs)
-- Original: SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @cartId;
-- DMS Attempt: 2026-03-04T02:17:45 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 16: EmptyCart - Delete cart item (ShoppingCart.cs)
-- Original: DELETE FROM [dbo].[Carts] WHERE [RecordId] = @recordId;
-- DMS Attempt: 2026-03-04T02:18:10 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @recordId;

-- ============================================================================
-- Statement 17: ProcessOrder - Insert order (OrderProcessing.cs)
-- Original: INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
-- DMS Attempt: 2026-03-04T02:18:33 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- Statement 18: CreateOrder - Insert order detail (ShoppingCart.cs)
-- Original: INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (@orderId, @productId, @quantity, @unitPrice);
-- DMS Attempt: 2026-03-04T02:18:55 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- ============================================================================
-- Statement 19: CreateOrder - Update order total (ShoppingCart.cs)
-- Original: UPDATE [dbo].[Orders] SET [Total] = @total WHERE [OrderId] = @orderId;
-- DMS Attempt: 2026-03-04T02:19:18 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
UPDATE gadgetsonline_dbo.orders SET total = @total WHERE orderid = @orderId;

-- ============================================================================
-- Statement 20: Seed Categories (GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@categoryId, @name, @description);
-- DMS Attempt: 2026-03-04T02:19:44 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@categoryId, @name, @description);

-- ============================================================================
-- Statement 21: Seed Products (GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
-- DMS Attempt: 2026-03-04T02:20:06 - FAILED
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- ============================================================================
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
