# GadgetsOnline Detailed Migration Log
## MS SQL Server to PostgreSQL - SQL Statement Conversion Log

### DMS MCP Tool Configuration

- **Migration Project ARN:** arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII
- **Region:** us-east-1
- **Database Name:** GadgetsOnline
- **Server Name:** gadgetsonline-sqlserver.c6nek0euoyl0.us-east-1.rds.amazonaws.com
- **Schema Name:** dbo

### DMS Tool Error (Consistent Across All Statements)

All 21 statements received the identical error from DMS:

```json
{
  "status": "error",
  "error": "Metadata model creation failed: {'error': \"Metadata model creation failed: {'default_error_details': {'message': 'No objects were found according to the specified selection rules. Please review your selection rules and try again.'}}\"}"
}
```

Multiple parameter combinations were attempted without success. Manual conversion was applied for all statements.

---

### Statement 1: GetBestSellers (Services/Inventory.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Products.Take(count).ToList()`

**Original MS SQL:**
```sql
SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 2: GetAllCategories (Services/Inventory.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Categories.ToList()`

**Original MS SQL:**
```sql
SELECT CategoryId, Name, Description FROM dbo.Categories;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 3: GetAllProductsInCategory (Services/Inventory.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()`

**Original MS SQL:**
```sql
SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 4: GetProductById (Services/Inventory.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()`

**Original MS SQL:**
```sql
SELECT TOP(1) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 5: GetProductNameById (Services/Inventory.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name`

**Original MS SQL:**
```sql
SELECT TOP(1) Name FROM dbo.Products WHERE ProductId = @id;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 6: GetCartItems (Services/ShoppingCart.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()`

**Original MS SQL:**
```sql
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 7: AddToCart-SELECT (Services/ShoppingCart.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)`

**Original MS SQL:**
```sql
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @ProductId LIMIT 1;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 8: AddToCart-INSERT (Services/ShoppingCart.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Carts.Add(new Cart { ... })`

**Original MS SQL:**
```sql
INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@CartId, @ProductId, @Count, @DateCreated);
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 9: AddToCart-UPDATE (Services/ShoppingCart.cs)

**LINQ Source:** `cartItem.Count++` followed by `SaveChanges()`

**Original MS SQL:**
```sql
UPDATE dbo.Carts SET Count = @Count WHERE RecordId = @RecordId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
UPDATE gadgetsonline_dbo.carts SET count = @Count WHERE recordid = @RecordId;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 10: GetCount (Services/ShoppingCart.cs)

**LINQ Source:** `(from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()`

**Original MS SQL:**
```sql
SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @ShoppingCartId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 11: GetTotal (Services/ShoppingCart.cs)

**LINQ Source:** `(from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()`

**Original MS SQL:**
```sql
SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @ShoppingCartId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @ShoppingCartId;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 12: RemoveFromCart-SELECT (Services/ShoppingCart.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)`

**Original MS SQL:**
```sql
SELECT TOP(1) RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId AND ProductId = @ProductId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId AND productid = @ProductId LIMIT 1;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 13: RemoveFromCart-UPDATE (Services/ShoppingCart.cs)

**LINQ Source:** `cartItem.Count--` followed by `SaveChanges()`

**Original MS SQL:**
```sql
UPDATE dbo.Carts SET Count = @Count WHERE RecordId = @RecordId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
UPDATE gadgetsonline_dbo.carts SET count = @Count WHERE recordid = @RecordId;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 14: RemoveFromCart-DELETE (Services/ShoppingCart.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Carts.Remove(cartItem)`

**Original MS SQL:**
```sql
DELETE FROM dbo.Carts WHERE RecordId = @RecordId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @RecordId;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 15: EmptyCart-SELECT (Services/ShoppingCart.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId)`

**Original MS SQL:**
```sql
SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @ShoppingCartId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 16: EmptyCart-DELETE (Services/ShoppingCart.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Carts.Remove(cartItem)` in loop

**Original MS SQL:**
```sql
DELETE FROM dbo.Carts WHERE CartId = @ShoppingCartId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @ShoppingCartId;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 17: CreateOrder-INSERT (Services/ShoppingCart.cs)

**LINQ Source:** `_gadgetsOnlineEntities.OrderDetails.Add(new OrderDetail { ... })`

**Original MS SQL:**
```sql
INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@ProductId, @OrderId, @UnitPrice, @Quantity);
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 18: CreateOrder-UPDATE (Services/ShoppingCart.cs)

**LINQ Source:** `order.Total = orderTotal` followed by `SaveChanges()`

**Original MS SQL:**
```sql
UPDATE dbo.Orders SET Total = @Total WHERE OrderId = @OrderId;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
UPDATE gadgetsonline_dbo.orders SET total = @Total WHERE orderid = @OrderId;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 19: ProcessOrder-INSERT (Services/OrderProcessing.cs)

**LINQ Source:** `_gadgetsOnlineEntities.Orders.Add(order)`

**Original MS SQL:**
```sql
INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total);
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 20: Seed-Categories (Models/GadgetsOnlineInitializer.cs)

**LINQ Source:** `context.Categories.Add(c)` for each category

**Original MS SQL:**
```sql
INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones'), (2, 'Laptops', 'Latest Laptops in 2022'), (3, 'Desktops', 'Latest Desktops in 2022'), (4, 'Audio', 'Latest audio devices'), (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (1, 'Mobile Phones', 'Latest collection of Mobile Phones'), (2, 'Laptops', 'Latest Laptops in 2022'), (3, 'Desktops', 'Latest Desktops in 2022'), (4, 'Audio', 'Latest audio devices'), (5, 'Accessories', 'USB Cables, Mobile chargers and Keyboards etc');
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Statement 21: Seed-Products (Models/GadgetsOnlineInitializer.cs)

**LINQ Source:** `context.Products.Add(p)` for each product

**Original MS SQL:**
```sql
INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg'), (2, 1, 'Phone 13 Pro', 999.00, '/Content/Images/Mobile/2.jpg'), ...;
```

**DMS Output:** ERROR - Metadata model creation failed
**Manual Conversion Applied:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA

**Converted PostgreSQL:**
```sql
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (1, 1, 'Phone 12', 699.00, '/Content/Images/Mobile/1.jpg'), (2, 1, 'Phone 13 Pro', 999.00, '/Content/Images/Mobile/2.jpg'), ...;
```

**Equivalency Tool Result:** ERROR - 'uniqueID'

---

### Additional Code Changes Log

#### GadgetsOnlineEntities.cs - OnModelCreating Fix (Step 4)

**Issue:** The OnModelCreating method used EF Core-style lambda syntax `modelBuilder.Entity<T>(entity => { ... })` which is not supported by EF6 `DbModelBuilder`.

**Error:** `CS1501: No overload for method 'Entity' takes 1 arguments`

**Fix:** Changed to EF6 fluent API syntax:
- `modelBuilder.Entity<T>(entity => { entity.ToTable(...); })` → `modelBuilder.Entity<T>().ToTable(...);`
- `entity.Property(e => e.X).HasColumnName(...)` → `modelBuilder.Entity<T>().Property(e => e.X).HasColumnName(...)`

**Impact:** No functional change - same schema/table/column mappings preserved. Build succeeds after fix.
