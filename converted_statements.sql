-- ============================================================
-- Converted SQL Statements - GadgetsOnline Migration
-- Target: PostgreSQL (gadgetsonline_dbo schema)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects found
-- All 15 statements attempted through DMS MCP tool (all failed)
-- Manual conversion applied with lowercase schema mapping rules:
--   dbo → gadgetsonline_dbo
--   Table names → lowercase
--   TOP(n)/TOP n → LIMIT n (moved to end of query)
--   Column names already lowercase (no change needed)
-- ============================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- Original: SELECT TOP(@count) productid, categoryid, name, price, productarturl FROM dbo.Products
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: GetAllCategories (Inventory.cs)
-- Original: SELECT * FROM dbo.Categories
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT * FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Original: SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.categoryid = c.categoryid WHERE c.name = @category
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById (Inventory.cs)
-- Original: SELECT TOP 1 productid, categoryid, name, price, productarturl FROM dbo.Products WHERE productid = @id
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById (Inventory.cs)
-- Original: SELECT TOP 1 name FROM dbo.Products WHERE productid = @id
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 6: GetCartItems (ShoppingCart.cs)
-- Original: SELECT recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartId
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 7: AddToCart - Find existing (ShoppingCart.cs)
-- Original: SELECT TOP 1 recordid, cartid, productid, count, datecreated FROM dbo.Carts WHERE cartid = @cartId AND productid = @productId
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId LIMIT 1;

-- Statement 8: AddToCart - Insert new (ShoppingCart.cs)
-- Original: INSERT INTO dbo.Carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, @count, @dateCreated)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, @count, @dateCreated);

-- Statement 9: AddToCart/RemoveFromCart - Update count (ShoppingCart.cs)
-- Original: UPDATE dbo.Carts SET count = @count WHERE recordid = @recordId
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
UPDATE gadgetsonline_dbo.carts SET count = @count WHERE recordid = @recordId;

-- Statement 10: GetCount (ShoppingCart.cs)
-- Original: SELECT SUM(count) FROM dbo.Carts WHERE cartid = @cartId
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 11: GetTotal (ShoppingCart.cs)
-- Original: SELECT SUM(c.count * p.price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.productid = p.productid WHERE c.cartid = @cartId
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- Statement 12: EmptyCart (ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE cartid = @cartId
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 13: RemoveFromCart - Delete single (ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE recordid = @recordId
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @recordId;

-- Statement 14: CreateOrder - Insert order details (ShoppingCart.cs)
-- Original: INSERT INTO dbo.OrderDetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- Statement 15: ProcessOrder - Insert order (OrderProcessing.cs)
-- Original: INSERT INTO dbo.Orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total)
-- DMS Status: FAILED - Metadata model creation failed
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
