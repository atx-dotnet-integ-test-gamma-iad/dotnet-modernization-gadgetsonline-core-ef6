-- ============================================================================
-- Converted SQL Statements (PostgreSQL equivalents)
-- Application: GadgetsOnline
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Target Schema: gadgetsonline_dbo (PostgreSQL)
-- DMS Retry Timestamp: 2026-03-24T01:41:49 through 2026-03-24T01:48:49
-- Note: All 18 DMS conversion attempts failed with "Metadata model
--       creation failed: No objects were found according to the specified
--       selection rules." Manual conversion applied with lowercase schema
--       object naming convention per transformation definition.
-- ============================================================================

-- ============================================================================
-- Statement 1: GetBestSellers (Services/Inventory.cs)
-- Conversion: TOP(5) -> LIMIT 5, dbo.Products -> gadgetsonline_dbo.products, lowercase columns
-- DMS Attempt: 2026-03-24T01:41:49 - FAILED (Metadata model creation failed)
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products p
INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid
LIMIT 5;

-- ============================================================================
-- Statement 2: GetAllCategories (Services/Inventory.cs)
-- Conversion: dbo.Categories -> gadgetsonline_dbo.categories, lowercase columns
-- DMS Attempt: 2026-03-24T01:42:12 - FAILED (Metadata model creation failed)
-- ============================================================================
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Services/Inventory.cs)
-- Conversion: dbo schema -> gadgetsonline_dbo schema, lowercase columns
-- DMS Attempt: 2026-03-24T01:42:36 - FAILED (Metadata model creation failed)
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products p
INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid
WHERE c.name = @category;

-- ============================================================================
-- Statement 4: GetProductById (Services/Inventory.cs)
-- Conversion: TOP 1 -> LIMIT 1, dbo.Products -> gadgetsonline_dbo.products, lowercase columns
-- DMS Attempt: 2026-03-24T01:43:02 - FAILED (Metadata model creation failed)
-- ============================================================================
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products
WHERE productid = @id
LIMIT 1;

-- ============================================================================
-- Statement 5: GetProductNameById (Services/Inventory.cs)
-- Conversion: TOP 1 -> LIMIT 1, dbo.Products -> gadgetsonline_dbo.products, lowercase columns
-- DMS Attempt: 2026-03-24T01:43:29 - FAILED (Metadata model creation failed)
-- ============================================================================
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- Statement 6: GetCartItems (Services/ShoppingCart.cs)
-- Conversion: dbo.Carts -> gadgetsonline_dbo.carts, lowercase columns
-- DMS Attempt: 2026-03-24T01:43:51 - FAILED (Metadata model creation failed)
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId;

-- ============================================================================
-- Statement 7: GetCount (Services/ShoppingCart.cs)
-- Conversion: ISNULL -> COALESCE, dbo.Carts -> gadgetsonline_dbo.carts, lowercase columns
-- DMS Attempt: 2026-03-24T01:44:14 - FAILED (Metadata model creation failed)
-- ============================================================================
SELECT COALESCE(SUM(count), 0) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 8: GetTotal (Services/ShoppingCart.cs)
-- Conversion: ISNULL -> COALESCE, dbo schema -> gadgetsonline_dbo schema, lowercase columns
-- DMS Attempt: 2026-03-24T01:44:37 - FAILED (Metadata model creation failed)
-- ============================================================================
SELECT COALESCE(SUM(c.count * p.price), 0)
FROM gadgetsonline_dbo.carts c
INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid
WHERE c.cartid = @cartId;

-- ============================================================================
-- Statement 9: AddToCart - SELECT single (Services/ShoppingCart.cs)
-- Conversion: TOP 1 -> LIMIT 1, dbo.Carts -> gadgetsonline_dbo.carts, lowercase columns
-- DMS Attempt: 2026-03-24T01:45:00 - FAILED (Metadata model creation failed)
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId AND productid = @id
LIMIT 1;

-- ============================================================================
-- Statement 10: AddToCart - INSERT (Services/ShoppingCart.cs)
-- Conversion: dbo.Carts -> gadgetsonline_dbo.carts, lowercase columns
-- DMS Attempt: 2026-03-24T01:45:24 - FAILED (Metadata model creation failed)
-- ============================================================================
INSERT INTO gadgetsonline_dbo.carts (productid, cartid, count, datecreated)
VALUES (@productId, @cartId, 1, @dateCreated);

-- ============================================================================
-- Statement 11: AddToCart - UPDATE (Services/ShoppingCart.cs)
-- Conversion: dbo.Carts -> gadgetsonline_dbo.carts, lowercase columns
-- DMS Attempt: 2026-03-24T01:45:46 - FAILED (Metadata model creation failed)
-- ============================================================================
UPDATE gadgetsonline_dbo.carts SET count = count + 1
WHERE cartid = @cartId AND productid = @id;

-- ============================================================================
-- Statement 12: RemoveFromCart - SELECT (Services/ShoppingCart.cs)
-- Conversion: TOP 1 -> LIMIT 1, dbo.Carts -> gadgetsonline_dbo.carts, lowercase columns
-- DMS Attempt: 2026-03-24T01:46:09 - FAILED (Metadata model creation failed)
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId AND productid = @productId
LIMIT 1;

-- ============================================================================
-- Statement 13: RemoveFromCart - UPDATE (Services/ShoppingCart.cs)
-- Conversion: dbo.Carts -> gadgetsonline_dbo.carts, lowercase columns
-- DMS Attempt: 2026-03-24T01:46:31 - FAILED (Metadata model creation failed)
-- ============================================================================
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = @recordId;

-- ============================================================================
-- Statement 14: RemoveFromCart - DELETE (Services/ShoppingCart.cs)
-- Conversion: dbo.Carts -> gadgetsonline_dbo.carts, lowercase columns
-- DMS Attempt: 2026-03-24T01:46:57 - FAILED (Metadata model creation failed)
-- ============================================================================
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @recordId;

-- ============================================================================
-- Statement 15: EmptyCart (Services/ShoppingCart.cs)
-- Conversion: dbo.Carts -> gadgetsonline_dbo.carts, lowercase columns
-- DMS Attempt: 2026-03-24T01:47:22 - FAILED (Metadata model creation failed)
-- ============================================================================
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 16: CreateOrder - INSERT OrderDetail (Services/ShoppingCart.cs)
-- Conversion: dbo.OrderDetails -> gadgetsonline_dbo.orderdetails, lowercase columns
-- DMS Attempt: 2026-03-24T01:47:46 - FAILED (Metadata model creation failed)
-- ============================================================================
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice)
VALUES (@orderId, @productId, @quantity, @unitPrice);

-- ============================================================================
-- Statement 17: CreateOrder - UPDATE Order Total (Services/ShoppingCart.cs)
-- Conversion: dbo.Orders -> gadgetsonline_dbo.orders, lowercase columns
-- DMS Attempt: 2026-03-24T01:48:09 - FAILED (Metadata model creation failed)
-- ============================================================================
UPDATE gadgetsonline_dbo.orders SET total = @total WHERE orderid = @orderId;

-- ============================================================================
-- Statement 18: ProcessOrder - INSERT Order (Services/OrderProcessing.cs)
-- Conversion: dbo.Orders -> gadgetsonline_dbo.orders, lowercase columns
-- DMS Attempt: 2026-03-24T01:48:34 - FAILED (Metadata model creation failed)
-- ============================================================================
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total)
VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
