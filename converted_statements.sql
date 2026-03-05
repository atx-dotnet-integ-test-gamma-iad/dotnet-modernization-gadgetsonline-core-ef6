-- ============================================================================
-- Converted SQL Statements Catalog (PostgreSQL)
-- Source: GadgetsOnline .NET Application
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: The selected objects were not found.
-- All 15 statements were passed through DMS MCP tool and ALL FAILED.
-- All statements converted manually with lowercase schema object names per TD rules.
-- ============================================================================

-- ============================================================================
-- Statement 1: GetBestSellers (Inventory.cs)
-- Original: SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: TOP(@count) -> LIMIT @count, lowercase identifiers
-- ============================================================================
SELECT productid, categoryid, name, price, productarturl FROM products LIMIT @count;

-- ============================================================================
-- Statement 2: GetAllCategories (Inventory.cs)
-- Original: SELECT CategoryId, Name, Description FROM Categories;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
SELECT categoryid, name, description FROM categories;

-- ============================================================================
-- Statement 3: GetAllProductsInCategory (Inventory.cs)
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM Products p INNER JOIN Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM products p INNER JOIN categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- ============================================================================
-- Statement 4: GetProductById (Inventory.cs)
-- Original: SELECT ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products WHERE ProductId = @id;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
SELECT productid, categoryid, name, price, productarturl FROM products WHERE productid = @id;

-- ============================================================================
-- Statement 5: GetProductNameById (Inventory.cs)
-- Original: SELECT Name FROM Products WHERE ProductId = @id;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
SELECT name FROM products WHERE productid = @id;

-- ============================================================================
-- Statement 6: GetCartItems (ShoppingCart.cs)
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @cartId;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
SELECT recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 7: GetCount (ShoppingCart.cs)
-- Original: SELECT SUM(Count) FROM Carts WHERE CartId = @cartId;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
SELECT SUM(count) FROM carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 8: GetTotal (ShoppingCart.cs)
-- Original: SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
SELECT SUM(c.count * p.price) FROM carts c INNER JOIN products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- ============================================================================
-- Statement 9: AddToCart - INSERT (ShoppingCart.cs)
-- Original: INSERT INTO Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, GETDATE());
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers, GETDATE() -> NOW()
-- ============================================================================
INSERT INTO carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, NOW());

-- ============================================================================
-- Statement 10: AddToCart - UPDATE (ShoppingCart.cs)
-- Original: UPDATE Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
UPDATE carts SET count = count + 1 WHERE cartid = @cartId AND productid = @productId;

-- ============================================================================
-- Statement 11: RemoveFromCart - UPDATE (ShoppingCart.cs)
-- Original: UPDATE Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
UPDATE carts SET count = count - 1 WHERE cartid = @cartId AND productid = @productId;

-- ============================================================================
-- Statement 12: RemoveFromCart - DELETE (ShoppingCart.cs)
-- Original: DELETE FROM Carts WHERE CartId = @cartId AND ProductId = @productId;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
DELETE FROM carts WHERE cartid = @cartId AND productid = @productId;

-- ============================================================================
-- Statement 13: EmptyCart (ShoppingCart.cs)
-- Original: DELETE FROM Carts WHERE CartId = @cartId;
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
DELETE FROM carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 14: ProcessOrder - INSERT Order (OrderProcessing.cs)
-- Original: INSERT INTO Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
INSERT INTO orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- Statement 15: CreateOrder - INSERT OrderDetail (ShoppingCart.cs)
-- Original: INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice);
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
-- Changes: lowercase identifiers
-- ============================================================================
INSERT INTO orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);
