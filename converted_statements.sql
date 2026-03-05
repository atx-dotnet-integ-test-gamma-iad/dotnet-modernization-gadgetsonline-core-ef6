-- =============================================================================
-- Converted PostgreSQL Statements for GadgetsOnline Application
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - The selected objects were not found.
-- All 16 statements were passed through DMS MCP tool; all 16 failed.
-- Manual conversion applied with lowercase schema object names per transformation definition.
-- Date: 2026-03-05
-- =============================================================================

-- Statement 1: GetBestSellers (Inventory.cs)
-- Original: SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products
-- Conversion: TOP -> LIMIT, lowercase schema objects
SELECT productid, categoryid, name, price, productarturl FROM products LIMIT @count;

-- Statement 2: GetAllCategories (Inventory.cs)
-- Original: SELECT CategoryId, Name, Description FROM Categories
-- Conversion: lowercase schema objects
SELECT categoryid, name, description FROM categories;

-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Original: SELECT * FROM Products p INNER JOIN Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category
-- Conversion: lowercase schema objects
SELECT * FROM products p INNER JOIN categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById (Inventory.cs)
-- Original: SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products WHERE ProductId = @id
-- Conversion: TOP 1 -> LIMIT 1, lowercase schema objects
SELECT productid, categoryid, name, price, productarturl FROM products WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById (Inventory.cs)
-- Original: SELECT TOP 1 Name FROM Products WHERE ProductId = @id
-- Conversion: TOP 1 -> LIMIT 1, lowercase schema objects
SELECT name FROM products WHERE productid = @id LIMIT 1;

-- Statement 6: GetCartItems (ShoppingCart.cs)
-- Original: SELECT * FROM Carts WHERE CartId = @cartId
-- Conversion: lowercase schema objects
SELECT * FROM carts WHERE cartid = @cartId;

-- Statement 7: AddToCart - Select existing (ShoppingCart.cs)
-- Original: SELECT TOP 1 * FROM Carts WHERE CartId = @cartId AND ProductId = @id
-- Conversion: TOP 1 -> LIMIT 1, lowercase schema objects
SELECT * FROM carts WHERE cartid = @cartId AND productid = @id LIMIT 1;

-- Statement 8: AddToCart - Insert new (ShoppingCart.cs)
-- Original: INSERT INTO Carts (ProductId, CartId, Count, DateCreated) VALUES (@productId, @cartId, 1, @now)
-- Conversion: lowercase schema objects
INSERT INTO carts (productid, cartid, count, datecreated) VALUES (@productId, @cartId, 1, @now);

-- Statement 9: GetCount (ShoppingCart.cs)
-- Original: SELECT SUM(Count) FROM Carts WHERE CartId = @cartId
-- Conversion: lowercase schema objects
SELECT SUM(count) FROM carts WHERE cartid = @cartId;

-- Statement 10: GetTotal (ShoppingCart.cs)
-- Original: SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId
-- Conversion: lowercase schema objects
SELECT SUM(c.count * p.price) FROM carts c INNER JOIN products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- Statement 11: RemoveFromCart - Select (ShoppingCart.cs)
-- Original: SELECT * FROM Carts WHERE CartId = @cartId AND ProductId = @id
-- Conversion: lowercase schema objects
SELECT * FROM carts WHERE cartid = @cartId AND productid = @id;

-- Statement 12: RemoveFromCart - Update count (ShoppingCart.cs)
-- Original: UPDATE Carts SET Count = @newCount WHERE RecordId = @recordId AND CartId = @cartId AND ProductId = @productId
-- Conversion: lowercase schema objects
UPDATE carts SET count = @newCount WHERE recordid = @recordId AND cartid = @cartId AND productid = @productId;

-- Statement 13: RemoveFromCart - Delete (ShoppingCart.cs)
-- Original: DELETE FROM Carts WHERE RecordId = @recordId AND CartId = @cartId AND ProductId = @productId
-- Conversion: lowercase schema objects
DELETE FROM carts WHERE recordid = @recordId AND cartid = @cartId AND productid = @productId;

-- Statement 14: EmptyCart (ShoppingCart.cs)
-- Original: DELETE FROM Carts WHERE CartId = @cartId
-- Conversion: lowercase schema objects
DELETE FROM carts WHERE cartid = @cartId;

-- Statement 15: Insert Order (OrderProcessing.cs)
-- Original: INSERT INTO Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (...)
-- Conversion: lowercase schema objects
INSERT INTO orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- Statement 16: Insert OrderDetail (ShoppingCart.cs)
-- Original: INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (...)
-- Conversion: lowercase schema objects
INSERT INTO orderdetails (orderid, productid, quantity, unitprice) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);
