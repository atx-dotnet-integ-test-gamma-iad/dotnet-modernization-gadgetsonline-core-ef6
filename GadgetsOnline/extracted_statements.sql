-- Extracted SQL Statements from GadgetsOnline EF6 LINQ Operations
-- Source: MS SQL Server
-- Date: 2026-03-04

-- ============================================================================
-- Statement 1: GetBestSellers (Services/Inventory.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- ============================================================================
SELECT TOP(@count) productid, categoryid, name, price, productarturl FROM products;

-- ============================================================================
-- Statement 2: GetAllCategories (Services/Inventory.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- ============================================================================
SELECT categoryid, name, description FROM categories;

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Services/Inventory.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM products p INNER JOIN categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- ============================================================================
-- Statement 4: GetProductById (Services/Inventory.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- ============================================================================
SELECT TOP(1) productid, categoryid, name, price, productarturl FROM products WHERE productid = @id;

-- ============================================================================
-- Statement 5: GetProductNameById (Services/Inventory.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- ============================================================================
SELECT TOP(1) name FROM products WHERE productid = @id;

-- ============================================================================
-- Statement 6: GetCartItems (Services/ShoppingCart.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartid;

-- ============================================================================
-- Statement 7: GetCount (Services/ShoppingCart.cs)
-- EF6 LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- ============================================================================
SELECT SUM(count) FROM carts WHERE cartid = @cartid;

-- ============================================================================
-- Statement 8: GetTotal (Services/ShoppingCart.cs)
-- EF6 LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- ============================================================================
SELECT SUM(c.count * p.price) FROM carts c INNER JOIN products p ON c.productid = p.productid WHERE c.cartid = @cartid;

-- ============================================================================
-- Statement 9: AddToCart - SELECT existing item (Services/ShoppingCart.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- ============================================================================
SELECT TOP(1) recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartid AND productid = @productid;

-- ============================================================================
-- Statement 10: AddToCart - INSERT new item (Services/ShoppingCart.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem) + SaveChanges()
-- ============================================================================
INSERT INTO carts (cartid, productid, count, datecreated) VALUES (@cartid, @productid, 1, @datecreated);

-- ============================================================================
-- Statement 11: AddToCart - UPDATE existing item count (Services/ShoppingCart.cs)
-- EF6 LINQ: cartItem.Count++ + SaveChanges()
-- ============================================================================
UPDATE carts SET count = count + 1 WHERE cartid = @cartid AND productid = @productid;

-- ============================================================================
-- Statement 12: RemoveFromCart - SELECT item (Services/ShoppingCart.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- ============================================================================
SELECT TOP(1) recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartid AND productid = @productid;

-- ============================================================================
-- Statement 13: RemoveFromCart - UPDATE decrement count (Services/ShoppingCart.cs)
-- EF6 LINQ: cartItem.Count-- + SaveChanges()
-- ============================================================================
UPDATE carts SET count = count - 1 WHERE cartid = @cartid AND productid = @productid;

-- ============================================================================
-- Statement 14: RemoveFromCart - DELETE item (Services/ShoppingCart.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges()
-- ============================================================================
DELETE FROM carts WHERE cartid = @cartid AND productid = @productid;

-- ============================================================================
-- Statement 15: EmptyCart (Services/ShoppingCart.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) for each + SaveChanges()
-- ============================================================================
DELETE FROM carts WHERE cartid = @cartid;

-- ============================================================================
-- Statement 16: CreateOrder - INSERT order details (Services/ShoppingCart.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) for each + SaveChanges()
-- ============================================================================
INSERT INTO orderdetails (productid, orderid, unitprice, quantity) VALUES (@productid, @orderid, @unitprice, @quantity);

-- ============================================================================
-- Statement 17: CreateOrder - UPDATE order total (Services/ShoppingCart.cs)
-- EF6 LINQ: order.Total = orderTotal + SaveChanges()
-- ============================================================================
UPDATE orders SET total = @total WHERE orderid = @orderid;

-- ============================================================================
-- Statement 18: ProcessOrder - INSERT order (Services/OrderProcessing.cs)
-- EF6 LINQ: _gadgetsOnlineEntities.Orders.Add(order) + SaveChanges()
-- ============================================================================
INSERT INTO orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderdate, @username, @firstname, @lastname, @address, @city, @state, @postalcode, @country, @phone, @email, @total);

-- ============================================================================
-- Statement 19: Seed - INSERT categories (Models/GadgetsOnlineInitializer.cs)
-- EF6 LINQ: context.Categories.Add(c) for each + SaveChanges()
-- ============================================================================
INSERT INTO categories (categoryid, name, description) VALUES (@categoryid, @name, @description);

-- ============================================================================
-- Statement 20: Seed - INSERT products (Models/GadgetsOnlineInitializer.cs)
-- EF6 LINQ: context.Products.Add(p) for each + SaveChanges()
-- ============================================================================
INSERT INTO products (productid, categoryid, name, price, productarturl) VALUES (@productid, @categoryid, @name, @price, @productarturl);
