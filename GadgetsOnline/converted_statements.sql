-- =====================================================
-- Converted SQL Statements for PostgreSQL
-- Source: MS SQL Server (dbo schema, PascalCase names)
-- Target: PostgreSQL (gadgetsonline_dbo schema, lowercase names)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Error: Metadata model creation failed - No objects found
-- =====================================================

-- =====================================================
-- Source File: Services/Inventory.cs
-- =====================================================

-- Statement 1: GetBestSellers(int count)
-- Original: SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products
LIMIT @count;

-- Statement 2: GetAllCategories()
-- Original: SELECT CategoryId, Name, Description FROM dbo.Categories;
SELECT categoryid, name, description
FROM gadgetsonline_dbo.categories;

-- Statement 3: GetAllProductsInCategory(string category)
-- Original: SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl
FROM gadgetsonline_dbo.products p
INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid
WHERE c.name = @category;

-- Statement 4: GetProductById(int id)
-- Original: SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
SELECT productid, categoryid, name, price, productarturl
FROM gadgetsonline_dbo.products
WHERE productid = @id
LIMIT 1;

-- Statement 5: GetProductNameById(int id)
-- Original: SELECT TOP(1) Name FROM dbo.Products WHERE ProductId = @id;
SELECT name
FROM gadgetsonline_dbo.products
WHERE productid = @id
LIMIT 1;

-- =====================================================
-- Source File: Services/ShoppingCart.cs
-- =====================================================

-- Statement 6: GetCartItems()
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 7: AddToCart - SELECT existing cart item
-- Original: SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId AND productid = @ProductId
LIMIT 1;

-- Statement 8: AddToCart - INSERT new cart item
-- Original: INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated)
VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- Statement 9: AddToCart - UPDATE cart item count
-- Original: UPDATE dbo.Carts SET Count = @Count WHERE RecordId = @RecordId;
UPDATE gadgetsonline_dbo.carts
SET count = @Count
WHERE recordid = @RecordId;

-- Statement 10: GetCount()
-- Original: SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @ShoppingCartId;
SELECT SUM(count)
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 11: GetTotal()
-- Original: SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @ShoppingCartId;
SELECT SUM(c.count * p.price)
FROM gadgetsonline_dbo.carts c
INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid
WHERE c.cartid = @ShoppingCartId;

-- Statement 12: RemoveFromCart - SELECT cart item
-- Original: SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId AND productid = @ProductId
LIMIT 1;

-- Statement 13: RemoveFromCart - UPDATE (decrement count)
-- Original: UPDATE dbo.Carts SET Count = @Count WHERE RecordId = @RecordId;
UPDATE gadgetsonline_dbo.carts
SET count = @Count
WHERE recordid = @RecordId;

-- Statement 14: RemoveFromCart - DELETE (when count reaches 0)
-- Original: DELETE FROM dbo.Carts WHERE RecordId = @RecordId;
DELETE FROM gadgetsonline_dbo.carts
WHERE recordid = @RecordId;

-- Statement 15: EmptyCart - SELECT cart items
-- Original: SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;
SELECT recordid, cartid, productid, count, datecreated
FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 16: EmptyCart - DELETE all cart items
-- Original: DELETE FROM dbo.Carts WHERE CartId = @ShoppingCartId;
DELETE FROM gadgetsonline_dbo.carts
WHERE cartid = @ShoppingCartId;

-- Statement 17: CreateOrder - INSERT order detail
-- Original: INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity)
VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- Statement 18: CreateOrder - UPDATE order total
-- Original: UPDATE dbo.Orders SET Total = @Total WHERE OrderId = @OrderId;
UPDATE gadgetsonline_dbo.orders
SET total = @Total
WHERE orderid = @OrderId;

-- =====================================================
-- Source File: Services/OrderProcessing.cs
-- =====================================================

-- Statement 19: ProcessOrder - INSERT order
-- Original: INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (...);
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total)
VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- =====================================================
-- Source File: Models/GadgetsOnlineInitializer.cs
-- =====================================================

-- Statement 20: Seed Categories
-- Original: INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (...);
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description)
VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones'),
       (2, 'Laptops', 'Latest Laptops in 2022'),
       (3, 'Desktops', 'Latest Desktops in 2022'),
       (4, 'Audio', 'Latest audio devices'),
       (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');

-- Statement 21: Seed Products
-- Original: INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (...);
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl)
VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg'),
       (2, 1, 'Phone 13 Pro', 999.00, '/Content/Images/Mobile/2.jpg'),
       (3, 1, 'Phone 13 Pro Max', 1199.00, '/Content/Images/Mobile/3.jpg'),
       (4, 2, 'XTS 13''', 899.00, '/Content/Images/Laptop/1.jpg'),
       (5, 2, 'PC 15.5''', 479.00, '/Content/Images/Laptop/2.jpg'),
       (6, 2, 'Notebook 14', 169.00, '/Content/Images/Laptop/3.jpg'),
       (7, 3, 'The IdeaCenter', 539.00, '/Content/Images/placeholder.gif'),
       (8, 3, 'COMP 22-df003w', 389.00, '/Content/Images/placeholder.gif'),
       (9, 4, 'Bluetooth Headphones Over Ear', 28.00, '/Content/Images/Headphones/1.png'),
       (10, 4, 'ZX Series ', 10.00, '/Content/Images/Headphones/2.png'),
       (11, 5, 'Wireless charger', 9.99, '/Content/Images/placeholder.gif'),
       (12, 5, 'Mousepad', 2.99, '/Content/Images/placeholder.gif'),
       (13, 5, 'Keyboard', 9.99, '/Content/Images/placeholder.gif');
