-- ============================================================================
-- Extracted SQL Statements from GadgetsOnline EF6 LINQ-to-Entities Application
-- Source Database: Microsoft SQL Server (dbo schema, PascalCase naming)
-- 
-- NOTE: This application uses Entity Framework 6 with LINQ-to-Entities queries
-- exclusively. There are NO raw/inline SQL strings in the source code.
-- These SQL statements represent the runtime-generated SQL equivalents
-- of the LINQ queries in the Services layer.
-- ============================================================================

-- ============================================================================
-- Source File: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers(count) - Retrieves top N products
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2: GetAllCategories() - Retrieves all categories
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory(category) - Products filtered by category name
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Statement 4: GetProductById(id) - Single product by ID
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- Statement 5: GetProductNameById(id) - Product name by ID
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;

-- ============================================================================
-- Source File: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: GetCartItems() - Cart items for current cart
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 7: GetCount() - Sum of item counts in cart
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 8: GetTotal() - Total price of cart items
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- Statement 9: AddToCart(id) - SELECT existing cart item
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 10: AddToCart(id) - INSERT new cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Add(new Cart { ... })
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);

-- Statement 11: AddToCart(id) - UPDATE existing cart item count
-- LINQ: cartItem.Count++ followed by _gadgetsOnlineEntities.SaveChanges()
UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 12: RemoveFromCart(id) - SELECT cart item (same as Statement 9)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 13: RemoveFromCart(id) - UPDATE decrement count
-- LINQ: cartItem.Count-- followed by _gadgetsOnlineEntities.SaveChanges()
UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 14: RemoveFromCart(id) - DELETE cart item when count reaches 0
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 15: EmptyCart() - DELETE all cart items for current cart
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) in foreach loop
DELETE FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 16: CreateOrder(order) - INSERT order details for each cart item
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(new OrderDetail { ... })
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- Statement 17: CreateOrder(order) - UPDATE order total
-- LINQ: order.Total = orderTotal followed by _gadgetsOnlineEntities.SaveChanges()
UPDATE dbo.Orders SET Total = @total WHERE OrderId = @orderId;

-- ============================================================================
-- Source File: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 18: ProcessOrder(order) - INSERT new order
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) followed by _gadgetsOnlineEntities.SaveChanges()
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
