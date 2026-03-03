-- ============================================================================
-- Converted SQL Statements for PostgreSQL - GadgetsOnline Application
-- Target Database: PostgreSQL (gadgetsonline_dbo schema, lowercase naming)
--
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- All 18 statements failed DMS conversion with error:
--   "Metadata model creation failed: {'error': \"Metadata model creation failed:
--    {'default_error_details': {'message': 'The selected objects were not found.'}}\"}"
-- DMS tool was invoked for all 18 statements on 2026-03-03T21:57-22:04 UTC (second attempt).
-- Previous DMS attempt: 2026-03-03T21:24-21:30 UTC (first attempt, same error).
-- Manual conversion applied lowercase schema object names per transformation rules.
-- ============================================================================

-- ============================================================================
-- Source File: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers(count) - Retrieves top N products
-- Original: SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:24:25 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T21:57:30 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: GetAllCategories() - Retrieves all categories
-- Original: SELECT CategoryId, Name, Description FROM dbo.Categories;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:24:41 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T21:57:53 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory(category) - Products filtered by category name
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:24:56 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T21:58:17 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById(id) - Single product by ID
-- Original: SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:25:23 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T21:58:40 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById(id) - Product name by ID
-- Original: SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:25:39 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T21:59:03 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- Source File: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: GetCartItems() - Cart items for current cart
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:25:55 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T21:59:28 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 7: GetCount() - Sum of item counts in cart
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:26:21 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T21:59:51 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 8: GetTotal() - Total price of cart items
-- Original: SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:26:37 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:00:14 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- Statement 9: AddToCart(id) - SELECT existing cart item
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:26:52 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:00:38 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId;

-- Statement 10: AddToCart(id) - INSERT new cart item
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:27:23 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:01:01 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, @dateCreated);

-- Statement 11: AddToCart(id) - UPDATE existing cart item count
-- Original: UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:27:38 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:01:25 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE cartid = @cartId AND productid = @productId;

-- Statement 12: RemoveFromCart(id) - SELECT cart item
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:27:54 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:01:48 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId;

-- Statement 13: RemoveFromCart(id) - UPDATE decrement count
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:28:20 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:02:11 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE cartid = @cartId AND productid = @productId;

-- Statement 14: RemoveFromCart(id) - DELETE cart item when count reaches 0
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:28:36 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:02:34 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId;

-- Statement 15: EmptyCart() - DELETE all cart items for current cart
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:28:51 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:03:01 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 16: CreateOrder(order) - INSERT order details for each cart item
-- Original: INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:29:19 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:03:25 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- Statement 17: CreateOrder(order) - UPDATE order total
-- Original: UPDATE dbo.Orders SET Total = @total WHERE OrderId = @orderId;
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:29:35 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:03:48 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
UPDATE gadgetsonline_dbo.orders SET total = @total WHERE orderid = @orderId;

-- ============================================================================
-- Source File: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 18: ProcessOrder(order) - INSERT new order
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
-- DMS Status: FAILED - Metadata model creation failed: The selected objects were not found.
-- DMS Attempt 1 Timestamp: 2026-03-03T21:29:50 UTC
-- DMS Attempt 2 Timestamp: 2026-03-03T22:04:12 UTC
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
