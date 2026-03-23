-- ============================================================================
-- EXTRACTED SQL STATEMENTS CATALOG
-- Source: GadgetsOnline .NET Application (EF6 LINQ-to-Entities derived)
-- Date: 2026-03-23
-- Total Statements: 19
-- DMS Migration Project: arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII
-- DMS Status: ALL 19 statements failed - Metadata model creation error
-- DMS Error: "No objects were found according to the specified selection rules."
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt Timestamps: 2026-03-23T09:11:20 through 2026-03-23T09:17:01
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- DMS Attempt: 2026-03-23T09:11:20 - FAILED (error_timestamp: 2026-03-23T09:11:35)
SELECT TOP(@p__linq__0) [Extent1].[ProductId] AS [ProductId], [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Price] AS [Price], [Extent1].[ProductArtUrl] AS [ProductArtUrl] FROM [dbo].[Products] AS [Extent1];

-- Statement 2: GetAllCategories (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- DMS Attempt: 2026-03-23T09:11:35 - FAILED (error_timestamp: 2026-03-23T09:11:50)
SELECT [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Description] AS [Description] FROM [dbo].[Categories] AS [Extent1];

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- DMS Attempt: 2026-03-23T09:11:51 - FAILED (error_timestamp: 2026-03-23T09:12:05)
SELECT [Extent1].[ProductId] AS [ProductId], [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Price] AS [Price], [Extent1].[ProductArtUrl] AS [ProductArtUrl] FROM [dbo].[Products] AS [Extent1] INNER JOIN [dbo].[Categories] AS [Extent2] ON [Extent1].[CategoryId] = [Extent2].[CategoryId] WHERE [Extent2].[Name] = @p__linq__0;

-- Statement 4: GetProductById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- DMS Attempt: 2026-03-23T09:12:06 - FAILED (error_timestamp: 2026-03-23T09:12:21)
SELECT TOP 1 [Extent1].[ProductId] AS [ProductId], [Extent1].[CategoryId] AS [CategoryId], [Extent1].[Name] AS [Name], [Extent1].[Price] AS [Price], [Extent1].[ProductArtUrl] AS [ProductArtUrl] FROM [dbo].[Products] AS [Extent1] WHERE [Extent1].[ProductId] = @p__linq__0;

-- Statement 5: GetProductNameById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- DMS Attempt: 2026-03-23T09:12:21 - FAILED (error_timestamp: 2026-03-23T09:12:36)
SELECT TOP 1 [Extent1].[Name] FROM [dbo].[Products] AS [Extent1] WHERE [Extent1].[ProductId] = @p__linq__0;

-- ============================================================================
-- SOURCE FILE: ShoppingCart.cs
-- ============================================================================

-- Statement 6: CreateOrder - Insert OrderDetail (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
-- DMS Attempt: 2026-03-23T09:12:55 - FAILED (error_timestamp: 2026-03-23T09:13:10)
INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);

-- Statement 7: CreateOrder - Update Order Total (ShoppingCart.cs)
-- LINQ: order.Total = orderTotal; _gadgetsOnlineEntities.SaveChanges()
-- DMS Attempt: 2026-03-23T09:13:10 - FAILED (error_timestamp: 2026-03-23T09:13:25)
UPDATE [dbo].[Orders] SET [Total] = @Total WHERE [OrderId] = @OrderId;

-- Statement 8: EmptyCart - Select carts to delete (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
-- DMS Attempt: 2026-03-23T09:13:26 - FAILED (error_timestamp: 2026-03-23T09:13:40)
SELECT [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0;

-- Statement 9: EmptyCart - Delete cart items (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) (in loop)
-- DMS Attempt: 2026-03-23T09:13:41 - FAILED (error_timestamp: 2026-03-23T09:13:56)
DELETE FROM [dbo].[Carts] WHERE [RecordId] = @RecordId;

-- Statement 10: AddToCart - Find existing cart item (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- DMS Attempt: 2026-03-23T09:13:56 - FAILED (error_timestamp: 2026-03-23T09:14:11)
SELECT TOP 1 [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0 AND [Extent1].[ProductId] = @p__linq__1;

-- Statement 11: AddToCart - Insert new cart item (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem)
-- DMS Attempt: 2026-03-23T09:14:27 - FAILED (error_timestamp: 2026-03-23T09:14:42)
INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- Statement 12: AddToCart - Update count (ShoppingCart.cs)
-- LINQ: cartItem.Count++; _gadgetsOnlineEntities.SaveChanges()
-- DMS Attempt: 2026-03-23T09:14:43 - FAILED (error_timestamp: 2026-03-23T09:14:57)
UPDATE [dbo].[Carts] SET [Count] = @Count WHERE [RecordId] = @RecordId;

-- Statement 13: GetCount (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- DMS Attempt: 2026-03-23T09:14:58 - FAILED (error_timestamp: 2026-03-23T09:15:13)
SELECT SUM([Extent1].[Count]) FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0;

-- Statement 14: RemoveFromCart - Find cart item (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- DMS Attempt: 2026-03-23T09:15:13 - FAILED (error_timestamp: 2026-03-23T09:15:28)
SELECT [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0 AND [Extent1].[ProductId] = @p__linq__1;

-- Statement 15: RemoveFromCart - Decrement count (ShoppingCart.cs)
-- LINQ: cartItem.Count--; _gadgetsOnlineEntities.SaveChanges()
-- DMS Attempt: 2026-03-23T09:15:29 - FAILED (error_timestamp: 2026-03-23T09:15:43)
UPDATE [dbo].[Carts] SET [Count] = [Count] - 1 WHERE [RecordId] = @RecordId;

-- Statement 16: RemoveFromCart - Delete cart item (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
-- DMS Attempt: 2026-03-23T09:16:00 - FAILED (error_timestamp: 2026-03-23T09:16:15)
DELETE FROM [dbo].[Carts] WHERE [CartId] = @CartId AND [ProductId] = @ProductId;

-- Statement 17: GetCartItems (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- DMS Attempt: 2026-03-23T09:16:15 - FAILED (error_timestamp: 2026-03-23T09:16:30)
SELECT [Extent1].[RecordId] AS [RecordId], [Extent1].[CartId] AS [CartId], [Extent1].[ProductId] AS [ProductId], [Extent1].[Count] AS [Count], [Extent1].[DateCreated] AS [DateCreated] FROM [dbo].[Carts] AS [Extent1] WHERE [Extent1].[CartId] = @p__linq__0;

-- Statement 18: GetTotal (ShoppingCart.cs)
-- LINQ: (from cartItems in ... select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- DMS Attempt: 2026-03-23T09:16:31 - FAILED (error_timestamp: 2026-03-23T09:16:45)
SELECT SUM([Extent1].[Count] * [Extent2].[Price]) FROM [dbo].[Carts] AS [Extent1] INNER JOIN [dbo].[Products] AS [Extent2] ON [Extent1].[ProductId] = [Extent2].[ProductId] WHERE [Extent1].[CartId] = @p__linq__0;

-- ============================================================================
-- SOURCE FILE: OrderProcessing.cs
-- ============================================================================

-- Statement 19: ProcessOrder - Insert order (OrderProcessing.cs)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- DMS Attempt: 2026-03-23T09:16:46 - FAILED (error_timestamp: 2026-03-23T09:17:01)
INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);
