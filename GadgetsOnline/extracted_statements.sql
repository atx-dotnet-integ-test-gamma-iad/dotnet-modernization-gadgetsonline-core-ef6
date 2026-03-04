-- ============================================================================
-- Extracted SQL Statements from GadgetsOnline Application
-- Source: Entity Framework LINQ queries converted to equivalent MS SQL Server SQL
-- Original Database: Microsoft SQL Server (schema: dbo)
-- ============================================================================

-- ============================================================================
-- Source: Services/Inventory.cs
-- ============================================================================

-- Statement 1: GetBestSellers(count) - Select top N products
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
SELECT TOP(5) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;

-- Statement 2: GetAllCategories() - Select all categories
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
SELECT CategoryId, Name, Description FROM dbo.Categories;

-- Statement 3: GetAllProductsInCategory(category) - Select products by category name
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Statement 4: GetProductById(id) - Select product by ID
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;

-- Statement 5: GetProductNameById(id) - Select product name by ID
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;

-- ============================================================================
-- Source: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6: CreateOrder - Insert order details for each cart item
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail)
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);

-- Statement 7: EmptyCart - Delete all cart items for a cart
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId) + Remove
DELETE FROM dbo.Carts WHERE CartId = @CartId;

-- Statement 8: AddToCart - Check if item exists in cart
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId;

-- Statement 9: AddToCart - Insert new cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Add(cartItem)
INSERT INTO dbo.Carts (ProductId, CartId, Count, DateCreated) VALUES (@ProductId, @CartId, 1, @DateCreated);

-- Statement 10: AddToCart - Update cart item count
-- LINQ: cartItem.Count++ + SaveChanges
UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @CartId AND ProductId = @ProductId;

-- Statement 11: GetCount - Sum of items in cart
-- LINQ: (from cartItems in Carts where CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @CartId;

-- Statement 12: RemoveFromCart - Select cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)
SELECT TOP 1 RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId;

-- Statement 13: RemoveFromCart - Update count (decrement)
-- LINQ: cartItem.Count-- + SaveChanges
UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @CartId AND ProductId = @ProductId;

-- Statement 14: RemoveFromCart - Delete cart item
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) + SaveChanges
DELETE FROM dbo.Carts WHERE CartId = @CartId AND ProductId = @ProductId;

-- Statement 15: GetCartItems - Select all items in cart
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @CartId;

-- Statement 16: GetTotal - Calculate cart total
-- LINQ: (from cartItems in Carts where CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @CartId;

-- ============================================================================
-- Source: Services/OrderProcessing.cs
-- ============================================================================

-- Statement 17: ProcessOrder - Insert new order
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order) + SaveChanges
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);

-- ============================================================================
-- Source: Models/GadgetsOnlineInitializer.cs
-- ============================================================================

-- Statement 18: Seed - Insert categories
-- LINQ: categories.ForEach(c => context.Categories.Add(c)) + SaveChanges
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@CategoryId, @Name, @Description);

-- Statement 19: Seed - Insert products
-- LINQ: products.ForEach(p => context.Products.Add(p)) + SaveChanges
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@ProductId, @CategoryId, @Name, @Price, @ProductArtUrl);
