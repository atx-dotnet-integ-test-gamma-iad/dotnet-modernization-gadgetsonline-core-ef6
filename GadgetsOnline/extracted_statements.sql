-- ============================================================================
-- Extracted SQL Statements Catalog
-- Application: GadgetsOnline
-- Source Database: Microsoft SQL Server
-- Extraction Method: LINQ-to-SQL equivalent translation from Entity Framework LINQ queries
-- ============================================================================
-- NOTE: This application uses Entity Framework 6 with LINQ-to-Entities.
-- No raw ADO.NET SQL statements (SqlConnection, SqlCommand, etc.) are used.
-- The following SQL statements represent the equivalent SQL that EF generates
-- for each LINQ query in the Services layer.
-- ============================================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Location: Services/Inventory.cs, method GetBestSellers
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl
FROM dbo.Products;

-- Statement 2: GetAllCategories (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Location: Services/Inventory.cs, method GetAllCategories
SELECT CategoryId, Name, Description
FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Location: Services/Inventory.cs, method GetAllProductsInCategory
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl
FROM dbo.Products p
INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId
WHERE c.Name = @category;

-- Statement 4: GetProductById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Location: Services/Inventory.cs, method GetProductById
SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl
FROM dbo.Products
WHERE ProductId = @id;

-- Statement 5: GetProductNameById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Location: Services/Inventory.cs, method GetProductNameById
SELECT TOP(1) Name
FROM dbo.Products
WHERE ProductId = @id;

-- Statement 6: GetCartItems (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Location: Services/ShoppingCart.cs, method GetCartItems
SELECT RecordId, CartId, ProductId, Count, DateCreated
FROM dbo.Carts
WHERE CartId = @cartId;

-- Statement 7: GetTotal (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Location: Services/ShoppingCart.cs, method GetTotal
SELECT SUM(CAST(c.Count AS INT) * p.Price)
FROM dbo.Carts c
INNER JOIN dbo.Products p ON c.ProductId = p.ProductId
WHERE c.CartId = @cartId;

-- Statement 8: GetCount (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Location: Services/ShoppingCart.cs, method GetCount
SELECT SUM(Count)
FROM dbo.Carts
WHERE CartId = @cartId;

-- Statement 9: AddToCart - Check existing (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Location: Services/ShoppingCart.cs, method AddToCart
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated
FROM dbo.Carts
WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 10: AddToCart - Insert new cart item (ShoppingCart.cs)
-- Location: Services/ShoppingCart.cs, method AddToCart
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated)
VALUES (@cartId, @productId, 1, @dateCreated);

-- Statement 11: AddToCart - Update count (ShoppingCart.cs)
-- Location: Services/ShoppingCart.cs, method AddToCart
UPDATE dbo.Carts
SET Count = Count + 1
WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 12: RemoveFromCart - Get cart item (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- Location: Services/ShoppingCart.cs, method RemoveFromCart
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated
FROM dbo.Carts
WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 13: RemoveFromCart - Decrement count (ShoppingCart.cs)
-- Location: Services/ShoppingCart.cs, method RemoveFromCart
UPDATE dbo.Carts
SET Count = Count - 1
WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 14: RemoveFromCart - Delete item (ShoppingCart.cs)
-- Location: Services/ShoppingCart.cs, method RemoveFromCart
DELETE FROM dbo.Carts
WHERE RecordId = @recordId;

-- Statement 15: EmptyCart (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
-- Location: Services/ShoppingCart.cs, method EmptyCart
DELETE FROM dbo.Carts
WHERE CartId = @cartId;

-- Statement 16: ProcessOrder - Insert Order (OrderProcessing.cs)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- Location: Services/OrderProcessing.cs, method ProcessOrder
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total)
VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- Statement 17: CreateOrder - Insert OrderDetail (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
-- Location: Services/ShoppingCart.cs, method CreateOrder
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity)
VALUES (@productId, @orderId, @unitPrice, @quantity);

-- Statement 18: CreateOrder - Update Order Total (ShoppingCart.cs)
-- LINQ: order.Total = orderTotal; _gadgetsOnlineEntities.SaveChanges();
-- Location: Services/ShoppingCart.cs, method CreateOrder
UPDATE dbo.Orders
SET Total = @total
WHERE OrderId = @orderId;
