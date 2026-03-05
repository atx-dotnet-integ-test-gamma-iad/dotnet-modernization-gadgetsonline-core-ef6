-- ============================================================================
-- Extracted SQL Statements Catalog
-- Source: GadgetsOnline .NET Application (EF6 LINQ-to-Entities)
-- These are the logical MS SQL Server SQL equivalents of the EF6 LINQ queries
-- ============================================================================

-- ============================================================================
-- 1. From Inventory.cs - GetBestSellers
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- ============================================================================
-- Statement 1: GetBestSellers
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products;

-- ============================================================================
-- 2. From Inventory.cs - GetAllCategories
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- ============================================================================
-- Statement 2: GetAllCategories
SELECT CategoryId, Name, Description FROM Categories;

-- ============================================================================
-- 3. From Inventory.cs - GetAllProductsInCategory
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- ============================================================================
-- Statement 3: GetAllProductsInCategory
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM Products p INNER JOIN Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- ============================================================================
-- 4. From Inventory.cs - GetProductById
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- ============================================================================
-- Statement 4: GetProductById
SELECT ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products WHERE ProductId = @id;

-- ============================================================================
-- 5. From Inventory.cs - GetProductNameById
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- ============================================================================
-- Statement 5: GetProductNameById
SELECT Name FROM Products WHERE ProductId = @id;

-- ============================================================================
-- 6. From ShoppingCart.cs - GetCartItems
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- ============================================================================
-- Statement 6: GetCartItems
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @cartId;

-- ============================================================================
-- 7. From ShoppingCart.cs - GetCount
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- ============================================================================
-- Statement 7: GetCount
SELECT SUM(Count) FROM Carts WHERE CartId = @cartId;

-- ============================================================================
-- 8. From ShoppingCart.cs - GetTotal
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- ============================================================================
-- Statement 8: GetTotal
SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- ============================================================================
-- 9. From ShoppingCart.cs - AddToCart (INSERT new item)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(new Cart { ... })
-- ============================================================================
-- Statement 9: AddToCart - INSERT
INSERT INTO Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, GETDATE());

-- ============================================================================
-- 10. From ShoppingCart.cs - AddToCart (UPDATE existing item count)
-- LINQ: cartItem.Count++; _gadgetsOnlineEntities.SaveChanges()
-- ============================================================================
-- Statement 10: AddToCart - UPDATE
UPDATE Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;

-- ============================================================================
-- 11. From ShoppingCart.cs - RemoveFromCart (UPDATE decrement count)
-- LINQ: cartItem.Count--; _gadgetsOnlineEntities.SaveChanges()
-- ============================================================================
-- Statement 11: RemoveFromCart - UPDATE
UPDATE Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId;

-- ============================================================================
-- 12. From ShoppingCart.cs - RemoveFromCart (DELETE item)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
-- ============================================================================
-- Statement 12: RemoveFromCart - DELETE
DELETE FROM Carts WHERE CartId = @cartId AND ProductId = @productId;

-- ============================================================================
-- 13. From ShoppingCart.cs - EmptyCart
-- LINQ: foreach (var cartItem in cartItems) { _gadgetsOnlineEntities.Carts.Remove(cartItem); }
-- ============================================================================
-- Statement 13: EmptyCart
DELETE FROM Carts WHERE CartId = @cartId;

-- ============================================================================
-- 14. From OrderProcessing.cs / ShoppingCart.cs - ProcessOrder (INSERT Order)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- ============================================================================
-- Statement 14: ProcessOrder - INSERT Order
INSERT INTO Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- 15. From ShoppingCart.cs - CreateOrder (INSERT OrderDetail)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
-- ============================================================================
-- Statement 15: CreateOrder - INSERT OrderDetail
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice);
