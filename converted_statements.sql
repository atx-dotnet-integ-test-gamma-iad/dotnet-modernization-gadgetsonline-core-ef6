-- ============================================================================
-- CONVERTED SQL STATEMENTS CATALOG (PostgreSQL)
-- Source: GadgetsOnline .NET Application (EF6 LINQ-to-Entities derived)
-- Date: 2026-03-23
-- Total Statements: 19
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (all 19)
-- DMS Attempt: All 19 statements sent to DMS on 2026-03-23T09:11:20 - T09:17:01
-- DMS Error: "Metadata model creation failed: No objects were found according
--   to the specified selection rules. Please review your selection rules and
--   try again."
-- Schema Mapping: dbo -> gadgetsonline_dbo
-- Naming Convention: All identifiers converted to lowercase
-- SQL Syntax: TOP N -> LIMIT N, DATETIME -> TIMESTAMP
-- ============================================================================

-- ============================================================================
-- SOURCE FILE: Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:11:20 - FAILED
-- Changes: [dbo].[Products] -> gadgetsonline_dbo.products, TOP(@p__linq__0) -> LIMIT @p__linq__0, all columns lowercase
SELECT "Extent1".productid AS productid, "Extent1".categoryid AS categoryid, "Extent1".name AS name, "Extent1".price AS price, "Extent1".productarturl AS productarturl FROM gadgetsonline_dbo.products AS "Extent1" LIMIT @p__linq__0;

-- Statement 2: GetAllCategories (Inventory.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:11:35 - FAILED
-- Changes: [dbo].[Categories] -> gadgetsonline_dbo.categories, all columns lowercase
SELECT "Extent1".categoryid AS categoryid, "Extent1".name AS name, "Extent1".description AS description FROM gadgetsonline_dbo.categories AS "Extent1";

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:11:51 - FAILED
-- Changes: [dbo].[Products] -> gadgetsonline_dbo.products, [dbo].[Categories] -> gadgetsonline_dbo.categories, all columns lowercase
SELECT "Extent1".productid AS productid, "Extent1".categoryid AS categoryid, "Extent1".name AS name, "Extent1".price AS price, "Extent1".productarturl AS productarturl FROM gadgetsonline_dbo.products AS "Extent1" INNER JOIN gadgetsonline_dbo.categories AS "Extent2" ON "Extent1".categoryid = "Extent2".categoryid WHERE "Extent2".name = @p__linq__0;

-- Statement 4: GetProductById (Inventory.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:12:06 - FAILED
-- Changes: [dbo].[Products] -> gadgetsonline_dbo.products, TOP 1 -> LIMIT 1, all columns lowercase
SELECT "Extent1".productid AS productid, "Extent1".categoryid AS categoryid, "Extent1".name AS name, "Extent1".price AS price, "Extent1".productarturl AS productarturl FROM gadgetsonline_dbo.products AS "Extent1" WHERE "Extent1".productid = @p__linq__0 LIMIT 1;

-- Statement 5: GetProductNameById (Inventory.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:12:21 - FAILED
-- Changes: [dbo].[Products] -> gadgetsonline_dbo.products, TOP 1 -> LIMIT 1, all columns lowercase
SELECT "Extent1".name FROM gadgetsonline_dbo.products AS "Extent1" WHERE "Extent1".productid = @p__linq__0 LIMIT 1;

-- ============================================================================
-- SOURCE FILE: ShoppingCart.cs
-- ============================================================================

-- Statement 6: CreateOrder - Insert OrderDetail (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:12:55 - FAILED
-- Changes: [dbo].[OrderDetails] -> gadgetsonline_dbo.orderdetails, all columns lowercase
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);

-- Statement 7: CreateOrder - Update Order Total (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:13:10 - FAILED
-- Changes: [dbo].[Orders] -> gadgetsonline_dbo.orders, all columns lowercase
UPDATE gadgetsonline_dbo.orders SET total = @Total WHERE orderid = @OrderId;

-- Statement 8: EmptyCart - Select carts to delete (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:13:26 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all columns lowercase
SELECT "Extent1".recordid AS recordid, "Extent1".cartid AS cartid, "Extent1".productid AS productid, "Extent1".count AS count, "Extent1".datecreated AS datecreated FROM gadgetsonline_dbo.carts AS "Extent1" WHERE "Extent1".cartid = @p__linq__0;

-- Statement 9: EmptyCart - Delete cart items (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:13:41 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all columns lowercase
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId;

-- Statement 10: AddToCart - Find existing cart item (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:13:56 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, TOP 1 -> LIMIT 1, all columns lowercase
SELECT "Extent1".recordid AS recordid, "Extent1".cartid AS cartid, "Extent1".productid AS productid, "Extent1".count AS count, "Extent1".datecreated AS datecreated FROM gadgetsonline_dbo.carts AS "Extent1" WHERE "Extent1".cartid = @p__linq__0 AND "Extent1".productid = @p__linq__1 LIMIT 1;

-- Statement 11: AddToCart - Insert new cart item (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:14:27 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all columns lowercase
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- Statement 12: AddToCart - Update count (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:14:43 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all columns lowercase
UPDATE gadgetsonline_dbo.carts SET count = @Count WHERE recordid = @RecordId;

-- Statement 13: GetCount (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:14:58 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all columns lowercase
SELECT SUM("Extent1".count) FROM gadgetsonline_dbo.carts AS "Extent1" WHERE "Extent1".cartid = @p__linq__0;

-- Statement 14: RemoveFromCart - Find cart item (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:15:13 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all columns lowercase
SELECT "Extent1".recordid AS recordid, "Extent1".cartid AS cartid, "Extent1".productid AS productid, "Extent1".count AS count, "Extent1".datecreated AS datecreated FROM gadgetsonline_dbo.carts AS "Extent1" WHERE "Extent1".cartid = @p__linq__0 AND "Extent1".productid = @p__linq__1;

-- Statement 15: RemoveFromCart - Decrement count (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:15:29 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all columns lowercase
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = @RecordId;

-- Statement 16: RemoveFromCart - Delete cart item (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:16:00 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all columns lowercase
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @CartId AND productid = @ProductId;

-- Statement 17: GetCartItems (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:16:15 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, all columns lowercase
SELECT "Extent1".recordid AS recordid, "Extent1".cartid AS cartid, "Extent1".productid AS productid, "Extent1".count AS count, "Extent1".datecreated AS datecreated FROM gadgetsonline_dbo.carts AS "Extent1" WHERE "Extent1".cartid = @p__linq__0;

-- Statement 18: GetTotal (ShoppingCart.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:16:31 - FAILED
-- Changes: [dbo].[Carts] -> gadgetsonline_dbo.carts, [dbo].[Products] -> gadgetsonline_dbo.products, all columns lowercase
SELECT SUM("Extent1".count * "Extent2".price) FROM gadgetsonline_dbo.carts AS "Extent1" INNER JOIN gadgetsonline_dbo.products AS "Extent2" ON "Extent1".productid = "Extent2".productid WHERE "Extent1".cartid = @p__linq__0;

-- ============================================================================
-- SOURCE FILE: OrderProcessing.cs
-- ============================================================================

-- Statement 19: ProcessOrder - Insert order (OrderProcessing.cs)
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt: 2026-03-23T09:16:46 - FAILED
-- Changes: [dbo].[Orders] -> gadgetsonline_dbo.orders, all columns lowercase
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);
