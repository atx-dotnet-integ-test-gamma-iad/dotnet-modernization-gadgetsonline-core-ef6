-- ============================================================================
-- Extracted SQL Statements from GadgetsOnline EF6 LINQ Queries
-- Source: Microsoft SQL Server (dbo schema)
-- Extraction Date: 2026-03-21
-- Verified and Regenerated: 2026-03-21
-- Total Statements: 19
-- Note: These are the SQL Server equivalents of EF6 LINQ queries
-- ============================================================================

-- ============================================================================
-- Source: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(5) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2: GetAllCategories (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Statement 4: GetProductById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- Statement 5: GetProductNameById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT Name FROM dbo.Products WHERE ProductId = @id;

-- ============================================================================
-- Source: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: GetCartItems (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 7: GetCount (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 8: GetTotal (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- Statement 9: AddToCart - SELECT (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 10: AddToCart - INSERT (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem)
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);

-- Statement 11: AddToCart - UPDATE (ShoppingCart.cs)
-- LINQ: cartItem.Count++ followed by _gadgetsOnlineEntities.SaveChanges()
UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 12: RemoveFromCart - SELECT (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 13: RemoveFromCart - DELETE (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
DELETE FROM dbo.Carts WHERE RecordId = @recordId;

-- Statement 14: RemoveFromCart - UPDATE (ShoppingCart.cs)
-- LINQ: cartItem.Count-- followed by _gadgetsOnlineEntities.SaveChanges()
UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @recordId;

-- Statement 15: EmptyCart (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId) + Remove each
DELETE FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 16: CreateOrder - INSERT OrderDetail (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- ============================================================================
-- Source: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 17: ProcessOrder - INSERT Order (OrderProcessing.cs)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) + SaveChanges()
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- Source: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 18: Seed - INSERT Category (GadgetsOnlineInitializer.cs)
-- LINQ: context.Categories.Add(c) for each category
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@categoryId, @name, @description);

-- Statement 19: Seed - INSERT Product (GadgetsOnlineInitializer.cs)
-- LINQ: context.Products.Add(p) for each product
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
