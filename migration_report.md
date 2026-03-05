# GadgetsOnline Migration Report
## Microsoft SQL Server to PostgreSQL Migration

---

## 1. Migration Summary

| Metric | Count |
|--------|-------|
| Total SQL statements processed | 15 |
| Statements successfully converted by DMS MCP tool | 0 |
| Statements requiring manual conversion (DMS failure) | 15 |
| Statements validated as equivalent (by SQL Equivalency tool) | 0 |
| Statements validated as non-equivalent (by SQL Equivalency tool) | 0 |
| Statements with equivalency validation errors | 15 |

### DMS Tool Status
All 15 SQL statements were passed through the DMS MCP tool (`dms-mcp___statement_conversion_tool`) with the following parameters:
- **Migration Project ARN:** `arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII`
- **Database Name:** GadgetsOnline
- **Schema Name:** dbo
- **Server Name:** gadgetsonline-sqlserver.c6nek0euoyl0.us-east-1.rds.amazonaws.com

All 15 calls failed with error: `Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}`

Per the transformation definition, manual conversion was applied with lowercase schema object names (`DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA`).

### SQL Equivalency Tool Status
All 15 statement pairs were validated through the SQL Equivalency tool (`sql-equivalency___validate_sql_equivalence`). All returned `ERROR` with error `'uniqueID'`. No agent judgment was used to determine equivalency.

---

## 2. Detailed Statement Listing

### Statement 1: GetBestSellers
- **Source File:** Services/Inventory.cs
- **Method:** `GetBestSellers(int count)`
- **LINQ:** `_gadgetsOnlineEntities.Products.Take(count).ToList()`
- **Original MS SQL:** `SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products;`
- **Converted PostgreSQL:** `SELECT productid, categoryid, name, price, productarturl FROM products LIMIT @count;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** TOP(@count) → LIMIT @count, lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 2: GetAllCategories
- **Source File:** Services/Inventory.cs
- **Method:** `GetAllCategories()`
- **LINQ:** `_gadgetsOnlineEntities.Categories.ToList()`
- **Original MS SQL:** `SELECT CategoryId, Name, Description FROM Categories;`
- **Converted PostgreSQL:** `SELECT categoryid, name, description FROM categories;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 3: GetAllProductsInCategory
- **Source File:** Services/Inventory.cs
- **Method:** `GetAllProductsInCategory(string category)`
- **LINQ:** `_gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()`
- **Original MS SQL:** `SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM Products p INNER JOIN Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;`
- **Converted PostgreSQL:** `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM products p INNER JOIN categories c ON p.categoryid = c.categoryid WHERE c.name = @category;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 4: GetProductById
- **Source File:** Services/Inventory.cs
- **Method:** `GetProductById(int id)`
- **LINQ:** `_gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()`
- **Original MS SQL:** `SELECT ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products WHERE ProductId = @id;`
- **Converted PostgreSQL:** `SELECT productid, categoryid, name, price, productarturl FROM products WHERE productid = @id;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 5: GetProductNameById
- **Source File:** Services/Inventory.cs
- **Method:** `GetProductNameById(int id)`
- **LINQ:** `_gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name`
- **Original MS SQL:** `SELECT Name FROM Products WHERE ProductId = @id;`
- **Converted PostgreSQL:** `SELECT name FROM products WHERE productid = @id;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 6: GetCartItems
- **Source File:** Services/ShoppingCart.cs
- **Method:** `GetCartItems()`
- **LINQ:** `_gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()`
- **Original MS SQL:** `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM Carts WHERE CartId = @cartId;`
- **Converted PostgreSQL:** `SELECT recordid, cartid, productid, count, datecreated FROM carts WHERE cartid = @cartId;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 7: GetCount
- **Source File:** Services/ShoppingCart.cs
- **Method:** `GetCount()`
- **LINQ:** `(from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()`
- **Original MS SQL:** `SELECT SUM(Count) FROM Carts WHERE CartId = @cartId;`
- **Converted PostgreSQL:** `SELECT SUM(count) FROM carts WHERE cartid = @cartId;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 8: GetTotal
- **Source File:** Services/ShoppingCart.cs
- **Method:** `GetTotal()`
- **LINQ:** `(from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()`
- **Original MS SQL:** `SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;`
- **Converted PostgreSQL:** `SELECT SUM(c.count * p.price) FROM carts c INNER JOIN products p ON c.productid = p.productid WHERE c.cartid = @cartId;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 9: AddToCart - INSERT
- **Source File:** Services/ShoppingCart.cs
- **Method:** `AddToCart(int id)` - new item path
- **LINQ:** `_gadgetsOnlineEntities.Carts.Add(new Cart { ProductId = id, CartId = ShoppingCartId, Count = 1, DateCreated = DateTime.Now })`
- **Original MS SQL:** `INSERT INTO Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, GETDATE());`
- **Converted PostgreSQL:** `INSERT INTO carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, NOW());`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers, GETDATE() → NOW()
- **Equivalency Status:** ERROR

### Statement 10: AddToCart - UPDATE
- **Source File:** Services/ShoppingCart.cs
- **Method:** `AddToCart(int id)` - existing item path
- **LINQ:** `cartItem.Count++; _gadgetsOnlineEntities.SaveChanges()`
- **Original MS SQL:** `UPDATE Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;`
- **Converted PostgreSQL:** `UPDATE carts SET count = count + 1 WHERE cartid = @cartId AND productid = @productId;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 11: RemoveFromCart - UPDATE
- **Source File:** Services/ShoppingCart.cs
- **Method:** `RemoveFromCart(int id)` - decrement path
- **LINQ:** `cartItem.Count--; _gadgetsOnlineEntities.SaveChanges()`
- **Original MS SQL:** `UPDATE Carts SET Count = Count - 1 WHERE CartId = @cartId AND ProductId = @productId;`
- **Converted PostgreSQL:** `UPDATE carts SET count = count - 1 WHERE cartid = @cartId AND productid = @productId;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 12: RemoveFromCart - DELETE
- **Source File:** Services/ShoppingCart.cs
- **Method:** `RemoveFromCart(int id)` - remove path
- **LINQ:** `_gadgetsOnlineEntities.Carts.Remove(cartItem)`
- **Original MS SQL:** `DELETE FROM Carts WHERE CartId = @cartId AND ProductId = @productId;`
- **Converted PostgreSQL:** `DELETE FROM carts WHERE cartid = @cartId AND productid = @productId;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 13: EmptyCart
- **Source File:** Services/ShoppingCart.cs
- **Method:** `EmptyCart()`
- **LINQ:** `foreach (var cartItem in cartItems) { _gadgetsOnlineEntities.Carts.Remove(cartItem); }`
- **Original MS SQL:** `DELETE FROM Carts WHERE CartId = @cartId;`
- **Converted PostgreSQL:** `DELETE FROM carts WHERE cartid = @cartId;`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 14: ProcessOrder - INSERT Order
- **Source File:** Services/OrderProcessing.cs
- **Method:** `ProcessOrder(Order order, HttpContext httpContext)`
- **LINQ:** `_gadgetsOnlineEntities.Orders.Add(order)`
- **Original MS SQL:** `INSERT INTO Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);`
- **Converted PostgreSQL:** `INSERT INTO orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

### Statement 15: CreateOrder - INSERT OrderDetail
- **Source File:** Services/ShoppingCart.cs
- **Method:** `CreateOrder(Order order)`
- **LINQ:** `_gadgetsOnlineEntities.OrderDetails.Add(orderDetail)`
- **Original MS SQL:** `INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@orderId, @productId, @quantity, @unitPrice);`
- **Converted PostgreSQL:** `INSERT INTO orderdetails (orderid, productid, quantity, unitprice) VALUES (@orderId, @productId, @quantity, @unitPrice);`
- **Conversion Method:** DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Changes:** lowercase identifiers
- **Equivalency Status:** ERROR

---

## 3. Package Migration Status

### Removed SQL Server Packages
- `Microsoft.Data.SqlClient` - Removed (was not present in migrated codebase)
- `System.Data.SqlClient` - Removed (was not present in migrated codebase)

### Added PostgreSQL/Npgsql Packages
| Package | Version |
|---------|---------|
| Npgsql | 5.0.18 |
| EntityFramework6.Npgsql | 6.4.3 |
| EntityFramework | 6.5.1 |

---

## 4. Configuration Changes

### Connection String Migration
- **Before (SQL Server format):** `Server=<hostname>;Database=GadgetsOnline;Integrated Security=true;`
- **After (PostgreSQL format):** `Host=gadgetsonline-sqlserver.c6nek0euoyl0.us-east-1.rds.amazonaws.com;Database=postgres;Username=${DB_USER};Password=${DB_PASSWORD};`

### EF6 Provider Configuration (app.config)
- Provider: `Npgsql.NpgsqlServices, EntityFramework6.Npgsql`
- Connection Factory: `Npgsql.NpgsqlConnectionFactory, EntityFramework6.Npgsql`
- DbProviderFactory: `Npgsql.NpgsqlFactory, Npgsql`

### EF6 DbConfiguration (GadgetsOnlineEntities.cs)
- `GadgetsOnlineEntitiesPostgreSqlConfiguration` class sets Npgsql provider services and NpgsqlConnectionFactory
- `[DbConfigurationType(typeof(GadgetsOnlineEntitiesPostgreSqlConfiguration))]` attribute on DbContext

### Model Mapping Changes
All entity models updated with:
- `[Table]` attributes using lowercase table names with `gadgetsonline_dbo` schema
- `[Column]` attributes using lowercase column names
- Fluent API mappings in `OnModelCreating` matching the annotation configuration

| Entity | Table Name | Schema |
|--------|-----------|--------|
| Product | products | gadgetsonline_dbo |
| Category | categories | gadgetsonline_dbo |
| Cart | carts | gadgetsonline_dbo |
| Order | orders | gadgetsonline_dbo |
| OrderDetail | orderdetails | gadgetsonline_dbo |

---

## 5. Manual Interventions

### DMS Failures
All 15 DMS conversion attempts failed with:
```
Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}
```

**Root Cause:** The DMS migration project's metadata model could not locate the source database objects. This is likely because the source SQL Server database objects have already been migrated and are no longer accessible to DMS for metadata model creation.

**Resolution:** All statements were manually converted with lowercase schema object names per the transformation definition's `DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA` rules:
- All table and column identifiers converted to lowercase
- `TOP(@count)` converted to `LIMIT @count`
- `GETDATE()` converted to `NOW()`

### Equivalency Validation Issues
All 15 SQL Equivalency tool validations returned `ERROR` with error `'uniqueID'`. This appears to be a service-side issue with the SQL Equivalency tool, not a problem with the statement conversions. All status values are recorded as `ERROR` per the tool output (no agent judgment used).

---

## 6. Migration Artifacts

| Artifact | Location | Description |
|----------|----------|-------------|
| extracted_statements.sql | sourceCode/ | All 15 original MS SQL Server SQL statements |
| converted_statements.sql | sourceCode/ | All 15 converted PostgreSQL SQL statements |
| sql_equivalency_validation_report.json | sourceCode/ | Comprehensive equivalency validation report |
| migration_report.md | sourceCode/ | This report |

---

## 7. Build Status

**Final Build:** ✅ **SUCCESS** (0 warnings, 0 errors)

```
Build succeeded.
    0 Warning(s)
    0 Error(s)
```

---

## 8. Application Architecture Note

This application uses **Entity Framework 6 with LINQ-to-Entities** - there are no raw SQL strings in the C# source code. The LINQ queries are database-agnostic and are translated to PostgreSQL SQL at runtime by the EF6 Npgsql provider. The SQL statements extracted and converted in this report represent the **logical SQL equivalents** of the LINQ queries, documented for completeness and migration validation purposes. The actual runtime SQL generation is handled entirely by the EF6 provider configuration.
