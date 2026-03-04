-- ============================================================================
-- Converted SQL Statements - PostgreSQL Equivalents
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed: The selected objects were not found.
-- Schema mapping: dbo.* -> gadgetsonline_dbo.* (lowercase)
-- All 36 statements were passed through DMS tool and all failed.
-- Manual conversion applied with lowercase schema object names per TD rules.
-- ============================================================================

-- ============================================================================
-- Source: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers(int count)
-- Original: SELECT TOP(@count) * FROM dbo.Products;
SELECT * FROM gadgetsonline_dbo.products LIMIT @count;

-- Statement 2: GetAllCategories()
-- Original: SELECT * FROM dbo.Categories;
SELECT * FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory(string category)
-- Original: SELECT p.* FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
SELECT p.* FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- Statement 4: GetProductById(int id)
-- Original: SELECT TOP 1 * FROM dbo.Products WHERE ProductId = @id;
SELECT * FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- Statement 5: GetProductNameById(int id)
-- Original: SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- ============================================================================
-- Source: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: GetCartItems()
-- Original: SELECT * FROM dbo.Carts WHERE CartId = @cartId;
SELECT * FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 7: AddToCart - Select existing cart item
-- Original: SELECT * FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id;
SELECT * FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @id;

-- Statement 8: AddToCart - Insert new cart item
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @id, 1, @now);
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @id, 1, @now);

-- Statement 9: AddToCart - Update existing cart item count
-- Original: UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @id;
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE cartid = @cartId AND productid = @id;

-- Statement 10: GetCount()
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 11: GetTotal()
-- Original: SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- Statement 12: RemoveFromCart - Select cart item
-- Original: SELECT * FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id;
SELECT * FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @id;

-- Statement 13: RemoveFromCart - Update count (decrement)
-- Original: UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @id;
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE cartid = @cartId AND productid = @id;

-- Statement 14: RemoveFromCart - Delete cart item
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id;
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @id;

-- Statement 15: EmptyCart()
-- Original: DELETE FROM dbo.Carts WHERE CartId = @cartId;
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- Statement 16: CreateOrder - Insert order detail
-- Original: INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- Statement 17: CreateOrder - Update order total
-- Original: UPDATE dbo.Orders SET Total = @total WHERE OrderId = @orderId;
UPDATE gadgetsonline_dbo.orders SET total = @total WHERE orderid = @orderId;

-- ============================================================================
-- Source: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 18: ProcessOrder - Insert order
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- Source: Models/GadgetsOnlineInitializer.cs (Seed Data)
-- ============================================================================

-- Statement 19: Seed - Insert category 1
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');

-- Statement 20: Seed - Insert category 2
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (2, 'Laptops', 'Latest Laptops in 2022');
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (2, 'Laptops', 'Latest Laptops in 2022');

-- Statement 21: Seed - Insert category 3
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (3, 'Desktops', 'Latest Desktops in 2022');
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (3, 'Desktops', 'Latest Desktops in 2022');

-- Statement 22: Seed - Insert category 4
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (4, 'Audio', 'Latest audio devices');
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (4, 'Audio', 'Latest audio devices');

-- Statement 23: Seed - Insert category 5
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');

-- Statement 24: Seed - Insert product 1
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');

-- Statement 25: Seed - Insert product 2
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (2, 1, 'Phone 13 Pro', 999.00, '/Content/Images/Mobile/2.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (2, 1, 'Phone 13 Pro', 999.00, '/Content/Images/Mobile/2.jpg');

-- Statement 26: Seed - Insert product 3
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (3, 1, 'Phone 13 Pro Max', 1199.00, '/Content/Images/Mobile/3.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (3, 1, 'Phone 13 Pro Max', 1199.00, '/Content/Images/Mobile/3.jpg');

-- Statement 27: Seed - Insert product 4
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (4, 2, 'XTS 13''', 899.00, '/Content/Images/Laptop/1.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (4, 2, 'XTS 13''', 899.00, '/Content/Images/Laptop/1.jpg');

-- Statement 28: Seed - Insert product 5
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (5, 2, 'PC 15.5''', 479.00, '/Content/Images/Laptop/2.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (5, 2, 'PC 15.5''', 479.00, '/Content/Images/Laptop/2.jpg');

-- Statement 29: Seed - Insert product 6
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (6, 2, 'Notebook 14', 169.00, '/Content/Images/Laptop/3.jpg');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (6, 2, 'Notebook 14', 169.00, '/Content/Images/Laptop/3.jpg');

-- Statement 30: Seed - Insert product 7
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (7, 3, 'The IdeaCenter', 539.00, '/Content/Images/placeholder.gif');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (7, 3, 'The IdeaCenter', 539.00, '/Content/Images/placeholder.gif');

-- Statement 31: Seed - Insert product 8
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (8, 3, 'COMP 22-df003w', 389.00, '/Content/Images/placeholder.gif');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (8, 3, 'COMP 22-df003w', 389.00, '/Content/Images/placeholder.gif');

-- Statement 32: Seed - Insert product 9
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (9, 4, 'Bluetooth Headphones Over Ear', 28.00, '/Content/Images/Headphones/1.png');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (9, 4, 'Bluetooth Headphones Over Ear', 28.00, '/Content/Images/Headphones/1.png');

-- Statement 33: Seed - Insert product 10
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (10, 4, 'ZX Series', 10.00, '/Content/Images/Headphones/2.png');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (10, 4, 'ZX Series', 10.00, '/Content/Images/Headphones/2.png');

-- Statement 34: Seed - Insert product 11
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (11, 5, 'Wireless charger', 9.99, '/Content/Images/placeholder.gif');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (11, 5, 'Wireless charger', 9.99, '/Content/Images/placeholder.gif');

-- Statement 35: Seed - Insert product 12
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (12, 5, 'Mousepad', 2.99, '/Content/Images/placeholder.gif');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (12, 5, 'Mousepad', 2.99, '/Content/Images/placeholder.gif');

-- Statement 36: Seed - Insert product 13
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (13, 5, 'Keyboard', 9.99, '/Content/Images/placeholder.gif');
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (13, 5, 'Keyboard', 9.99, '/Content/Images/placeholder.gif');

-- ============================================================================
-- TOTAL: 36 SQL Statements converted (all via manual conversion due to DMS failure)
-- ============================================================================
