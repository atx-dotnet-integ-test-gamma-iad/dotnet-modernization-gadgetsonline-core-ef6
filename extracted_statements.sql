-- ============================================================================
-- Extracted SQL Statements from GadgetsOnline EF6 LINQ Queries
-- Source: Entity Framework 6 LINQ expressions (no raw SQL in code)
-- These SQL statements represent what EF would generate at runtime
-- Total Statements: 19
-- Extraction Date: 2026-03-04
-- ============================================================================

-- ============================================================================
-- Source: Services/Inventory.cs - GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- ============================================================================
-- Statement 1: GetBestSellers
SELECT TOP(@count) * FROM dbo.Products;

-- ============================================================================
-- Source: Services/Inventory.cs - GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- ============================================================================
-- Statement 2: GetAllCategories
SELECT * FROM dbo.Categories;

-- ============================================================================
-- Source: Services/Inventory.cs - GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- ============================================================================
-- Statement 3: GetAllProductsInCategory
SELECT * FROM dbo.Products WHERE CategoryId IN (SELECT CategoryId FROM dbo.Categories WHERE Name = @category);

-- ============================================================================
-- Source: Services/Inventory.cs - GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- ============================================================================
-- Statement 4: GetProductById
SELECT * FROM dbo.Products WHERE ProductId = @id;

-- ============================================================================
-- Source: Services/Inventory.cs - GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- ============================================================================
-- Statement 5: GetProductNameById
SELECT Name FROM dbo.Products WHERE ProductId = @id;

-- ============================================================================
-- Source: Services/ShoppingCart.cs - AddToCart(int id) - lookup
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- ============================================================================
-- Statement 6: AddToCart lookup
SELECT * FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- ============================================================================
-- Source: Services/ShoppingCart.cs - AddToCart(int id) - insert new cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) + SaveChanges()
-- ============================================================================
-- Statement 7: AddToCart insert
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);

-- ============================================================================
-- Source: Services/ShoppingCart.cs - AddToCart(int id) - update existing
-- LINQ: cartItem.Count++ + SaveChanges()
-- ============================================================================
-- Statement 8: AddToCart update
UPDATE dbo.Carts SET Count = Count + 1 WHERE RecordId = @recordId;

-- ============================================================================
-- Source: Services/ShoppingCart.cs - GetCount()
-- LINQ: from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- ============================================================================
-- Statement 9: GetCount
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;

-- ============================================================================
-- Source: Services/ShoppingCart.cs - RemoveFromCart(int id) - decrement
-- LINQ: cartItem.Count-- + SaveChanges()
-- ============================================================================
-- Statement 10: RemoveFromCart decrement
UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @recordId;

-- ============================================================================
-- Source: Services/ShoppingCart.cs - RemoveFromCart(int id) - delete
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges()
-- ============================================================================
-- Statement 11: RemoveFromCart delete
DELETE FROM dbo.Carts WHERE RecordId = @recordId;

-- ============================================================================
-- Source: Services/ShoppingCart.cs - GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- ============================================================================
-- Statement 12: GetCartItems
SELECT * FROM dbo.Carts WHERE CartId = @cartId;

-- ============================================================================
-- Source: Services/ShoppingCart.cs - GetTotal()
-- LINQ: from cartItems in ... select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- ============================================================================
-- Statement 13: GetTotal
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- ============================================================================
-- Source: Services/ShoppingCart.cs - EmptyCart()
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) for each + SaveChanges()
-- ============================================================================
-- Statement 14: EmptyCart
DELETE FROM dbo.Carts WHERE CartId = @cartId;

-- ============================================================================
-- Source: Services/ShoppingCart.cs - CreateOrder(Order order) - insert order detail
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) + SaveChanges()
-- ============================================================================
-- Statement 15: CreateOrder insert order detail
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- ============================================================================
-- Source: Services/ShoppingCart.cs - CreateOrder(Order order) - update order total
-- LINQ: order.Total = orderTotal + SaveChanges()
-- ============================================================================
-- Statement 16: CreateOrder update order total
UPDATE dbo.Orders SET Total = @total WHERE OrderId = @orderId;

-- ============================================================================
-- Source: Services/OrderProcessing.cs - ProcessOrder(Order order)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) + SaveChanges()
-- ============================================================================
-- Statement 17: ProcessOrder insert order
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- Source: Models/GadgetsOnlineInitializer.cs - Seed data: Categories
-- LINQ: context.Categories.Add(c) for each category
-- ============================================================================
-- Statement 18: Seed Categories
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');

-- ============================================================================
-- Source: Models/GadgetsOnlineInitializer.cs - Seed data: Products
-- LINQ: context.Products.Add(p) for each product
-- ============================================================================
-- Statement 19: Seed Products
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');
