-- ============================================================================
-- Extracted SQL Statements (MS SQL Server equivalents of Entity Framework LINQ queries)
-- Application: GadgetsOnline
-- Source: Entity Framework 6 LINQ queries from Services layer
-- Schema: dbo (SQL Server)
-- Extraction Timestamp: 2026-03-24
-- ============================================================================

-- ============================================================================
-- Statement 1: GetBestSellers (Services/Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- ============================================================================
SELECT TOP(5) p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl
FROM dbo.Products p
INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId;

-- ============================================================================
-- Statement 2: GetAllCategories (Services/Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- ============================================================================
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Services/Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- ============================================================================
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl
FROM dbo.Products p
INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId
WHERE c.Name = @category;

-- ============================================================================
-- Statement 4: GetProductById (Services/Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- ============================================================================
SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl
FROM dbo.Products
WHERE ProductId = @id;

-- ============================================================================
-- Statement 5: GetProductNameById (Services/Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- ============================================================================
SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;

-- ============================================================================
-- Statement 6: GetCartItems (Services/ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- ============================================================================
SELECT RecordId, CartId, ProductId, Count, DateCreated
FROM dbo.Carts
WHERE CartId = @cartId;

-- ============================================================================
-- Statement 7: GetCount (Services/ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- ============================================================================
SELECT ISNULL(SUM(Count), 0) FROM dbo.Carts WHERE CartId = @cartId;

-- ============================================================================
-- Statement 8: GetTotal (Services/ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- ============================================================================
SELECT ISNULL(SUM(c.Count * p.Price), 0)
FROM dbo.Carts c
INNER JOIN dbo.Products p ON c.ProductId = p.ProductId
WHERE c.CartId = @cartId;

-- ============================================================================
-- Statement 9: AddToCart - SELECT single (Services/ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- ============================================================================
SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated
FROM dbo.Carts
WHERE CartId = @cartId AND ProductId = @id;

-- ============================================================================
-- Statement 10: AddToCart - INSERT (Services/ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem)
-- ============================================================================
INSERT INTO dbo.Carts (ProductId, CartId, Count, DateCreated)
VALUES (@productId, @cartId, 1, @dateCreated);

-- ============================================================================
-- Statement 11: AddToCart - UPDATE (Services/ShoppingCart.cs)
-- LINQ: cartItem.Count++ / _gadgetsOnlineEntities.SaveChanges()
-- ============================================================================
UPDATE dbo.Carts SET Count = Count + 1
WHERE CartId = @cartId AND ProductId = @id;

-- ============================================================================
-- Statement 12: RemoveFromCart - SELECT (Services/ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- ============================================================================
SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated
FROM dbo.Carts
WHERE CartId = @cartId AND ProductId = @productId;

-- ============================================================================
-- Statement 13: RemoveFromCart - UPDATE (Services/ShoppingCart.cs)
-- LINQ: cartItem.Count-- / _gadgetsOnlineEntities.SaveChanges()
-- ============================================================================
UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @recordId;

-- ============================================================================
-- Statement 14: RemoveFromCart - DELETE (Services/ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
-- ============================================================================
DELETE FROM dbo.Carts WHERE RecordId = @recordId;

-- ============================================================================
-- Statement 15: EmptyCart (Services/ShoppingCart.cs)
-- LINQ: foreach removal of Carts where CartId == ShoppingCartId
-- ============================================================================
DELETE FROM dbo.Carts WHERE CartId = @cartId;

-- ============================================================================
-- Statement 16: CreateOrder - INSERT OrderDetail (Services/ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
-- ============================================================================
INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice)
VALUES (@orderId, @productId, @quantity, @unitPrice);

-- ============================================================================
-- Statement 17: CreateOrder - UPDATE Order Total (Services/ShoppingCart.cs)
-- LINQ: order.Total = orderTotal / _gadgetsOnlineEntities.SaveChanges()
-- ============================================================================
UPDATE dbo.Orders SET Total = @total WHERE OrderId = @orderId;

-- ============================================================================
-- Statement 18: ProcessOrder - INSERT Order (Services/OrderProcessing.cs)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- ============================================================================
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total)
VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
