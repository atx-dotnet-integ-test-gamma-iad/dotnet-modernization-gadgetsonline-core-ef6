-- ============================================================================
-- Converted SQL Statements for PostgreSQL - GadgetsOnline Application
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Attempt #1: 2026-03-23T15:32 - All 17 failed with Metadata model creation error
-- DMS Attempt #2: 2026-03-23T15:57 - All 17 failed with Metadata model creation error
-- DMS Attempt #3: 2026-03-23T16:33 - All 17 failed with Metadata model creation error
-- DMS Attempt #4: 2026-03-23T17:03 - All 17 failed with Metadata model creation error
-- DMS Attempt #5: 2026-03-23T17:42 - All 17 failed with Metadata model creation error
-- All 17 DMS conversions failed with: Metadata model creation failed - No objects found
-- according to the specified selection rules.
-- Manual conversion applied: lowercase schema objects, dbo -> gadgetsonline_dbo schema
-- Key conversions: TOP -> LIMIT, GETDATE() -> NOW(), ISNULL -> COALESCE
-- Total Physical Statements: 17 (Statement 11 split into 11a UPDATE and 11b DELETE)
-- ============================================================================

-- Statement 1: Inventory.GetBestSellers (Services/Inventory.cs)
-- Original: SELECT TOP (@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:42:24)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: Inventory.GetAllCategories (Services/Inventory.cs)
-- Original: SELECT CategoryId, Name, Description FROM dbo.Categories;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:42:49)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: Inventory.GetAllProductsInCategory (Services/Inventory.cs)
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:43:12)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: Inventory.GetProductById (Services/Inventory.cs)
-- Original: SELECT ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:43:36)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id;

-- Statement 5: Inventory.GetProductNameById (Services/Inventory.cs)
-- Original: SELECT Name FROM dbo.Products WHERE ProductId = @id;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:43:59)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id;

-- Statement 6: ShoppingCart.AddToCart - SELECT (Services/ShoppingCart.cs)
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:44:23)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId;

-- Statement 7: ShoppingCart.AddToCart - INSERT (Services/ShoppingCart.cs)
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, GETDATE());
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:44:49)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, NOW());

-- Statement 8: ShoppingCart.GetCount (Services/ShoppingCart.cs)
-- Original: SELECT ISNULL(SUM(Count), 0) FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:45:16)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT COALESCE(SUM(count), 0) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 9: ShoppingCart.GetCartItems (Services/ShoppingCart.cs)
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:45:39)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 10: ShoppingCart.GetTotal (Services/ShoppingCart.cs)
-- Original: SELECT ISNULL(SUM(c.Count * p.Price), 0) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:46:04)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT COALESCE(SUM(c.count * p.price), 0) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- Statement 11a: ShoppingCart.RemoveFromCart - UPDATE (Services/ShoppingCart.cs)
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:46:39)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE cartid = @cartId AND productid = @productId;

-- Statement 11b: ShoppingCart.RemoveFromCart - DELETE (Services/ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:47:06)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId;

-- Statement 12: ShoppingCart.EmptyCart (Services/ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:47:29)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 13: ShoppingCart.CreateOrder - INSERT OrderDetails (Services/ShoppingCart.cs)
-- Original: INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice);
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:47:53)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- Statement 14: OrderProcessing.ProcessOrder - INSERT Orders (Services/OrderProcessing.cs)
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:48:16)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- Statement 15: GadgetsOnlineInitializer.Seed - INSERT Categories (Models/GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@categoryId, @name, @description);
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:48:41)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@categoryId, @name, @description);

-- Statement 16: GadgetsOnlineInitializer.Seed - INSERT Products (Models/GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
-- DMS Status: FAILED - Metadata model creation failed (Attempt #5: 2026-03-23T17:49:06)
-- DMS Error: Metadata model creation failed: No objects were found according to the specified selection rules.
-- Conversion: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
