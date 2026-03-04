-- ============================================================================
-- Converted SQL Statements for PostgreSQL - GadgetsOnline Application
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: The selected objects were not found.
-- DMS Retry Timestamp: 2026-03-04T05:38:59 through 2026-03-04T05:46:36
-- All 19 statements attempted through DMS individually - all failed with same error
-- Manual conversion applied: dbo → gadgetsonline_dbo, PascalCase → lowercase, TOP(N) → LIMIT N
-- Target Database: PostgreSQL (schema: gadgetsonline_dbo)
-- ============================================================================

-- ============================================================================
-- Source: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers(count) - Select top N products
-- Original: SELECT TOP(5) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT 5;

-- Statement 2: GetAllCategories() - Select all categories
-- Original: SELECT CategoryId, Name, Description FROM dbo.Categories;
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory(category) - Select products by category name
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById(id) - Select product by ID
-- Original: SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById(id) - Select product name by ID
-- Original: SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- Source: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: CreateOrder - Insert order details for each cart item
-- Original: INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- Statement 7: EmptyCart - Delete all cart items for a cart
-- Original: DELETE FROM dbo.Carts WHERE CartId = @CartId;
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @CartId;

-- Statement 8: AddToCart - Check if item exists in cart
-- Original: SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId;
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @CartId AND productid = @ProductId LIMIT 1;

-- Statement 9: AddToCart - Insert new cart item
-- Original: INSERT INTO dbo.Carts (ProductId, CartId, Count, DateCreated) VALUES (@ProductId, @CartId, 1, @DateCreated);
INSERT INTO gadgetsonline_dbo.carts (productid, cartid, count, datecreated) VALUES (@ProductId, @CartId, 1, @DateCreated);

-- Statement 10: AddToCart - Update cart item count
-- Original: UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @CartId AND ProductId = @ProductId;
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE cartid = @CartId AND productid = @ProductId;

-- Statement 11: GetCount - Sum of items in cart
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @CartId;
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @CartId;

-- Statement 12: RemoveFromCart - Select cart item
-- Original: SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId;
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @CartId AND productid = @ProductId LIMIT 1;

-- Statement 13: RemoveFromCart - Update count (decrement)
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @CartId AND ProductId = @ProductId;
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE cartid = @CartId AND productid = @ProductId;

-- Statement 14: RemoveFromCart - Delete cart item
-- Original: DELETE FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId;
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @CartId AND productid = @ProductId;

-- Statement 15: GetCartItems - Select all items in cart
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @CartId;
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @CartId;

-- Statement 16: GetTotal - Calculate cart total
-- Original: SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @CartId;
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @CartId;

-- ============================================================================
-- Source: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 17: ProcessOrder - Insert new order
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- ============================================================================
-- Source: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 18: Seed - Insert categories
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@CategoryId, @Name, @Description);
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@CategoryId, @Name, @Description);

-- Statement 19: Seed - Insert products
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
