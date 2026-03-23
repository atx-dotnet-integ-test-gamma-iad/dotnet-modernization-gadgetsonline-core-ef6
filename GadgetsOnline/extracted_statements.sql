-- ===================================================================
-- Extracted SQL Statements Catalog
-- Application: GadgetsOnline
-- Source Database: Microsoft SQL Server (dbo schema)
-- Extraction Date: 2026-03-23
-- Total Statements: 14
-- 
-- These are the conceptual SQL statements that Entity Framework 6
-- would generate from the LINQ-to-Entities queries in the Services layer.
-- ===================================================================

-- ===================================================================
-- Source File: Services/Inventory.cs
-- ===================================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Method: GetBestSellers(int count)
SELECT TOP 5 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2: GetAllCategories (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Method: GetAllCategories()
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Method: GetAllProductsInCategory(string category)
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Statement 4: GetProductById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Method: GetProductById(int id)
SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- Statement 5: GetProductNameById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Method: GetProductNameById(int id)
SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;

-- ===================================================================
-- Source File: Services/ShoppingCart.cs
-- ===================================================================

-- Statement 6: GetCartItems (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Method: GetCartItems()
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 7: GetCount (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Method: GetCount()
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 8: GetTotal (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Method: GetTotal()
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- Statement 9: AddToCart SELECT (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Method: AddToCart(int id) - Find existing cart item
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 10: AddToCart INSERT (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) followed by SaveChanges()
-- Method: AddToCart(int id) - Insert new cart item
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, @count, @dateCreated);

-- Statement 11: RemoveFromCart SELECT (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- Method: RemoveFromCart(int id) - Find cart item to remove
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 12: EmptyCart DELETE (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId) + Remove + SaveChanges
-- Method: EmptyCart()
DELETE FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 13: CreateOrder INSERT (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) followed by SaveChanges()
-- Method: CreateOrder(Order order) - Insert order details for each cart item
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- ===================================================================
-- Source File: Services/OrderProcessing.cs
-- ===================================================================

-- Statement 14: ProcessOrder INSERT (OrderProcessing.cs)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) followed by SaveChanges()
-- Method: ProcessOrder(Order order, HttpContext httpContext)
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
