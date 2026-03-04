-- ============================================================================
-- EXTRACTED SQL STATEMENTS - GadgetsOnline Application
-- MS SQL Server Equivalent Statements from EF6 LINQ Operations
-- Total Statements: 16
-- ============================================================================

-- ============================================================================
-- Source File: Services/Inventory.cs
-- 5 Statements
-- ============================================================================

-- Statement 1
-- Source: Services/Inventory.cs
-- Method: GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(@p0) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2
-- Source: Services/Inventory.cs
-- Method: GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 3
-- Source: Services/Inventory.cs
-- Method: GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @p0;

-- Statement 4
-- Source: Services/Inventory.cs
-- Method: GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @p0;

-- Statement 5
-- Source: Services/Inventory.cs
-- Method: GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP(1) Name FROM dbo.Products WHERE ProductId = @p0;

-- ============================================================================
-- Source File: Services/ShoppingCart.cs
-- 10 Statements
-- ============================================================================

-- Statement 6
-- Source: Services/ShoppingCart.cs
-- Method: GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @p0;

-- Statement 7
-- Source: Services/ShoppingCart.cs
-- Method: GetCount()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @p0;

-- Statement 8
-- Source: Services/ShoppingCart.cs
-- Method: GetTotal()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @p0;

-- Statement 9
-- Source: Services/ShoppingCart.cs
-- Method: AddToCart(int id) - SELECT part
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @p0 AND ProductId = @p1;

-- Statement 10
-- Source: Services/ShoppingCart.cs
-- Method: AddToCart(int id) - INSERT part
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) / _gadgetsOnlineEntities.SaveChanges()
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@p0, @p1, @p2, @p3);

-- Statement 11
-- Source: Services/ShoppingCart.cs
-- Method: RemoveFromCart(int id) - SELECT part
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @p0 AND ProductId = @p1;

-- Statement 12
-- Source: Services/ShoppingCart.cs
-- Method: RemoveFromCart(int id) - DELETE part
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) / _gadgetsOnlineEntities.SaveChanges()
DELETE FROM dbo.Carts WHERE RecordId = @p0;

-- Statement 13
-- Source: Services/ShoppingCart.cs
-- Method: EmptyCart()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId) / Remove each / SaveChanges()
DELETE FROM dbo.Carts WHERE CartId = @p0;

-- Statement 14
-- Source: Services/ShoppingCart.cs
-- Method: CreateOrder(Order order) - INSERT OrderDetails
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) / _gadgetsOnlineEntities.SaveChanges()
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@p0, @p1, @p2, @p3);

-- Statement 15
-- Source: Services/ShoppingCart.cs
-- Method: CreateOrder(Order order) - UPDATE Order Total
-- LINQ: order.Total = orderTotal / _gadgetsOnlineEntities.SaveChanges()
UPDATE dbo.Orders SET Total = @p0 WHERE OrderId = @p1;

-- ============================================================================
-- Source File: Services/OrderProcessing.cs
-- 1 Statement
-- ============================================================================

-- Statement 16
-- Source: Services/OrderProcessing.cs
-- Method: ProcessOrder(Order order, HttpContext httpContext)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) / _gadgetsOnlineEntities.SaveChanges()
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9, @p10, @p11);
