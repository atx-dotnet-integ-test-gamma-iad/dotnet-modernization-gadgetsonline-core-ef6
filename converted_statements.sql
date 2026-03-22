-- ============================================================
-- Converted PostgreSQL Statements for GadgetsOnline Application
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- All 12 DMS conversions failed with: Metadata model creation failed - No objects found
-- DMS Migration Project: arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII
-- Database: GadgetsOnline, Schema: dbo
-- Manual conversion applied lowercase schema object names per transformation rules
-- Conversion Date: 2026-03-22 (re-attempted DMS conversion)
-- Total Statements: 12
-- ============================================================

-- Statement 1: Inventory.cs - GetBestSellers
-- Original MS SQL: SELECT TOP(@count) * FROM Products
-- DMS Status: FAILED (2026-03-22T23:10:19) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: TOP(@count) -> LIMIT @count, Products -> products
SELECT * FROM products LIMIT @count;

-- Statement 2: Inventory.cs - GetAllCategories
-- Original MS SQL: SELECT * FROM Categories
-- DMS Status: FAILED (2026-03-22T23:11:18) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: Categories -> categories
SELECT * FROM categories;

-- Statement 3: Inventory.cs - GetAllProductsInCategory
-- Original MS SQL: SELECT * FROM Products WHERE CategoryId IN (SELECT CategoryId FROM Categories WHERE Name = @category)
-- DMS Status: FAILED (2026-03-22T23:11:41) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: Products -> products, CategoryId -> categoryid, Categories -> categories, Name -> name
SELECT * FROM products WHERE categoryid IN (SELECT categoryid FROM categories WHERE name = @category);

-- Statement 4: Inventory.cs - GetProductById
-- Original MS SQL: SELECT TOP 1 * FROM Products WHERE ProductId = @id
-- DMS Status: FAILED (2026-03-22T23:12:05) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: TOP 1 -> LIMIT 1, Products -> products, ProductId -> productid
SELECT * FROM products WHERE productid = @id LIMIT 1;

-- Statement 5: Inventory.cs - GetProductNameById
-- Original MS SQL: SELECT TOP 1 Name FROM Products WHERE ProductId = @id
-- DMS Status: FAILED (2026-03-22T23:12:32) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: TOP 1 -> LIMIT 1, Name -> name, Products -> products, ProductId -> productid
SELECT name FROM products WHERE productid = @id LIMIT 1;

-- Statement 6: ShoppingCart.cs - GetCartItems
-- Original MS SQL: SELECT * FROM Carts WHERE CartId = @cartId
-- DMS Status: FAILED (2026-03-22T23:12:54) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: Carts -> carts, CartId -> cartid
SELECT * FROM carts WHERE cartid = @cartId;

-- Statement 7: ShoppingCart.cs - GetCount
-- Original MS SQL: SELECT SUM(Count) FROM Carts WHERE CartId = @cartId
-- DMS Status: FAILED (2026-03-22T23:13:17) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: Count -> count, Carts -> carts, CartId -> cartid
SELECT SUM(count) FROM carts WHERE cartid = @cartId;

-- Statement 8: ShoppingCart.cs - GetTotal
-- Original MS SQL: SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId
-- DMS Status: FAILED (2026-03-22T23:13:44) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: All table/column names lowercased
SELECT SUM(c.count * p.price) FROM carts c INNER JOIN products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- Statement 9: ShoppingCart.cs - AddToCart (lookup)
-- Original MS SQL: SELECT * FROM Carts WHERE CartId = @cartId AND ProductId = @id
-- DMS Status: FAILED (2026-03-22T23:14:07) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: Carts -> carts, CartId -> cartid, ProductId -> productid
SELECT * FROM carts WHERE cartid = @cartId AND productid = @id;

-- Statement 10: ShoppingCart.cs - RemoveFromCart (SELECT + UPDATE/DELETE)
-- Original MS SQL: SELECT * FROM Carts WHERE CartId = @cartId AND ProductId = @id; UPDATE Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @id; DELETE FROM Carts WHERE CartId = @cartId AND ProductId = @id AND Count = 0
-- DMS Status: FAILED (2026-03-22T23:14:30) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: All table/column names lowercased
SELECT * FROM carts WHERE cartid = @cartId AND productid = @id;
UPDATE carts SET count = count - 1 WHERE cartid = @cartId AND productid = @id;
DELETE FROM carts WHERE cartid = @cartId AND productid = @id AND count = 0;

-- Statement 11: ShoppingCart.cs - EmptyCart
-- Original MS SQL: DELETE FROM Carts WHERE CartId = @cartId
-- DMS Status: FAILED (2026-03-22T23:14:53) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: Carts -> carts, CartId -> cartid
DELETE FROM carts WHERE cartid = @cartId;

-- Statement 12: ShoppingCart.cs - CreateOrder (INSERT OrderDetails + UPDATE Order total)
-- Original MS SQL: INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) SELECT @orderId, ProductId, Count, p.Price FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId; UPDATE Orders SET Total = (SELECT SUM(Quantity * UnitPrice) FROM OrderDetails WHERE OrderId = @orderId) WHERE OrderId = @orderId
-- DMS Status: FAILED (2026-03-22T23:15:17) - Metadata model creation failed
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- Changes: All table/column names lowercased
INSERT INTO orderdetails (orderid, productid, quantity, unitprice) SELECT @orderId, productid, count, p.price FROM carts c INNER JOIN products p ON c.productid = p.productid WHERE c.cartid = @cartId;
UPDATE orders SET total = (SELECT SUM(quantity * unitprice) FROM orderdetails WHERE orderid = @orderId) WHERE orderid = @orderId;
