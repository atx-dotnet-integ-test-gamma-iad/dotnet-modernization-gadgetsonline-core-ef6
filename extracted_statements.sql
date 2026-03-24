-- ============================================================================
-- Extracted SQL Statements from EF6 LINQ Queries
-- Application: GadgetsOnline
-- Source Database: Microsoft SQL Server
-- Schema: dbo
-- ============================================================================
-- These SQL statements represent the equivalent SQL that Entity Framework 6
-- would generate from the LINQ queries found in the application's service layer
-- and initializer.
-- ============================================================================

-- ============================================================================
-- Statement 1: GetBestSellers (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Description: Retrieves top N products as best sellers
-- ============================================================================
SELECT TOP(@count) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p]

-- ============================================================================
-- Statement 2: GetAllCategories (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Description: Retrieves all categories
-- ============================================================================
SELECT [c].[CategoryId], [c].[Name], [c].[Description] FROM [dbo].[Categories] AS [c]

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Description: Retrieves all products in a given category by category name
-- ============================================================================
SELECT [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] INNER JOIN [dbo].[Categories] AS [c] ON [p].[CategoryId] = [c].[CategoryId] WHERE [c].[Name] = @category

-- ============================================================================
-- Statement 4: GetProductById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Description: Retrieves a single product by its ID
-- ============================================================================
SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id

-- ============================================================================
-- Statement 5: GetProductNameById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Description: Retrieves a product's name by its ID
-- ============================================================================
SELECT TOP(1) [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] WHERE [p].[ProductId] = @id

-- ============================================================================
-- Statement 6: GetCartItems (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Description: Retrieves all cart items for a given shopping cart
-- ============================================================================
SELECT [c].[RecordId], [c].[CartId], [c].[ProductId], [c].[Count], [c].[DateCreated] FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId

-- ============================================================================
-- Statement 7: GetCount (ShoppingCart.cs)
-- LINQ: (from cartItems in Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Description: Gets the total count of items in the cart
-- ============================================================================
SELECT SUM([c].[Count]) FROM [dbo].[Carts] AS [c] WHERE [c].[CartId] = @cartId

-- ============================================================================
-- Statement 8: GetTotal (ShoppingCart.cs)
-- LINQ: (from cartItems in Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Description: Gets the total price of all items in the cart
-- ============================================================================
SELECT SUM(CAST([c].[Count] AS DECIMAL(18,2)) * [p].[Price]) FROM [dbo].[Carts] AS [c] INNER JOIN [dbo].[Products] AS [p] ON [c].[ProductId] = [p].[ProductId] WHERE [c].[CartId] = @cartId

-- ============================================================================
-- Statement 9: AddToCart - INSERT new cart item (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem)  [when item doesn't exist]
-- Description: Inserts a new cart item when product is first added to cart
-- ============================================================================
INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@cartId, @productId, 1, @dateCreated)

-- ============================================================================
-- Statement 10: AddToCart - UPDATE existing cart item (ShoppingCart.cs)
-- LINQ: cartItem.Count++ then SaveChanges()  [when item exists]
-- Description: Increments count of an existing cart item
-- ============================================================================
UPDATE [dbo].[Carts] SET [Count] = [Count] + 1 WHERE [RecordId] = @recordId

-- ============================================================================
-- Statement 11: RemoveFromCart - UPDATE decrement count (ShoppingCart.cs)
-- LINQ: cartItem.Count-- then SaveChanges()  [when count > 1]
-- Description: Decrements count of a cart item
-- ============================================================================
UPDATE [dbo].[Carts] SET [Count] = [Count] - 1 WHERE [RecordId] = @recordId

-- ============================================================================
-- Statement 12: RemoveFromCart - DELETE cart item (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)  [when count <= 1]
-- Description: Removes a cart item when count reaches zero
-- ============================================================================
DELETE FROM [dbo].[Carts] WHERE [RecordId] = @recordId

-- ============================================================================
-- Statement 13: EmptyCart (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) for each item in cart
-- Description: Removes all items from a shopping cart
-- ============================================================================
DELETE FROM [dbo].[Carts] WHERE [CartId] = @cartId

-- ============================================================================
-- Statement 14: ProcessOrder - INSERT order (OrderProcessing.cs)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- Description: Inserts a new order record
-- ============================================================================
INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total)

-- ============================================================================
-- Statement 15: CreateOrder - INSERT order detail (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
-- Description: Inserts order detail records for each cart item
-- ============================================================================
INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (@orderId, @productId, @quantity, @unitPrice)

-- ============================================================================
-- Statement 16: Seed Categories (GadgetsOnlineInitializer.cs)
-- LINQ: context.Categories.Add(c) for each category
-- Description: Inserts seed data for categories
-- ============================================================================
INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@categoryId, @name, @description)

-- ============================================================================
-- Statement 17: Seed Products (GadgetsOnlineInitializer.cs)
-- LINQ: context.Products.Add(p) for each product
-- Description: Inserts seed data for products
-- ============================================================================
INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@productId, @categoryId, @name, @price, @productArtUrl)
