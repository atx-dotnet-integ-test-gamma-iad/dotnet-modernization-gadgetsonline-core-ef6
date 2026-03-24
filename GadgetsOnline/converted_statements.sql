-- ============================================================================
-- Converted SQL Statements Catalog
-- Application: GadgetsOnline
-- Target Database: PostgreSQL
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (all statements)
-- DMS Error: Metadata model creation failed: No objects were found according
--            to the specified selection rules.
-- ============================================================================
-- NOTE: All 18 statements were passed through DMS MCP tool. All failed with
-- the same metadata model creation error. Manual conversion was applied using
-- lowercase schema naming conventions per transformation definition rules.
-- Schema mapping: dbo.* -> gadgetsonline_dbo.* (lowercase tables/columns)
-- SQL Server TOP(n) -> PostgreSQL LIMIT n
-- SQL Server DATETIME -> PostgreSQL TIMESTAMP
-- SQL Server IDENTITY -> PostgreSQL SERIAL
-- SQL Server NVARCHAR -> PostgreSQL VARCHAR
-- ============================================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- Original: SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products
LIMIT @count;

-- Statement 2: GetAllCategories (Inventory.cs)
-- Original: SELECT CategoryId, Name, Description FROM dbo.Categories;
SELECT categoryid, name, description
FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products p
INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid
WHERE c.name = @category;

-- Statement 4: GetProductById (Inventory.cs)
-- Original: SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products
WHERE productid = @id
LIMIT 1;

-- Statement 5: GetProductNameById (Inventory.cs)
-- Original: SELECT TOP(1) Name FROM dbo.Products WHERE ProductId = @id;
SELECT name
FROM gadgetsonline_dbo.products
WHERE productid = @id
LIMIT 1;

-- Statement 6: GetCartItems (ShoppingCart.cs)
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId;

-- Statement 7: GetTotal (ShoppingCart.cs)
-- Original: SELECT SUM(CAST(c.Count AS INT) * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;
SELECT SUM(CAST(c.count AS INT) * p.price)
FROM gadgetsonline_dbo.carts c
INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid
WHERE c.cartid = @cartId;

-- Statement 8: GetCount (ShoppingCart.cs)
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;
SELECT SUM(count)
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId;

-- Statement 9: AddToCart - Check existing (ShoppingCart.cs)
-- Original: SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId AND productid = @productId
LIMIT 1;

-- Statement 10: AddToCart - Insert new cart item (ShoppingCart.cs)
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated)
VALUES (@cartId, @productId, 1, @dateCreated);

-- Statement 11: AddToCart - Update count (ShoppingCart.cs)
-- Original: UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;
UPDATE gadgetsonline_dbo.carts
SET count = count + 1
WHERE cartid = @cartId AND productid = @productId;

-- Statement 12: RemoveFromCart - Get cart item (ShoppingCart.cs)
-- Original: SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId AND productid = @productId
LIMIT 1;

-- Statement 13: RemoveFromCart - Decrement count (ShoppingCart.cs)
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId;
UPDATE gadgetsonline_dbo.carts
SET count = count - 1
WHERE cartid = @cartId AND productid = @productId;

-- Statement 14: RemoveFromCart - Delete item (ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE RecordId = @recordId;
DELETE FROM gadgetsonline_dbo.carts
WHERE recordid = @recordId;

-- Statement 15: EmptyCart (ShoppingCart.cs)
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId;
DELETE FROM gadgetsonline_dbo.carts
WHERE cartid = @cartId;

-- Statement 16: ProcessOrder - Insert Order (OrderProcessing.cs)
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (...);
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total)
VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- Statement 17: CreateOrder - Insert OrderDetail (ShoppingCart.cs)
-- Original: INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity)
VALUES (@productId, @orderId, @unitPrice, @quantity);

-- Statement 18: CreateOrder - Update Order Total (ShoppingCart.cs)
-- Original: UPDATE dbo.Orders SET Total = @total WHERE OrderId = @orderId;
UPDATE gadgetsonline_dbo.orders
SET total = @total
WHERE orderid = @orderId;
