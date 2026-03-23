-- ============================================================================
-- Extracted SQL Statements from GadgetsOnline Application
-- ============================================================================
-- Application Type: .NET 8.0 ASP.NET Core with Entity Framework 6 (EF6)
-- Database Access: EF6 LINQ queries (no raw/inline SQL statements in source code)
-- ORM Provider: Npgsql (EntityFramework6.Npgsql)
-- 
-- IMPORTANT NOTE: This application uses Entity Framework 6 with LINQ exclusively
-- for all database operations. There are NO raw SQL strings, SqlCommand objects,
-- StringBuilder-based SQL construction, stored procedure calls, or
-- Database.ExecuteSqlCommand/SqlQuery invocations in the codebase.
--
-- The 15 SQL statements below represent the SQL-equivalent translations of the
-- LINQ queries found in the service layer. These are extracted to fulfill the
-- transformation definition requirement that ALL SQL-generating patterns be
-- examined and processed through the DMS MCP tool.
--
-- Comprehensive Scan Results:
--   - 22 .cs source files scanned (excluding bin/obj)
--   - 0 raw SQL string literals found
--   - 0 SqlConnection/SqlCommand/SqlDataReader/SqlParameter references found
--   - 0 StringBuilder-based SQL constructions found
--   - 0 stored procedure calls found
--   - 0 Database.ExecuteSqlCommand/Database.SqlQuery/ExecuteSqlRaw calls found
--   - 0 Microsoft.Data.SqlClient or System.Data.SqlClient imports found
--   - 15 LINQ queries translated to SQL-equivalent statements for processing
--
-- Files Scanned:
--   GadgetsOnline/GadgetsOnline.csproj - Npgsql packages confirmed, no SQL Server packages
--   GadgetsOnline/appsettings.json - PostgreSQL connection string confirmed
--   GadgetsOnline/app.config - Npgsql provider configuration confirmed
--   GadgetsOnline/Services/Inventory.cs - 5 LINQ queries (Statements 1-5)
--   GadgetsOnline/Services/ShoppingCart.cs - 9 LINQ operations (Statements 6-14)
--   GadgetsOnline/Services/OrderProcessing.cs - 1 LINQ operation (Statement 15)
--   GadgetsOnline/Models/GadgetsOnlineEntities.cs - DbContext with PostgreSQL config
--   GadgetsOnline/Models/GadgetsOnlineInitializer.cs - Database seed data
--   GadgetsOnline/Models/Cart.cs - Entity model with PostgreSQL table mapping
--   GadgetsOnline/Models/Category.cs - Entity model with PostgreSQL table mapping
--   GadgetsOnline/Models/Order.cs - Entity model with PostgreSQL table mapping
--   GadgetsOnline/Models/OrderDetail.cs - Entity model with PostgreSQL table mapping
--   GadgetsOnline/Models/Product.cs - Entity model with PostgreSQL table mapping
--   GadgetsOnline/Controllers/CheckoutController.cs - No direct DB access
--   GadgetsOnline/Controllers/HomeController.cs - No direct DB access
--   GadgetsOnline/Controllers/ShoppingCartController.cs - No direct DB access
--   GadgetsOnline/Controllers/StoreController.cs - No direct DB access
--   GadgetsOnline/Components/CategoryMenuViewComponent.cs - No direct DB access
--   GadgetsOnline/Startup.cs - DbContext registration, no direct SQL
--   GadgetsOnline/Program.cs - Host builder, no DB access
--
-- Total Statements: 15
-- ============================================================================

-- ============================================================================
-- Source File: Services/Inventory.cs
-- ============================================================================

-- Statement 1 (a): GetBestSellers (Inventory.cs, Line ~26)
-- LINQ: _gadgetsOnlineEntities.Products.Take(count).ToList()
-- Context: Returns top N best-selling products
SELECT TOP(@count) * FROM dbo.Products;

-- Statement 2 (b): GetAllCategories (Inventory.cs, Line ~32)
-- LINQ: _gadgetsOnlineEntities.Categories.ToList()
-- Context: Returns all product categories
SELECT * FROM dbo.Categories;

-- Statement 3 (c): GetAllProductsInCategory (Inventory.cs, Line ~37)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()
-- Context: Returns all products in a given category by name (JOIN version)
SELECT p.* FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;

-- Statement 4 (d): GetProductById (Inventory.cs, Line ~43)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()
-- Context: Returns a single product by ID (TOP 1 for FirstOrDefault)
SELECT TOP 1 * FROM dbo.Products WHERE ProductId = @id;

-- Statement 5 (e): GetProductNameById (Inventory.cs, Line ~49)
-- LINQ: _gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name
-- Context: Returns just the name of a product by ID
SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id;

-- ============================================================================
-- Source File: Services/ShoppingCart.cs
-- ============================================================================

-- Statement 6 (f): AddToCart - SELECT part (ShoppingCart.cs, Line ~87)
-- LINQ: _gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)
-- Context: Check if item already exists in cart
SELECT * FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 7 (g): AddToCart - INSERT part (ShoppingCart.cs, Line ~91)
-- LINQ: _gadgetsOnlineEntities.Carts.Add(new Cart { ... })
-- Context: Add new item to cart if not already present
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, @count, @dateCreated);

-- Statement 8 (h): GetCartItems (ShoppingCart.cs, Line ~140)
-- LINQ: _gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()
-- Context: Returns all items in a shopping cart
SELECT * FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 9 (i): GetCount (ShoppingCart.cs, Line ~108)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()
-- Context: Get total item count in shopping cart
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;

-- Statement 10 (j): RemoveFromCart - DELETE (ShoppingCart.cs, Line ~119)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem)
-- Context: Remove a specific item from the cart
DELETE FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 11 (k): RemoveFromCart - UPDATE count (ShoppingCart.cs, Line ~126)
-- LINQ: cartItem.Count-- (tracked entity update via SaveChanges)
-- Context: Decrement item count in cart instead of removing
UPDATE dbo.Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId;

-- Statement 12 (l): GetTotal (ShoppingCart.cs, Line ~146)
-- LINQ: (from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()
-- Context: Get total price of all items in shopping cart
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;

-- Statement 13 (m): ProcessOrder - INSERT order (OrderProcessing.cs / referenced in ShoppingCart)
-- LINQ: _gadgetsOnlineEntities.Orders.Add(order)
-- Context: Insert a new order record
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- Statement 14 (n): CreateOrder - INSERT order details (ShoppingCart.cs, Line ~39)
-- LINQ: _gadgetsOnlineEntities.OrderDetails.Add(orderDetail) in foreach loop
-- Context: Create order detail entries for each cart item
INSERT INTO dbo.OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice);

-- Statement 15 (o): EmptyCart (ShoppingCart.cs, Line ~59)
-- LINQ: _gadgetsOnlineEntities.Carts.Remove(cartItem) in foreach loop
-- Context: Remove all items from shopping cart
DELETE FROM dbo.Carts WHERE CartId = @cartId;
