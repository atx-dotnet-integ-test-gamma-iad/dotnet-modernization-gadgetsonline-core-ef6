-- ============================================================================
-- Converted PostgreSQL Statements from GadgetsOnline MS SQL Server
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- All 19 DMS calls failed with: Metadata model creation failed: The selected objects were not found.
-- Manual conversion applied: schema dbo -> gadgetsonline_dbo, all names lowercase
-- Conversion Date: 2026-03-04
-- Total Statements: 19
-- ============================================================================

-- ============================================================================
-- Statement 1: GetBestSellers (TOP -> LIMIT conversion)
-- Original: SELECT TOP(@count) * FROM dbo.Products;
-- ============================================================================
SELECT * FROM gadgetsonline_dbo.products LIMIT @count;

-- ============================================================================
-- Statement 2: GetAllCategories
-- Original: SELECT * FROM dbo.Categories;
-- ============================================================================
SELECT * FROM gadgetsonline_dbo.categories;

-- ============================================================================
-- Statement 3: GetAllProductsInCategory
-- Original: SELECT * FROM dbo.Products WHERE CategoryId IN (SELECT CategoryId FROM dbo.Categories WHERE Name = @category);
-- ============================================================================
SELECT * FROM gadgetsonline_dbo.products WHERE categoryid IN (SELECT categoryid FROM gadgetsonline_dbo.categories WHERE name = @category);

-- ============================================================================
-- Statement 4: GetProductById
-- Original: SELECT * FROM dbo.Products WHERE ProductId = @id;
-- ============================================================================
SELECT * FROM gadgetsonline_dbo.products WHERE productid = @id;

-- ============================================================================
-- Statement 5: GetProductNameById
-- Original: SELECT Name FROM dbo.Products WHERE ProductId = @id;
-- ============================================================================
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id;

-- ============================================================================
-- Statement 6: AddToCart lookup
-- Original: SELECT * FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- ============================================================================
SELECT * FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId;

-- ============================================================================
-- Statement 7: AddToCart insert
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);
-- ============================================================================
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, @dateCreated);

-- ============================================================================
-- Statement 8: AddToCart update
-- Original: UPDATE dbo.Carts SET Count = Count + 1 WHERE RecordId = @recordId;
-- ============================================================================
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE recordid = @recordId;

-- ============================================================================
-- Statement 9: GetCount
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;
-- ============================================================================
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 10: RemoveFromCart decrement
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @recordId;
-- ============================================================================
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = @recordId;

-- ============================================================================
-- Statement 11: RemoveFromCart delete
-- Original: DELETE FROM dbo.Carts WHERE RecordId = @recordId;
-- ============================================================================
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @recordId;

-- ============================================================================
-- Statement 12: GetCartItems
-- Original: SELECT * FROM dbo.Carts WHERE CartId = @cartId;
-- ============================================================================
SELECT * FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 13: GetTotal
-- Original: SELECT SUM(c.Count * p.Price) FROM dbo.Carts c JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;
-- ============================================================================
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- ============================================================================
-- Statement 14: EmptyCart
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId;
-- ============================================================================
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- ============================================================================
-- Statement 15: CreateOrder insert order detail
-- Original: INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);
-- ============================================================================
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- ============================================================================
-- Statement 16: CreateOrder update order total
-- Original: UPDATE dbo.Orders SET Total = @total WHERE OrderId = @orderId;
-- ============================================================================
UPDATE gadgetsonline_dbo.orders SET total = @total WHERE orderid = @orderId;

-- ============================================================================
-- Statement 17: ProcessOrder insert order
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
-- ============================================================================
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- Statement 18: Seed Categories
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');
-- ============================================================================
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');

-- ============================================================================
-- Statement 19: Seed Products
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');
-- ============================================================================
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');
