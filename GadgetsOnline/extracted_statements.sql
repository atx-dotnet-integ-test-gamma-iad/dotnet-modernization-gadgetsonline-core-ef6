-- =====================================================
-- Extracted MS SQL Server Statements from EF6 LINQ Queries
-- Source Application: GadgetsOnline
-- Extraction Date: 2026-03-04
-- Total Statements: 20
-- =====================================================

-- =====================================================
-- Source: Services/Inventory.cs - GetBestSellers(count)
-- Statement 1: SELECT TOP products
-- =====================================================
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products;

-- =====================================================
-- Source: Services/Inventory.cs - GetAllCategories()
-- Statement 2: SELECT all categories
-- =====================================================
SELECT CategoryId, Name, Description FROM Categories;

-- =====================================================
-- Source: Services/Inventory.cs - GetAllProductsInCategory(category)
-- Statement 3: SELECT products with JOIN on category name
-- =====================================================
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM Products p INNER JOIN Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- =====================================================
-- Source: Services/Inventory.cs - GetProductById(id)
-- Statement 4: SELECT single product by ID
-- =====================================================
SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products WHERE ProductId = @id;

-- =====================================================
-- Source: Services/Inventory.cs - GetProductNameById(id)
-- Statement 5: SELECT product name by ID
-- =====================================================
SELECT TOP(1) Name FROM Products WHERE ProductId = @id;

-- =====================================================
-- Source: Services/ShoppingCart.cs - GetCartItems()
-- Statement 6: SELECT cart items by cart ID
-- =====================================================
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @cartId;

-- =====================================================
-- Source: Services/ShoppingCart.cs - GetTotal()
-- Statement 7: SELECT cart total with JOIN
-- =====================================================
SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- =====================================================
-- Source: Services/ShoppingCart.cs - GetCount()
-- Statement 8: SELECT cart item count
-- =====================================================
SELECT SUM(Count) FROM Carts WHERE CartId = @cartId;

-- =====================================================
-- Source: Services/ShoppingCart.cs - AddToCart(id) - SELECT existing
-- Statement 9: SELECT single cart item for add-to-cart check
-- =====================================================
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @cartId AND ProductId = @id;

-- =====================================================
-- Source: Services/ShoppingCart.cs - AddToCart(id) - INSERT new
-- Statement 10: INSERT new cart item
-- =====================================================
INSERT INTO Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);

-- =====================================================
-- Source: Services/ShoppingCart.cs - AddToCart(id) - UPDATE existing
-- Statement 11: UPDATE cart item count (increment)
-- =====================================================
UPDATE Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @id;

-- =====================================================
-- Source: Services/ShoppingCart.cs - RemoveFromCart(id) - SELECT
-- Statement 12: SELECT cart item for removal
-- =====================================================
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @cartId AND ProductId = @id;

-- =====================================================
-- Source: Services/ShoppingCart.cs - RemoveFromCart(id) - UPDATE
-- Statement 13: UPDATE cart item count (decrement)
-- =====================================================
UPDATE Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @id;

-- =====================================================
-- Source: Services/ShoppingCart.cs - RemoveFromCart(id) - DELETE
-- Statement 14: DELETE single cart item by RecordId
-- =====================================================
DELETE FROM Carts WHERE RecordId = @recordId;

-- =====================================================
-- Source: Services/ShoppingCart.cs - EmptyCart()
-- Statement 15: DELETE all cart items by CartId
-- =====================================================
DELETE FROM Carts WHERE CartId = @cartId;

-- =====================================================
-- Source: Services/ShoppingCart.cs - CreateOrder() - INSERT OrderDetail
-- Statement 16: INSERT order detail
-- =====================================================
INSERT INTO OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- =====================================================
-- Source: Services/ShoppingCart.cs - CreateOrder() - UPDATE Order total
-- Statement 17: UPDATE order total
-- =====================================================
UPDATE Orders SET Total = @total WHERE OrderId = @orderId;

-- =====================================================
-- Source: Services/OrderProcessing.cs - ProcessOrder()
-- Statement 18: INSERT new order
-- =====================================================
INSERT INTO Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- =====================================================
-- Source: Models/GadgetsOnlineInitializer.cs - Seed() categories
-- Statement 19: INSERT category seed data
-- =====================================================
INSERT INTO Categories (CategoryId, Name, Description) VALUES (@categoryId, @name, @description);

-- =====================================================
-- Source: Models/GadgetsOnlineInitializer.cs - Seed() products
-- Statement 20: INSERT product seed data
-- =====================================================
INSERT INTO Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
