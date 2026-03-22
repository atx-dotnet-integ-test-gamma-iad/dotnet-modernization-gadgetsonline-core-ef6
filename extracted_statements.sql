-- ============================================================
-- Extracted MS SQL Server Statements from GadgetsOnline Application
-- Source: EF6 LINQ-to-SQL equivalent queries
-- Extraction Date: 2026-03-22
-- Re-extracted for Step 1 DMS re-attempt: 2026-03-22
-- Total Statements: 12
-- ============================================================

-- Statement 1: Inventory.cs - GetBestSellers
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- DMS Attempt: 2026-03-22T23:10:19 - FAILED (Metadata model creation failed)
SELECT TOP(@count) * FROM Products;

-- Statement 2: Inventory.cs - GetAllCategories
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- DMS Attempt: 2026-03-22T23:11:18 - FAILED (Metadata model creation failed)
SELECT * FROM Categories;

-- Statement 3: Inventory.cs - GetAllProductsInCategory
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- DMS Attempt: 2026-03-22T23:11:41 - FAILED (Metadata model creation failed)
SELECT * FROM Products WHERE CategoryId IN (SELECT CategoryId FROM Categories WHERE Name = @category);

-- Statement 4: Inventory.cs - GetProductById
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- DMS Attempt: 2026-03-22T23:12:05 - FAILED (Metadata model creation failed)
SELECT TOP 1 * FROM Products WHERE ProductId = @id;

-- Statement 5: Inventory.cs - GetProductNameById
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- DMS Attempt: 2026-03-22T23:12:32 - FAILED (Metadata model creation failed)
SELECT TOP 1 Name FROM Products WHERE ProductId = @id;

-- Statement 6: ShoppingCart.cs - GetCartItems
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- DMS Attempt: 2026-03-22T23:12:54 - FAILED (Metadata model creation failed)
SELECT * FROM Carts WHERE CartId = @cartId;

-- Statement 7: ShoppingCart.cs - GetCount
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- DMS Attempt: 2026-03-22T23:13:17 - FAILED (Metadata model creation failed)
SELECT SUM(Count) FROM Carts WHERE CartId = @cartId;

-- Statement 8: ShoppingCart.cs - GetTotal
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- DMS Attempt: 2026-03-22T23:13:44 - FAILED (Metadata model creation failed)
SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- Statement 9: ShoppingCart.cs - AddToCart (lookup)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- DMS Attempt: 2026-03-22T23:14:07 - FAILED (Metadata model creation failed)
SELECT * FROM Carts WHERE CartId = @cartId AND ProductId = @id;

-- Statement 10: ShoppingCart.cs - RemoveFromCart (SELECT + UPDATE/DELETE)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id) + conditional update/delete
-- DMS Attempt: 2026-03-22T23:14:30 - FAILED (Metadata model creation failed)
SELECT * FROM Carts WHERE CartId = @cartId AND ProductId = @id;
UPDATE Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @id;
DELETE FROM Carts WHERE CartId = @cartId AND ProductId = @id AND Count = 0;

-- Statement 11: ShoppingCart.cs - EmptyCart
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId) + Remove each
-- DMS Attempt: 2026-03-22T23:14:53 - FAILED (Metadata model creation failed)
DELETE FROM Carts WHERE CartId = @cartId;

-- Statement 12: ShoppingCart.cs - CreateOrder (INSERT OrderDetails + UPDATE Order total)
-- LINQ: foreach cart item -> _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) + order.Total = orderTotal + SaveChanges
-- DMS Attempt: 2026-03-22T23:15:17 - FAILED (Metadata model creation failed)
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) SELECT @orderId, ProductId, Count, p.Price FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;
UPDATE Orders SET Total = (SELECT SUM(Quantity * UnitPrice) FROM OrderDetails WHERE OrderId = @orderId) WHERE OrderId = @orderId;
