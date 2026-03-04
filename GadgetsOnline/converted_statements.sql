-- Converted SQL Statements for GadgetsOnline - PostgreSQL
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (all statements)
-- DMS Error: Metadata model creation failed: The selected objects were not found.
-- Date: 2026-03-04

-- ============================================================================
-- Statement 1: GetBestSellers (Services/Inventory.cs)
-- Original: SELECT TOP(@count) productid, categoryid, name, price, productarturl FROM products
-- ============================================================================
SELECT productid, categoryid, name, price, productarturl FROM products LIMIT @count;

-- ============================================================================
-- Statement 2: GetAllCategories (Services/Inventory.cs)
-- Original: SELECT categoryid, name, description FROM categories
-- ============================================================================
SELECT categoryid, name, description FROM categories;

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Services/Inventory.cs)
-- Original: SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM products p INNER JOIN categories c ON p.categoryid = c.categoryid WHERE c.name = @category
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM products p INNER JOIN categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- ============================================================================
-- Statement 4: GetProductById (Services/Inventory.cs)
-- Original: SELECT TOP(1) productid, categoryid, name, price, productarturl FROM products WHERE productid = @id
-- ============================================================================
SELECT productid, categoryid, name, price, productarturl FROM products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- Statement 5: GetProductNameById (Services/Inventory.cs)
-- Original: SELECT TOP(1) name FROM products WHERE productid = @id
-- ============================================================================
SELECT name FROM products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- Statement 6: GetCartItems (Services/ShoppingCart.cs)
-- Original: SELECT recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartid
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartid;

-- ============================================================================
-- Statement 7: GetCount (Services/ShoppingCart.cs)
-- Original: SELECT SUM(count) FROM carts WHERE cartid = @cartid
-- ============================================================================
SELECT SUM(count) FROM carts WHERE cartid = @cartid;

-- ============================================================================
-- Statement 8: GetTotal (Services/ShoppingCart.cs)
-- Original: SELECT SUM(c.count * p.price) FROM carts c INNER JOIN products p ON c.productid = p.productid WHERE c.cartid = @cartid
-- ============================================================================
SELECT SUM(c.count * p.price) FROM carts c INNER JOIN products p ON c.productid = p.productid WHERE c.cartid = @cartid;

-- ============================================================================
-- Statement 9: AddToCart - SELECT existing item (Services/ShoppingCart.cs)
-- Original: SELECT TOP(1) recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartid AND productid = @productid
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartid AND productid = @productid LIMIT 1;

-- ============================================================================
-- Statement 10: AddToCart - INSERT new item (Services/ShoppingCart.cs)
-- Original: INSERT INTO carts (cartid, productid, count, datecreated) VALUES (@cartid, @productid, 1, @datecreated)
-- ============================================================================
INSERT INTO carts (cartid, productid, count, datecreated) VALUES (@cartid, @productid, 1, @datecreated);

-- ============================================================================
-- Statement 11: AddToCart - UPDATE existing item count (Services/ShoppingCart.cs)
-- Original: UPDATE carts SET count = count + 1 WHERE cartid = @cartid AND productid = @productid
-- ============================================================================
UPDATE carts SET count = count + 1 WHERE cartid = @cartid AND productid = @productid;

-- ============================================================================
-- Statement 12: RemoveFromCart - SELECT item (Services/ShoppingCart.cs)
-- Original: SELECT TOP(1) recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartid AND productid = @productid
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartid AND productid = @productid LIMIT 1;

-- ============================================================================
-- Statement 13: RemoveFromCart - UPDATE decrement count (Services/ShoppingCart.cs)
-- Original: UPDATE carts SET count = count - 1 WHERE cartid = @cartid AND productid = @productid
-- ============================================================================
UPDATE carts SET count = count - 1 WHERE cartid = @cartid AND productid = @productid;

-- ============================================================================
-- Statement 14: RemoveFromCart - DELETE item (Services/ShoppingCart.cs)
-- Original: DELETE FROM carts WHERE cartid = @cartid AND productid = @productid
-- ============================================================================
DELETE FROM carts WHERE cartid = @cartid AND productid = @productid;

-- ============================================================================
-- Statement 15: EmptyCart (Services/ShoppingCart.cs)
-- Original: DELETE FROM carts WHERE cartid = @cartid
-- ============================================================================
DELETE FROM carts WHERE cartid = @cartid;

-- ============================================================================
-- Statement 16: CreateOrder - INSERT order details (Services/ShoppingCart.cs)
-- Original: INSERT INTO orderdetails (productid, orderid, unitprice, quantity) VALUES (@productid, @orderid, @unitprice, @quantity)
-- ============================================================================
INSERT INTO orderdetails (productid, orderid, unitprice, quantity) VALUES (@productid, @orderid, @unitprice, @quantity);

-- ============================================================================
-- Statement 17: CreateOrder - UPDATE order total (Services/ShoppingCart.cs)
-- Original: UPDATE orders SET total = @total WHERE orderid = @orderid
-- ============================================================================
UPDATE orders SET total = @total WHERE orderid = @orderid;

-- ============================================================================
-- Statement 18: ProcessOrder - INSERT order (Services/OrderProcessing.cs)
-- Original: INSERT INTO orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderdate, @username, @firstname, @lastname, @address, @city, @state, @postalcode, @country, @phone, @email, @total)
-- ============================================================================
INSERT INTO orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderdate, @username, @firstname, @lastname, @address, @city, @state, @postalcode, @country, @phone, @email, @total);

-- ============================================================================
-- Statement 19: Seed - INSERT categories (Models/GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO categories (categoryid, name, description) VALUES (@categoryid, @name, @description)
-- ============================================================================
INSERT INTO categories (categoryid, name, description) VALUES (@categoryid, @name, @description);

-- ============================================================================
-- Statement 20: Seed - INSERT products (Models/GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO products (productid, categoryid, name, price, productarturl) VALUES (@productid, @categoryid, @name, @price, @productarturl)
-- ============================================================================
INSERT INTO products (productid, categoryid, name, price, productarturl) VALUES (@productid, @categoryid, @name, @price, @productarturl);
