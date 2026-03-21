-- ============================================================================
-- CONVERTED SQL STATEMENTS CATALOG (PostgreSQL)
-- Source: GadgetsOnline EF6 LINQ Operations - Converted from MS SQL Server
-- Conversion method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Schema mapping: dbo -> gadgetsonline_dbo
-- All table/column names lowercased for PostgreSQL compatibility
-- ============================================================================
-- DMS tool (dms-mcp___statement_conversion_tool) was attempted for all 21
-- statements. All 21 failed with: "Metadata model creation failed: No objects
-- were found according to the specified selection rules."
-- Manual conversion applied per transformation rules.
-- ============================================================================

-- ==========================================================================
-- SOURCE FILE: Services/Inventory.cs
-- ==========================================================================

-- Statement 1: GetBestSellers - SELECT with LIMIT (converted from TOP)
-- Original: SELECT TOP(@count) productid, categoryid, name, price, productarturl FROM dbo.Products;
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products
LIMIT @count;

-- Statement 2: GetAllCategories - SELECT all categories
-- Original: SELECT categoryid, name, description FROM dbo.Categories;
SELECT categoryid, name, description
FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory - SELECT products by category name (JOIN)
-- Original: SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.categoryid = c.categoryid WHERE c.name = @category;
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products p
INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid
WHERE c.name = @category;

-- Statement 4: GetProductById - SELECT single product by ID (converted from TOP(1))
-- Original: SELECT TOP(1) productid, categoryid, name, price, productarturl FROM dbo.Products WHERE productid = @id;
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products
WHERE productid = @id
LIMIT 1;

-- Statement 5: GetProductNameById - SELECT product name by ID (converted from TOP(1))
-- Original: SELECT TOP(1) name FROM dbo.Products WHERE productid = @id;
SELECT name
FROM gadgetsonline_dbo.products
WHERE productid = @id
LIMIT 1;

-- ==========================================================================
-- SOURCE FILE: Services/ShoppingCart.cs
-- ==========================================================================

-- Statement 6: GetCartItems - SELECT cart items by cart ID
-- Original: SELECT recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId;

-- Statement 7: GetCount - SELECT SUM of item counts in cart
-- Original: SELECT SUM(count) FROM dbo.Carts WHERE cartid = @cartId;
SELECT SUM(count)
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId;

-- Statement 8: GetTotal - SELECT SUM of cart total (count * price with JOIN)
-- Original: SELECT SUM(c.count * p.price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.productid = p.productid WHERE c.cartid = @cartId;
SELECT SUM(c.count * p.price)
FROM gadgetsonline_dbo.carts c
INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid
WHERE c.cartid = @cartId;

-- Statement 9: AddToCart (SELECT) - Find existing cart item (converted from TOP(1))
-- Original: SELECT TOP(1) recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartId AND productid = @productId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId AND productid = @productId
LIMIT 1;

-- Statement 10: AddToCart (INSERT) - Insert new cart item
-- Original: INSERT INTO dbo.Carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, @count, @dateCreated);
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated)
VALUES (@cartId, @productId, @count, @dateCreated);

-- Statement 11: AddToCart (UPDATE) - Update cart item count
-- Original: UPDATE dbo.Carts SET count = @count WHERE recordid = @recordId;
UPDATE gadgetsonline_dbo.carts
SET count = @count
WHERE recordid = @recordId;

-- Statement 12: RemoveFromCart (SELECT) - Find cart item to remove (converted from TOP(1))
-- Original: SELECT TOP(1) recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartId AND productid = @productId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId AND productid = @productId
LIMIT 1;

-- Statement 13: RemoveFromCart (UPDATE) - Decrement cart item count
-- Original: UPDATE dbo.Carts SET count = @count WHERE recordid = @recordId;
UPDATE gadgetsonline_dbo.carts
SET count = @count
WHERE recordid = @recordId;

-- Statement 14: RemoveFromCart (DELETE) - Remove cart item entirely
-- Original: DELETE FROM dbo.Carts WHERE recordid = @recordId;
DELETE FROM gadgetsonline_dbo.carts
WHERE recordid = @recordId;

-- Statement 15: EmptyCart (SELECT) - Get all cart items for deletion
-- Original: SELECT recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId;

-- Statement 16: EmptyCart (DELETE) - Delete each cart item
-- Original: DELETE FROM dbo.Carts WHERE recordid = @recordId;
DELETE FROM gadgetsonline_dbo.carts
WHERE recordid = @recordId;

-- Statement 17: CreateOrder (INSERT OrderDetail) - Insert order detail
-- Original: INSERT INTO dbo.OrderDetails (productid, orderid, unitprice, quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity)
VALUES (@productId, @orderId, @unitPrice, @quantity);

-- Statement 18: CreateOrder (UPDATE Order) - Update order total
-- Original: UPDATE dbo.Orders SET total = @total WHERE orderid = @orderId;
UPDATE gadgetsonline_dbo.orders
SET total = @total
WHERE orderid = @orderId;

-- ==========================================================================
-- SOURCE FILE: Services/OrderProcessing.cs
-- ==========================================================================

-- Statement 19: ProcessOrder (INSERT) - Insert new order
-- Original: INSERT INTO dbo.Orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total)
VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ==========================================================================
-- SOURCE FILE: Models/GadgetsOnlineInitializer.cs
-- ==========================================================================

-- Statement 20: Seed (INSERT Category) - Insert seed categories
-- Original: INSERT INTO dbo.Categories (categoryid, name, description) VALUES (@categoryId, @name, @description);
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description)
VALUES (@categoryId, @name, @description);

-- Statement 21: Seed (INSERT Product) - Insert seed products
-- Original: INSERT INTO dbo.Products (productid, categoryid, name, price, productarturl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl)
VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
