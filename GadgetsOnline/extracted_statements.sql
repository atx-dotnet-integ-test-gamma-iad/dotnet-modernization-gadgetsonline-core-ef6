-- ============================================================================
-- Extracted SQL Statements from GadgetsOnline EF6 LINQ Queries
-- Purpose: Catalog of all SQL statements identified from the EF6 LINQ queries
--          expressed as their equivalent MS SQL Server statements
-- Source Database: SQL Server with dbo schema, PascalCase column names
-- ============================================================================

-- ============================================================================
-- Statement 1: GetBestSellers (Inventory.cs - GetBestSellers method)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Description: Retrieves the top N products from the Products table
-- ============================================================================
SELECT TOP(@count) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products];

-- ============================================================================
-- Statement 2: GetAllCategories (Inventory.cs - GetAllCategories method)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Description: Retrieves all categories from the Categories table
-- ============================================================================
SELECT [CategoryId], [Name], [Description] FROM [dbo].[Categories];

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Inventory.cs - GetAllProductsInCategory method)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Description: Retrieves all products in a given category by joining Products with Categories
-- ============================================================================
SELECT [p].[ProductId], [p].[CategoryId], [p].[Name], [p].[Price], [p].[ProductArtUrl] FROM [dbo].[Products] AS [p] INNER JOIN [dbo].[Categories] AS [c] ON [p].[CategoryId] = [c].[CategoryId] WHERE [c].[Name] = @category;

-- ============================================================================
-- Statement 4: GetProductById (Inventory.cs - GetProductById method)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Description: Retrieves a single product by its ProductId
-- ============================================================================
SELECT TOP(1) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products] WHERE [ProductId] = @id;

-- ============================================================================
-- Statement 5: GetProductNameById (Inventory.cs - GetProductNameById method)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Description: Retrieves product name by ProductId (fetches full entity, accesses Name)
-- ============================================================================
SELECT TOP(1) [ProductId], [CategoryId], [Name], [Price], [ProductArtUrl] FROM [dbo].[Products] WHERE [ProductId] = @id;

-- ============================================================================
-- Statement 6: GetCartItems (ShoppingCart.cs - GetCartItems method)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Description: Retrieves all cart items for a given shopping cart ID
-- ============================================================================
SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @cartId;

-- ============================================================================
-- Statement 7: GetCount (ShoppingCart.cs - GetCount method)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Description: Sums the Count of all cart items for a given cart ID
-- ============================================================================
SELECT SUM([Count]) FROM [dbo].[Carts] WHERE [CartId] = @cartId;

-- ============================================================================
-- Statement 8: GetTotal (ShoppingCart.cs - GetTotal method)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Description: Calculates total price by summing Count * Price for cart items joined with Products
-- ============================================================================
SELECT SUM([c].[Count] * [p].[Price]) FROM [dbo].[Carts] AS [c] INNER JOIN [dbo].[Products] AS [p] ON [c].[ProductId] = [p].[ProductId] WHERE [c].[CartId] = @cartId;

-- ============================================================================
-- Statement 9: AddToCart - Select existing (ShoppingCart.cs - AddToCart method)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Description: Checks if a cart item already exists for the given cart and product
-- ============================================================================
SELECT TOP(1) [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @cartId AND [ProductId] = @productId;

-- ============================================================================
-- Statement 10: AddToCart - Insert new cart item (ShoppingCart.cs - AddToCart method)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) + SaveChanges
-- Description: Inserts a new cart item when it doesn't exist
-- ============================================================================
INSERT INTO [dbo].[Carts] ([CartId], [ProductId], [Count], [DateCreated]) VALUES (@cartId, @productId, @count, @dateCreated);

-- ============================================================================
-- Statement 11: AddToCart - Update cart count (ShoppingCart.cs - AddToCart method)
-- LINQ: cartItem.Count++ + SaveChanges
-- Description: Increments the Count when cart item already exists
-- ============================================================================
UPDATE [dbo].[Carts] SET [Count] = @count WHERE [RecordId] = @recordId;

-- ============================================================================
-- Statement 12: RemoveFromCart - Select cart item (ShoppingCart.cs - RemoveFromCart method)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- Description: Retrieves the specific cart item for removal
-- ============================================================================
SELECT TOP(1) [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @cartId AND [ProductId] = @productId;

-- ============================================================================
-- Statement 13: RemoveFromCart - Update count (ShoppingCart.cs - RemoveFromCart method)
-- LINQ: cartItem.Count-- + SaveChanges
-- Description: Decrements the Count when there are multiple items
-- ============================================================================
UPDATE [dbo].[Carts] SET [Count] = @count WHERE [RecordId] = @recordId;

-- ============================================================================
-- Statement 14: RemoveFromCart - Delete cart item (ShoppingCart.cs - RemoveFromCart method)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges
-- Description: Removes the cart item when Count reaches 1
-- ============================================================================
DELETE FROM [dbo].[Carts] WHERE [RecordId] = @recordId;

-- ============================================================================
-- Statement 15: EmptyCart - Select cart items (ShoppingCart.cs - EmptyCart method)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
-- Description: Selects all cart items for deletion
-- ============================================================================
SELECT [RecordId], [CartId], [ProductId], [Count], [DateCreated] FROM [dbo].[Carts] WHERE [CartId] = @cartId;

-- ============================================================================
-- Statement 16: EmptyCart - Delete cart item (ShoppingCart.cs - EmptyCart method)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges (in loop)
-- Description: Deletes each cart item from the cart
-- ============================================================================
DELETE FROM [dbo].[Carts] WHERE [RecordId] = @recordId;

-- ============================================================================
-- Statement 17: ProcessOrder - Insert order (OrderProcessing.cs - ProcessOrder method)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) + SaveChanges
-- Description: Inserts a new order record
-- ============================================================================
INSERT INTO [dbo].[Orders] ([OrderDate], [Username], [FirstName], [LastName], [Address], [City], [State], [PostalCode], [Country], [Phone], [Email], [Total]) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- Statement 18: CreateOrder - Insert order detail (ShoppingCart.cs - CreateOrder method)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) + SaveChanges
-- Description: Inserts order detail records for each cart item
-- ============================================================================
INSERT INTO [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- ============================================================================
-- Statement 19: CreateOrder - Update order total (ShoppingCart.cs - CreateOrder method)
-- LINQ: order.Total = orderTotal + SaveChanges
-- Description: Updates the order total after calculating from cart items
-- ============================================================================
UPDATE [dbo].[Orders] SET [Total] = @total WHERE [OrderId] = @orderId;

-- ============================================================================
-- Statement 20: Seed Categories (GadgetsOnlineInitializer.cs - Seed method)
-- LINQ: context.Categories.Add(c) + SaveChanges
-- Description: Inserts seed category data
-- ============================================================================
INSERT INTO [dbo].[Categories] ([CategoryId], [Name], [Description]) VALUES (@categoryId, @name, @description);

-- ============================================================================
-- Statement 21: Seed Products (GadgetsOnlineInitializer.cs - Seed method)
-- LINQ: context.Products.Add(p) + SaveChanges
-- Description: Inserts seed product data
-- ============================================================================
INSERT INTO [dbo].[Products] ([ProductId], [CategoryId], [Name], [Price], [ProductArtUrl]) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
