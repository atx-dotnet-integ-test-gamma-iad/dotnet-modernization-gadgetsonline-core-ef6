-- ============================================================
-- Extracted SQL Statements - GadgetsOnline Migration
-- Source: SQL Server (dbo schema)
-- Extracted from: EF6 LINQ-to-Entities queries in service layer
-- ============================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(@count) productid, categoryid, name, price, productarturl FROM dbo.Products;

-- Statement 2: GetAllCategories (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT * FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP 1 productid, categoryid, name, price, productarturl FROM dbo.Products WHERE productid = @id;

-- Statement 5: GetProductNameById (Inventory.cs)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP 1 name FROM dbo.Products WHERE productid = @id;

-- Statement 6: GetCartItems (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartId;

-- Statement 7: AddToCart - Find existing (ShoppingCart.cs)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT TOP 1 recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartId AND productid = @productId;

-- Statement 8: AddToCart - Insert new (ShoppingCart.cs)
-- EF6: _gadgetsOnlineEntities.Carts.Add(cartItem) + SaveChanges()
INSERT INTO dbo.Carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, @count, @dateCreated);

-- Statement 9: AddToCart/RemoveFromCart - Update count (ShoppingCart.cs)
-- EF6: cartItem.Count++ / cartItem.Count-- + SaveChanges()
UPDATE dbo.Carts SET count = @count WHERE recordid = @recordId;

-- Statement 10: GetCount (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT SUM(count) FROM dbo.Carts WHERE cartid = @cartId;

-- Statement 11: GetTotal (ShoppingCart.cs)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT SUM(c.count * p.price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- Statement 12: EmptyCart (ShoppingCart.cs)
-- EF6: foreach cartItem in query -> _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges()
DELETE FROM dbo.Carts WHERE cartid = @cartId;

-- Statement 13: RemoveFromCart - Delete single (ShoppingCart.cs)
-- EF6: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges()
DELETE FROM dbo.Carts WHERE recordid = @recordId;

-- Statement 14: CreateOrder - Insert order details (ShoppingCart.cs)
-- EF6: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) + SaveChanges()
INSERT INTO dbo.OrderDetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- Statement 15: ProcessOrder - Insert order (OrderProcessing.cs)
-- EF6: _gadgetsOnlineEntities.Orders.Add(order) + SaveChanges()
INSERT INTO dbo.Orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
