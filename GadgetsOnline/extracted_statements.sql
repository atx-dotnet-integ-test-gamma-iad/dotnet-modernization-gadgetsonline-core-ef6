-- ============================================================================
-- Extracted SQL Statements Catalog
-- Application: GadgetsOnline
-- Migration: MS SQL Server to PostgreSQL
-- Note: This application uses Entity Framework 6 with LINQ queries exclusively.
--       No raw/inline SQL statements exist in the codebase. These SQL statements
--       represent the SQL that EF6 would generate for each LINQ operation.
-- Total Statements: 16
-- ============================================================================

-- ============================================================================
-- Statement 1: GetBestSellers (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Source: Services/Inventory.cs - GetBestSellers method
-- ============================================================================
SELECT TOP(@p0) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products];

-- ============================================================================
-- Statement 2: GetAllCategories (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Source: Services/Inventory.cs - GetAllCategories method
-- ============================================================================
SELECT [CategoryId], [Name], [Description] FROM [dbo].[Categories];

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Source: Services/Inventory.cs - GetAllProductsInCategory method
-- ============================================================================
SELECT p.[ProductId], p.[CategoryId], p.[Name], p.[Price], p.[ProductArtUrl] FROM [dbo].[Products] p INNER JOIN [dbo].[Categories] c ON p.[CategoryId] = c.[CategoryId] WHERE c.[Name] = @p0;

-- ============================================================================
-- Statement 4: GetProductById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Source: Services/Inventory.cs - GetProductById method
-- ============================================================================
SELECT TOP(1) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products] WHERE [ProductId] = @p0;

-- ============================================================================
-- Statement 5: AddToCart - Find existing cart item (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Source: Services/ShoppingCart.cs - AddToCart method
-- ============================================================================
SELECT TOP(1) [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @p0 AND [ProductId] = @p1;

-- ============================================================================
-- Statement 6: AddToCart - Insert new cart item (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) + SaveChanges()
-- Source: Services/ShoppingCart.cs - AddToCart method
-- ============================================================================
INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@p0, @p1, @p2, @p3);

-- ============================================================================
-- Statement 7: AddToCart/RemoveFromCart - Update cart count (ShoppingCart.cs)
-- LINQ: cartItem.Count++ or cartItem.Count-- + SaveChanges()
-- Source: Services/ShoppingCart.cs - AddToCart/RemoveFromCart methods
-- ============================================================================
UPDATE [dbo].[Carts] SET [Count] = @p0 WHERE [RecordId] = @p1;

-- ============================================================================
-- Statement 8: GetCount (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Source: Services/ShoppingCart.cs - GetCount method
-- ============================================================================
SELECT SUM([Count]) FROM [dbo].[Carts] WHERE [CartId] = @p0;

-- ============================================================================
-- Statement 9: RemoveFromCart/EmptyCart - Delete cart item (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges()
-- Source: Services/ShoppingCart.cs - RemoveFromCart/EmptyCart methods
-- ============================================================================
DELETE FROM [dbo].[Carts] WHERE [RecordId] = @p0;

-- ============================================================================
-- Statement 10: GetTotal (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Source: Services/ShoppingCart.cs - GetTotal method
-- ============================================================================
SELECT SUM(c.[Count] * p.[Price]) FROM [dbo].[Carts] c INNER JOIN [dbo].[Products] p ON c.[ProductId] = p.[ProductId] WHERE c.[CartId] = @p0;

-- ============================================================================
-- Statement 11: GetCartItems/EmptyCart - Select cart items (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Source: Services/ShoppingCart.cs - GetCartItems/EmptyCart methods
-- ============================================================================
SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @p0;

-- ============================================================================
-- Statement 12: ProcessOrder - Insert order (OrderProcessing.cs)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) + SaveChanges()
-- Source: Services/OrderProcessing.cs - ProcessOrder method
-- ============================================================================
INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);

-- ============================================================================
-- Statement 13: CreateOrder - Insert order detail (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) + SaveChanges()
-- Source: Services/ShoppingCart.cs - CreateOrder method
-- ============================================================================
INSERT INTO [dbo].[OrderDetails] ([ProductId], [OrderId], [UnitPrice], [Quantity]) VALUES (@p0, @p1, @p2, @p3);

-- ============================================================================
-- Statement 14: CreateOrder - Update order total (ShoppingCart.cs)
-- LINQ: order.Total = orderTotal + SaveChanges()
-- Source: Services/ShoppingCart.cs - CreateOrder method
-- ============================================================================
UPDATE [dbo].[Orders] SET [Total] = @p0 WHERE [OrderId] = @p1;

-- ============================================================================
-- Statement 15: Seed - Insert category (GadgetsOnlineInitializer.cs)
-- LINQ: context.Categories.Add(c) + SaveChanges()
-- Source: Models/GadgetsOnlineInitializer.cs - Seed method
-- ============================================================================
INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@p0, @p1, @p2);

-- ============================================================================
-- Statement 16: Seed - Insert product (GadgetsOnlineInitializer.cs)
-- LINQ: context.Products.Add(p) + SaveChanges()
-- Source: Models/GadgetsOnlineInitializer.cs - Seed method
-- ============================================================================
INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@p0, @p1, @p2, @p3, @p4);
