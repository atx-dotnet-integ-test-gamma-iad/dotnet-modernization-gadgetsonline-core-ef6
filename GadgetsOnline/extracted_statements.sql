-- ============================================================================
-- EXTRACTED SQL STATEMENTS CATALOG
-- Source: GadgetsOnline EF6 LINQ Operations (MS SQL Server)
-- Generated as part of SQL Server to PostgreSQL migration
-- ============================================================================
-- All SQL statements are derived from EF6 LINQ operations since the
-- application uses Entity Framework 6 exclusively (no raw inline SQL).
-- Schema: dbo (SQL Server source schema)
-- ============================================================================

-- ==========================================================================
-- SOURCE FILE: Services/Inventory.cs
-- ==========================================================================

-- Statement 1: GetBestSellers - SELECT TOP products
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(@count) productid, categoryid, name, price, productarturl
FROM dbo.Products;

-- Statement 2: GetAllCategories - SELECT all categories
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT categoryid, name, description
FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory - SELECT products by category name (JOIN)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM dbo.Products p
INNER JOIN dbo.Categories c ON p.categoryid = c.categoryid
WHERE c.name = @category;

-- Statement 4: GetProductById - SELECT single product by ID
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP(1) productid, categoryid, name, price, productarturl
FROM dbo.Products
WHERE productid = @id;

-- Statement 5: GetProductNameById - SELECT product name by ID
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP(1) name
FROM dbo.Products
WHERE productid = @id;

-- ==========================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- ==========================================================================

-- Statement 6: GetCartItems - SELECT cart items by cart ID
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT recordid, cartid, productid, count, datecreated
FROM dbo.Carts
WHERE cartid = @cartId;

-- Statement 7: GetCount - SELECT SUM of item counts in cart
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT SUM(count)
FROM dbo.Carts
WHERE cartid = @cartId;

-- Statement 8: GetTotal - SELECT SUM of cart total (count * price with JOIN)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT SUM(c.count * p.price)
FROM dbo.Carts c
INNER JOIN dbo.Products p ON c.productid = p.productid
WHERE c.cartid = @cartId;

-- Statement 9: AddToCart (SELECT) - Find existing cart item
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT TOP(1) recordid, cartid, productid, count, datecreated
FROM dbo.Carts
WHERE cartid = @cartId AND productid = @productId;

-- Statement 10: AddToCart (INSERT) - Insert new cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) + SaveChanges()
INSERT INTO dbo.Carts (cartid, productid, count, datecreated)
VALUES (@cartId, @productId, @count, @dateCreated);

-- Statement 11: AddToCart (UPDATE) - Update cart item count
-- LINQ: cartItem.Count++ + SaveChanges()
UPDATE dbo.Carts
SET count = @count
WHERE recordid = @recordId;

-- Statement 12: RemoveFromCart (SELECT) - Find cart item to remove
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
SELECT TOP(1) recordid, cartid, productid, count, datecreated
FROM dbo.Carts
WHERE cartid = @cartId AND productid = @productId;

-- Statement 13: RemoveFromCart (UPDATE) - Decrement cart item count
-- LINQ: cartItem.Count-- + SaveChanges()
UPDATE dbo.Carts
SET count = @count
WHERE recordid = @recordId;

-- Statement 14: RemoveFromCart (DELETE) - Remove cart item entirely
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges()
DELETE FROM dbo.Carts
WHERE recordid = @recordId;

-- Statement 15: EmptyCart (SELECT) - Get all cart items for deletion
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
SELECT recordid, cartid, productid, count, datecreated
FROM dbo.Carts
WHERE cartid = @cartId;

-- Statement 16: EmptyCart (DELETE) - Delete each cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges()
DELETE FROM dbo.Carts
WHERE recordid = @recordId;

-- Statement 17: CreateOrder (INSERT OrderDetail) - Insert order detail
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) + SaveChanges()
INSERT INTO dbo.OrderDetails (productid, orderid, unitprice, quantity)
VALUES (@productId, @orderId, @unitPrice, @quantity);

-- Statement 18: CreateOrder (UPDATE Order) - Update order total
-- LINQ: order.Total = orderTotal + SaveChanges()
UPDATE dbo.Orders
SET total = @total
WHERE orderid = @orderId;

-- ==========================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- ==========================================================================

-- Statement 19: ProcessOrder (INSERT) - Insert new order
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) + SaveChanges()
INSERT INTO dbo.Orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total)
VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ==========================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- ==========================================================================

-- Statement 20: Seed (INSERT Category) - Insert seed categories
-- LINQ: context.Categories.Add(c) + SaveChanges()
INSERT INTO dbo.Categories (categoryid, name, description)
VALUES (@categoryId, @name, @description);

-- Statement 21: Seed (INSERT Product) - Insert seed products
-- LINQ: context.Products.Add(p) + SaveChanges()
INSERT INTO dbo.Products (productid, categoryid, name, price, productarturl)
VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
