-- ============================================================================
-- Converted SQL Statements for GadgetsOnline - PostgreSQL Target
-- Target: PostgreSQL (gadgetsonline_dbo schema)
-- Conversion Date: 2026-03-21
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (all 19 statements)
-- DMS Failure Reason: Metadata model creation failed - No objects found for selection rules
-- All 19 statements were submitted to DMS MCP tool and all 19 failed
-- Manual conversion applied with lowercase schema mapping rules
-- Total Statements: 19
-- ============================================================================

-- ============================================================================
-- Source: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- Original: SELECT TOP(5) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:52:19
-- Conversion: Manual - TOP(n) -> LIMIT n, dbo -> gadgetsonline_dbo, PascalCase -> lowercase
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT 5;

-- Statement 2: GetAllCategories (Inventory.cs)
-- Original: SELECT CategoryId, Name, Description FROM dbo.Categories;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:52:54
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:53:17
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = :category;

-- Statement 4: GetProductById (Inventory.cs)
-- Original: SELECT ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:53:41
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = :id;

-- Statement 5: GetProductNameById (Inventory.cs)
-- Original: SELECT Name FROM dbo.Products WHERE ProductId = @id;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:54:04
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
SELECT name FROM gadgetsonline_dbo.products WHERE productid = :id;

-- ============================================================================
-- Source: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: GetCartItems (ShoppingCart.cs)
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:54:29
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = :cartId;

-- Statement 7: GetCount (ShoppingCart.cs)
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:54:51
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = :cartId;

-- Statement 8: GetTotal (ShoppingCart.cs)
-- Original: SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:55:13
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = :cartId;

-- Statement 9: AddToCart - SELECT (ShoppingCart.cs)
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:55:35
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = :cartId AND productid = :productId;

-- Statement 10: AddToCart - INSERT (ShoppingCart.cs)
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:55:58
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (:cartId, :productId, 1, :dateCreated);

-- Statement 11: AddToCart - UPDATE (ShoppingCart.cs)
-- Original: UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:56:20
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE cartid = :cartId AND productid = :productId;

-- Statement 12: RemoveFromCart - SELECT (ShoppingCart.cs)
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:55:35 (same SQL as Statement 9)
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = :cartId AND productid = :productId;

-- Statement 13: RemoveFromCart - DELETE (ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE RecordId = @recordId;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:56:48
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = :recordId;

-- Statement 14: RemoveFromCart - UPDATE (ShoppingCart.cs)
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @recordId;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:57:16
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = :recordId;

-- Statement 15: EmptyCart (ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:57:37
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = :cartId;

-- Statement 16: CreateOrder - INSERT OrderDetail (ShoppingCart.cs)
-- Original: INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:58:01
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (:productId, :orderId, :unitPrice, :quantity);

-- ============================================================================
-- Source: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 17: ProcessOrder - INSERT Order (OrderProcessing.cs)
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:58:23
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (:orderDate, :username, :firstName, :lastName, :address, :city, :state, :postalCode, :country, :phone, :email, :total);

-- ============================================================================
-- Source: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 18: Seed - INSERT Category (GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@categoryId, @name, @description);
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:58:45
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (:categoryId, :name, :description);

-- Statement 19: Seed - INSERT Product (GadgetsOnlineInitializer.cs)
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
-- DMS Status: FAILED (Metadata model creation failed)
-- DMS Timestamp: 2026-03-21T12:59:09
-- Conversion: Manual - dbo -> gadgetsonline_dbo, PascalCase -> lowercase, @param -> :param
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (:productId, :categoryId, :name, :price, :productArtUrl);
