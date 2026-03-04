-- ============================================================================
-- Extracted SQL Statements from GadgetsOnline EF6 LINQ Queries
-- Source: MS SQL Server (original database)
-- Each statement is documented with its source file and method
-- ============================================================================

-- ============================================================================
-- Source: Services/Inventory.cs
-- ============================================================================

-- Method: GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Statement 1:
SELECT TOP(@count) * FROM dbo.Products;

-- Method: GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Statement 2:
SELECT * FROM dbo.Categories;

-- Method: GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Statement 3:
SELECT p.* FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Method: GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Statement 4:
SELECT TOP 1 * FROM dbo.Products WHERE ProductId = @id;

-- Method: GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Statement 5:
SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;

-- ============================================================================
-- Source: Services/ShoppingCart.cs
-- ============================================================================

-- Method: GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Statement 6:
SELECT * FROM dbo.Carts WHERE CartId = @cartId;

-- Method: AddToCart(int id) - Select existing cart item
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Statement 7:
SELECT * FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id;

-- Method: AddToCart(int id) - Insert new cart item
-- Statement 8:
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @id, 1, @now);

-- Method: AddToCart(int id) - Update existing cart item count
-- Statement 9:
UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @id;

-- Method: GetCount()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Statement 10:
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;

-- Method: GetTotal()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Statement 11:
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- Method: RemoveFromCart(int id) - Select cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
-- Statement 12:
SELECT * FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id;

-- Method: RemoveFromCart(int id) - Update count (decrement)
-- Statement 13:
UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @id;

-- Method: RemoveFromCart(int id) - Delete cart item
-- Statement 14:
DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @id;

-- Method: EmptyCart()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId) + Remove
-- Statement 15:
DELETE FROM dbo.Carts WHERE CartId = @cartId;

-- Method: CreateOrder(Order order) - Insert order detail
-- Statement 16:
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- Method: CreateOrder(Order order) - Update order total
-- Statement 17:
UPDATE dbo.Orders SET Total = @total WHERE OrderId = @orderId;

-- ============================================================================
-- Source: Services/OrderProcessing.cs
-- ============================================================================

-- Method: ProcessOrder(Order order, HttpContext httpContext) - Insert order
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- Statement 18:
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- ============================================================================
-- Source: Models/GadgetsOnlineInitializer.cs (Seed Data)
-- ============================================================================

-- Method: Seed() - Insert categories
-- Statement 19:
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones');

-- Statement 20:
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (2, 'Laptops', 'Latest Laptops in 2022');

-- Statement 21:
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (3, 'Desktops', 'Latest Desktops in 2022');

-- Statement 22:
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (4, 'Audio', 'Latest audio devices');

-- Statement 23:
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');

-- Method: Seed() - Insert products
-- Statement 24:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg');

-- Statement 25:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (2, 1, 'Phone 13 Pro', 999.00, '/Content/Images/Mobile/2.jpg');

-- Statement 26:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (3, 1, 'Phone 13 Pro Max', 1199.00, '/Content/Images/Mobile/3.jpg');

-- Statement 27:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (4, 2, 'XTS 13''', 899.00, '/Content/Images/Laptop/1.jpg');

-- Statement 28:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (5, 2, 'PC 15.5''', 479.00, '/Content/Images/Laptop/2.jpg');

-- Statement 29:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (6, 2, 'Notebook 14', 169.00, '/Content/Images/Laptop/3.jpg');

-- Statement 30:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (7, 3, 'The IdeaCenter', 539.00, '/Content/Images/placeholder.gif');

-- Statement 31:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (8, 3, 'COMP 22-df003w', 389.00, '/Content/Images/placeholder.gif');

-- Statement 32:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (9, 4, 'Bluetooth Headphones Over Ear', 28.00, '/Content/Images/Headphones/1.png');

-- Statement 33:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (10, 4, 'ZX Series', 10.00, '/Content/Images/Headphones/2.png');

-- Statement 34:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (11, 5, 'Wireless charger', 9.99, '/Content/Images/placeholder.gif');

-- Statement 35:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (12, 5, 'Mousepad', 2.99, '/Content/Images/placeholder.gif');

-- Statement 36:
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (13, 5, 'Keyboard', 9.99, '/Content/Images/placeholder.gif');

-- ============================================================================
-- TOTAL: 36 SQL Statements extracted
-- ============================================================================
