-- ============================================================================
-- Converted SQL Statements for PostgreSQL - GadgetsOnline Application
-- ============================================================================
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects found per selection rules
-- DMS Migration Project ARN: arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII
-- Total Statements: 15
-- 
-- Key conversions applied:
--   - Table/column names converted to lowercase for PostgreSQL
--   - TOP N converted to LIMIT N (PostgreSQL syntax)
--   - dbo schema prefix removed (PostgreSQL uses gadgetsonline_dbo schema in EF mappings)
--   - All identifiers lowercased per PostgreSQL convention
--
-- NOTE: All 15 statements were submitted to DMS MCP tool first.
-- All 15 DMS conversions failed with metadata model creation error.
-- Manual conversions applied per transformation definition rules
-- (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA).
-- ============================================================================

-- ============================================================================
-- Source File: Services/Inventory.cs
-- ============================================================================

-- Statement 1 (a): GetBestSellers (Inventory.cs)
-- Original: SELECT TOP(@count) * FROM dbo.Products
-- Conversion: TOP(@n) -> LIMIT @n, table/column names lowercased, dbo removed
SELECT * FROM products LIMIT @count;

-- Statement 2 (b): GetAllCategories (Inventory.cs)
-- Original: SELECT * FROM dbo.Categories
-- Conversion: Table name lowercased, dbo removed
SELECT * FROM categories;

-- Statement 3 (c): GetAllProductsInCategory (Inventory.cs)
-- Original: SELECT p.* FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category
-- Conversion: Table/column names lowercased, dbo removed
SELECT p.* FROM products p INNER JOIN categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4 (d): GetProductById (Inventory.cs)
-- Original: SELECT TOP 1 * FROM dbo.Products WHERE ProductId = @id
-- Conversion: TOP 1 -> LIMIT 1, table/column names lowercased, dbo removed
SELECT * FROM products WHERE productid = @id LIMIT 1;

-- Statement 5 (e): GetProductNameById (Inventory.cs)
-- Original: SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id
-- Conversion: TOP 1 -> LIMIT 1, table/column names lowercased, dbo removed
SELECT name FROM products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- Source File: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6 (f): AddToCart - SELECT part (ShoppingCart.cs)
-- Original: SELECT * FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId
-- Conversion: Table/column names lowercased, dbo removed
SELECT * FROM carts WHERE cartid = @cartId AND productid = @productId;

-- Statement 7 (g): AddToCart - INSERT part (ShoppingCart.cs)
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, @count, @dateCreated)
-- Conversion: Table/column names lowercased, dbo removed
INSERT INTO carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, @count, @dateCreated);

-- Statement 8 (h): GetCartItems (ShoppingCart.cs)
-- Original: SELECT * FROM dbo.Carts WHERE CartId = @cartId
-- Conversion: Table/column names lowercased, dbo removed
SELECT * FROM carts WHERE cartid = @cartId;

-- Statement 9 (i): GetCount (ShoppingCart.cs)
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId
-- Conversion: Table/column names lowercased, dbo removed
SELECT SUM(count) FROM carts WHERE cartid = @cartId;

-- Statement 10 (j): RemoveFromCart - DELETE (ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId
-- Conversion: Table/column names lowercased, dbo removed
DELETE FROM carts WHERE cartid = @cartId AND productid = @productId;

-- Statement 11 (k): RemoveFromCart - UPDATE count (ShoppingCart.cs)
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId
-- Conversion: Table/column names lowercased, dbo removed
UPDATE carts SET count = count - 1 WHERE cartid = @cartId AND productid = @productId;

-- Statement 12 (l): GetTotal (ShoppingCart.cs)
-- Original: SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId
-- Conversion: Table/column names lowercased, dbo removed
SELECT SUM(c.count * p.price) FROM carts c INNER JOIN products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- Statement 13 (m): ProcessOrder - INSERT order (OrderProcessing.cs)
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total)
-- Conversion: Table/column names lowercased, dbo removed
INSERT INTO orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- Statement 14 (n): CreateOrder - INSERT order details (ShoppingCart.cs)
-- Original: INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice)
-- Conversion: Table/column names lowercased, dbo removed
INSERT INTO orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- Statement 15 (o): EmptyCart (ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId
-- Conversion: Table/column names lowercased, dbo removed
DELETE FROM carts WHERE cartid = @cartId;
