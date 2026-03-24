-- ============================================================================
-- Converted SQL Statements - PostgreSQL Equivalents
-- Application: GadgetsOnline
-- Target Database: PostgreSQL
-- Target Schema: gadgetsonline_dbo
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects found per selection rules
-- ============================================================================

-- ============================================================================
-- Statement 1: GetBestSellers (Inventory.cs)
-- Original: SELECT TOP(@count) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p]
-- Conversion: TOP(@count) -> LIMIT @count, schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p LIMIT @count

-- ============================================================================
-- Statement 2: GetAllCategories (Inventory.cs)
-- Original: SELECT [c].[CategoryId], [c].[Name], [c].[Description] FROM [dbo].[Categories] AS [c]
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
SELECT c.categoryid, c.name, c.description FROM gadgetsonline_dbo.categories AS c

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Original: SELECT [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] INNER JOIN [dbo].[Categories] AS [c] ON [p].[CategoryId] = [c].[CategoryId] WHERE [c].[Name] = @category
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p INNER JOIN gadgetsonline_dbo.categories AS c ON p.categoryid = c.categoryid WHERE c.name = @category

-- ============================================================================
-- Statement 4: GetProductById (Inventory.cs)
-- Original: SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id
-- Conversion: TOP(1) -> LIMIT 1, schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p WHERE p.productid = @id LIMIT 1

-- ============================================================================
-- Statement 5: GetProductNameById (Inventory.cs)
-- Original: SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id
-- Conversion: TOP(1) -> LIMIT 1, schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products AS p WHERE p.productid = @id LIMIT 1

-- ============================================================================
-- Statement 6: GetCartItems (ShoppingCart.cs)
-- Original: SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
SELECT c.recordid, c.cartid, c.productid, c.count, c.datecreated FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId

-- ============================================================================
-- Statement 7: GetCount (ShoppingCart.cs)
-- Original: SELECT SUM([c].[Count]) FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
SELECT SUM(c.count) FROM gadgetsonline_dbo.carts AS c WHERE c.cartid = @cartId

-- ============================================================================
-- Statement 8: GetTotal (ShoppingCart.cs)
-- Original: SELECT SUM(CAST([c].[Count] AS DECIMAL(18,2)) * [p].[Price]) FROM [dbo].[Carts] AS [c] INNER JOIN [dbo].[Products] AS [p] ON [c].[ProductId] = [p].[ProductId] WHERE [c].[CartId] = @cartId
-- Conversion: CAST AS DECIMAL -> CAST AS NUMERIC, schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
SELECT SUM(CAST(c.count AS NUMERIC(18,2)) * p.price) FROM gadgetsonline_dbo.carts AS c INNER JOIN gadgetsonline_dbo.products AS p ON c.productid = p.productid WHERE c.cartid = @cartId

-- ============================================================================
-- Statement 9: AddToCart - INSERT new cart item (ShoppingCart.cs)
-- Original: INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@cartId, @productId, 1, @dateCreated)
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, @dateCreated)

-- ============================================================================
-- Statement 10: AddToCart - UPDATE existing cart item (ShoppingCart.cs)
-- Original: UPDATE [dbo].[Carts] SET [Count] = [Count] + 1 WHERE [RecordId] = @recordId
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE recordid = @recordId

-- ============================================================================
-- Statement 11: RemoveFromCart - UPDATE decrement count (ShoppingCart.cs)
-- Original: UPDATE [dbo].[Carts] SET [Count] = [Count] - 1 WHERE [RecordId] = @recordId
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = @recordId

-- ============================================================================
-- Statement 12: RemoveFromCart - DELETE cart item (ShoppingCart.cs)
-- Original: DELETE FROM [dbo].[Carts] WHERE [RecordId] = @recordId
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @recordId

-- ============================================================================
-- Statement 13: EmptyCart (ShoppingCart.cs)
-- Original: DELETE FROM [dbo].[Carts] WHERE [CartId] = @cartId
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId

-- ============================================================================
-- Statement 14: ProcessOrder - INSERT order (OrderProcessing.cs)
-- Original: INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total)
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total)

-- ============================================================================
-- Statement 15: CreateOrder - INSERT order detail (ShoppingCart.cs)
-- Original: INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (@orderId, @productId, @quantity, @unitPrice)
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice)

-- ============================================================================
-- Statement 16: Seed Categories (GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@categoryId, @name, @description)
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@categoryId, @name, @description)

-- ============================================================================
-- Statement 17: Seed Products (GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@productId, @categoryId, @name, @price, @productArtUrl)
-- Conversion: schema dbo -> gadgetsonline_dbo, lowercase names
-- ============================================================================
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl)
