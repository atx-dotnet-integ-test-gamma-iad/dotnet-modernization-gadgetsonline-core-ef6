-- =====================================================
-- Extracted SQL Statements from GadgetsOnline Application
-- Source: Entity Framework 6 LINQ Queries
-- Target: MS SQL Server (dbo schema, PascalCase names)
-- =====================================================

-- =====================================================
-- Source File: Services/Inventory.cs
-- =====================================================

-- Statement 1: GetBestSellers(int count)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl
FROM dbo.Products;

-- Statement 2: GetAllCategories()
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT CategoryId, Name, Description
FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory(string category)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl
FROM dbo.Products p
INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId
WHERE c.Name = @category;

-- Statement 4: GetProductById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl
FROM dbo.Products
WHERE ProductId = @id;

-- Statement 5: GetProductNameById(int id)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP(1) Name
FROM dbo.Products
WHERE ProductId = @id;

-- =====================================================
-- Source File: Services/ShoppingCart.cs
-- =====================================================

-- Statement 6: GetCartItems()
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT RecordId, CartId, ProductId, Count, DateCreated
FROM dbo.Carts
WHERE CartId = @ShoppingCartId;

-- Statement 7: AddToCart - SELECT existing cart item
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated
FROM dbo.Carts
WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;

-- Statement 8: AddToCart - INSERT new cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Add(new Cart { ... })
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated)
VALUES (@CartId, @ProductId, @Count, @DateCreated);

-- Statement 9: AddToCart - UPDATE cart item count
-- LINQ: cartItem.Count++ followed by SaveChanges()
UPDATE dbo.Carts
SET Count = @Count
WHERE RecordId = @RecordId;

-- Statement 10: GetCount()
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT SUM(Count)
FROM dbo.Carts
WHERE CartId = @ShoppingCartId;

-- Statement 11: GetTotal()
-- LINQ: (from cartItems in ... where ... select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT SUM(c.Count * p.Price)
FROM dbo.Carts c
INNER JOIN dbo.Products p ON c.ProductId = p.ProductId
WHERE c.CartId = @ShoppingCartId;

-- Statement 12: RemoveFromCart - SELECT cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated
FROM dbo.Carts
WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;

-- Statement 13: RemoveFromCart - UPDATE (decrement count)
-- LINQ: cartItem.Count-- followed by SaveChanges()
UPDATE dbo.Carts
SET Count = @Count
WHERE RecordId = @RecordId;

-- Statement 14: RemoveFromCart - DELETE (when count reaches 0)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
DELETE FROM dbo.Carts
WHERE RecordId = @RecordId;

-- Statement 15: EmptyCart - SELECT cart items
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)
SELECT RecordId, CartId, ProductId, Count, DateCreated
FROM dbo.Carts
WHERE CartId = @ShoppingCartId;

-- Statement 16: EmptyCart - DELETE all cart items
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) in loop
DELETE FROM dbo.Carts
WHERE CartId = @ShoppingCartId;

-- Statement 17: CreateOrder - INSERT order detail
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(new OrderDetail { ... })
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity)
VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- Statement 18: CreateOrder - UPDATE order total
-- LINQ: order.Total = orderTotal followed by SaveChanges()
UPDATE dbo.Orders
SET Total = @Total
WHERE OrderId = @OrderId;

-- =====================================================
-- Source File: Services/OrderProcessing.cs
-- =====================================================

-- Statement 19: ProcessOrder - INSERT order
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total)
VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- =====================================================
-- Source File: Models/GadgetsOnlineInitializer.cs
-- =====================================================

-- Statement 20: Seed Categories
-- LINQ: context.Categories.Add(c) for each category
INSERT INTO dbo.Categories (CategoryId, Name, Description)
VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones'),
       (2, 'Laptops', 'Latest Laptops in 2022'),
       (3, 'Desktops', 'Latest Desktops in 2022'),
       (4, 'Audio', 'Latest audio devices'),
       (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');

-- Statement 21: Seed Products
-- LINQ: context.Products.Add(p) for each product
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl)
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
