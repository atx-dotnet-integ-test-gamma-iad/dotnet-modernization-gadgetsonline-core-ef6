# GadgetsOnline - MS SQL Server to PostgreSQL Migration Report

## Executive Summary

This report documents the migration of the GadgetsOnline ASP.NET Core web application from Microsoft SQL Server to PostgreSQL. The application uses Entity Framework 6 with LINQ queries for all database access — no raw inline SQL statements exist in the codebase. The migration has been completed successfully with 0 build errors and 0 warnings.

## Migration Overview

| Metric | Value |
|--------|-------|
| Total SQL Statements Extracted | 16 |
| DMS Tool Conversion Attempts | 16 |
| DMS Tool Conversion Successes | 0 |
| DMS Tool Conversion Failures | 16 |
| Manual Conversions (with lowercase schema) | 16 |
| Equivalency Validated as EQUIVALENT | 0 |
| Equivalency Validated as NOT_EQUIVALENT | 0 |
| Equivalency Validation Errors | 16 |
| Build Status | Success (0 errors, 0 warnings) |

## Tool Status

### DMS MCP Statement Conversion Tool
- **Status**: All 16 statements returned errors
- **Error**: `Metadata model creation failed: The selected objects were not found.`
- **Root Cause**: The DMS migration project metadata model could not locate the database objects. This is likely because the source SQL Server database schema has already been migrated to PostgreSQL, and the DMS migration project no longer has valid source objects to reference.
- **Fallback**: All statements were manually converted using lowercase schema object naming conventions per the transformation definition (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA).

### SQL Equivalency Validation Tool
- **Status**: All 16 statement pairs returned errors
- **Error**: `'uniqueID'` error on every invocation
- **Root Cause**: Internal tool configuration issue. The equivalency tool returned a consistent `'uniqueID'` key error for every statement pair regardless of complexity.
- **Impact**: No automated equivalency validation could be performed. All statements are marked as ERROR per the transformation definition requirements.
- **IMPORTANT**: No agent judgment was used to determine equivalency - all results are directly from the tool output.

## Application Architecture

The GadgetsOnline application is an ASP.NET Core (.NET 8.0) web application that uses:
- **Entity Framework 6** (v6.5.1) for ORM
- **EntityFramework6.Npgsql** (v6.4.3) for PostgreSQL provider
- **Npgsql** (v5.0.18) for the PostgreSQL ADO.NET data provider

All database access is performed through EF6 LINQ queries — there are no raw SQL strings, SqlClient references, or inline SQL in the codebase.

## Schema Mapping

The application maps to lowercase PostgreSQL schema objects in the `gadgetsonline_dbo` schema:

| Entity | MS SQL Table | PostgreSQL Table | Schema |
|--------|-------------|-----------------|--------|
| Product | Products | products | gadgetsonline_dbo |
| Category | Categories | categories | gadgetsonline_dbo |
| Cart | Carts | carts | gadgetsonline_dbo |
| Order | Orders | orders | gadgetsonline_dbo |
| OrderDetail | OrderDetails | orderdetails | gadgetsonline_dbo |

## Column Mapping Details

### Products → products
| MS SQL Column | PostgreSQL Column | Type |
|---------------|------------------|------|
| ProductId | productid | INT |
| CategoryId | categoryid | INT |
| Name | name | VARCHAR(255) |
| Price | price | DECIMAL(18,2) |
| ProductArtUrl | productarturl | VARCHAR(1024) |

### Categories → categories
| MS SQL Column | PostgreSQL Column | Type |
|---------------|------------------|------|
| CategoryId | categoryid | INT |
| Name | name | VARCHAR(255) |
| Description | description | TEXT |

### Carts → carts
| MS SQL Column | PostgreSQL Column | Type |
|---------------|------------------|------|
| RecordId | recordid | INT |
| CartId | cartid | VARCHAR(255) |
| ProductId | productid | INT |
| Count | count | INT |
| DateCreated | datecreated | TIMESTAMP |

### Orders → orders
| MS SQL Column | PostgreSQL Column | Type |
|---------------|------------------|------|
| OrderId | orderid | INT |
| OrderDate | orderdate | TIMESTAMP |
| Username | username | VARCHAR(255) |
| FirstName | firstname | VARCHAR(160) |
| LastName | lastname | VARCHAR(160) |
| Address | address | VARCHAR(70) |
| City | city | VARCHAR(40) |
| State | state | VARCHAR(40) |
| PostalCode | postalcode | VARCHAR(10) |
| Country | country | VARCHAR(40) |
| Phone | phone | VARCHAR(24) |
| Email | email | VARCHAR(255) |
| Total | total | DECIMAL(18,2) |

### OrderDetails → orderdetails
| MS SQL Column | PostgreSQL Column | Type |
|---------------|------------------|------|
| OrderDetailId | orderdetailid | INT |
| OrderId | orderid | INT |
| ProductId | productid | INT |
| Quantity | quantity | INT |
| UnitPrice | unitprice | DECIMAL(18,2) |

## Statement Catalog

### Statement 1: GetBestSellers
- **Source**: `Services/Inventory.cs` - `GetBestSellers(int count)`
- **LINQ**: `_gadgetsOnlineEntities.Products.Take(count).ToList()`
- **MS SQL**: `SELECT TOP(@count) ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products`
- **PostgreSQL**: `SELECT productid, categoryid, name, price, productarturl FROM products LIMIT @count`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 2: GetAllCategories
- **Source**: `Services/Inventory.cs` - `GetAllCategories()`
- **LINQ**: `_gadgetsOnlineEntities.Categories.ToList()`
- **MS SQL**: `SELECT CategoryId, Name, Description FROM Categories`
- **PostgreSQL**: `SELECT categoryid, name, description FROM categories`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 3: GetAllProductsInCategory
- **Source**: `Services/Inventory.cs` - `GetAllProductsInCategory(string category)`
- **LINQ**: `_gadgetsOnlineEntities.Products.Where(p => p.Category.Name == category).ToList()`
- **MS SQL**: `SELECT * FROM Products p INNER JOIN Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category`
- **PostgreSQL**: `SELECT * FROM products p INNER JOIN categories c ON p.categoryid = c.categoryid WHERE c.name = @category`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 4: GetProductById
- **Source**: `Services/Inventory.cs` - `GetProductById(int id)`
- **LINQ**: `_gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault()`
- **MS SQL**: `SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM Products WHERE ProductId = @id`
- **PostgreSQL**: `SELECT productid, categoryid, name, price, productarturl FROM products WHERE productid = @id LIMIT 1`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 5: GetProductNameById
- **Source**: `Services/Inventory.cs` - `GetProductNameById(int id)`
- **LINQ**: `_gadgetsOnlineEntities.Products.Where(p => p.ProductId == id).FirstOrDefault().Name`
- **MS SQL**: `SELECT TOP 1 Name FROM Products WHERE ProductId = @id`
- **PostgreSQL**: `SELECT name FROM products WHERE productid = @id LIMIT 1`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 6: GetCartItems
- **Source**: `Services/ShoppingCart.cs` - `GetCartItems()`
- **LINQ**: `_gadgetsOnlineEntities.Carts.Where(cart => cart.CartId == ShoppingCartId).ToList()`
- **MS SQL**: `SELECT * FROM Carts WHERE CartId = @cartId`
- **PostgreSQL**: `SELECT * FROM carts WHERE cartid = @cartId`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 7: AddToCart (lookup)
- **Source**: `Services/ShoppingCart.cs` - `AddToCart(int id)`
- **LINQ**: `_gadgetsOnlineEntities.Carts.SingleOrDefault(c => c.CartId == ShoppingCartId && c.ProductId == id)`
- **MS SQL**: `SELECT TOP 1 * FROM Carts WHERE CartId = @cartId AND ProductId = @id`
- **PostgreSQL**: `SELECT * FROM carts WHERE cartid = @cartId AND productid = @id LIMIT 1`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 8: AddToCart (insert)
- **Source**: `Services/ShoppingCart.cs` - `AddToCart(int id)`
- **EF**: `_gadgetsOnlineEntities.Carts.Add(cartItem)`
- **MS SQL**: `INSERT INTO Carts (ProductId, CartId, Count, DateCreated) VALUES (@productId, @cartId, 1, @now)`
- **PostgreSQL**: `INSERT INTO carts (productid, cartid, count, datecreated) VALUES (@productId, @cartId, 1, @now)`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 9: GetCount
- **Source**: `Services/ShoppingCart.cs` - `GetCount()`
- **LINQ**: `(from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count).Sum()`
- **MS SQL**: `SELECT SUM(Count) FROM Carts WHERE CartId = @cartId`
- **PostgreSQL**: `SELECT SUM(count) FROM carts WHERE cartid = @cartId`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 10: GetTotal
- **Source**: `Services/ShoppingCart.cs` - `GetTotal()`
- **LINQ**: `(from cartItems in _gadgetsOnlineEntities.Carts where cartItems.CartId == ShoppingCartId select (int?)cartItems.Count * cartItems.Product.Price).Sum()`
- **MS SQL**: `SELECT SUM(c.Count * p.Price) FROM Carts c INNER JOIN Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId`
- **PostgreSQL**: `SELECT SUM(c.count * p.price) FROM carts c INNER JOIN products p ON c.productid = p.productid WHERE c.cartid = @cartId`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 11: RemoveFromCart (lookup)
- **Source**: `Services/ShoppingCart.cs` - `RemoveFromCart(int id)`
- **LINQ**: `_gadgetsOnlineEntities.Carts.Single(cart => cart.CartId == ShoppingCartId && cart.ProductId == id)`
- **MS SQL**: `SELECT * FROM Carts WHERE CartId = @cartId AND ProductId = @id`
- **PostgreSQL**: `SELECT * FROM carts WHERE cartid = @cartId AND productid = @id`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 12: RemoveFromCart (update)
- **Source**: `Services/ShoppingCart.cs` - `RemoveFromCart(int id)`
- **EF**: `cartItem.Count--` (change tracking + SaveChanges)
- **MS SQL**: `UPDATE Carts SET Count = @newCount WHERE RecordId = @recordId AND CartId = @cartId AND ProductId = @productId`
- **PostgreSQL**: `UPDATE carts SET count = @newCount WHERE recordid = @recordId AND cartid = @cartId AND productid = @productId`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 13: RemoveFromCart (delete)
- **Source**: `Services/ShoppingCart.cs` - `RemoveFromCart(int id)`
- **EF**: `_gadgetsOnlineEntities.Carts.Remove(cartItem)`
- **MS SQL**: `DELETE FROM Carts WHERE RecordId = @recordId AND CartId = @cartId AND ProductId = @productId`
- **PostgreSQL**: `DELETE FROM carts WHERE recordid = @recordId AND cartid = @cartId AND productid = @productId`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 14: EmptyCart
- **Source**: `Services/ShoppingCart.cs` - `EmptyCart()`
- **EF**: foreach loop with `_gadgetsOnlineEntities.Carts.Remove(cartItem)`
- **MS SQL**: `DELETE FROM Carts WHERE CartId = @cartId`
- **PostgreSQL**: `DELETE FROM carts WHERE cartid = @cartId`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 15: ProcessOrder (Insert Order)
- **Source**: `Services/OrderProcessing.cs` - `ProcessOrder()`
- **EF**: `_gadgetsOnlineEntities.Orders.Add(order)` + SaveChanges
- **MS SQL**: `INSERT INTO Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total)`
- **PostgreSQL**: `INSERT INTO orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@OrderDate, @Username, @FirstName, @LastName, @Address, @City, @State, @PostalCode, @Country, @Phone, @Email, @Total)`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

### Statement 16: CreateOrder (Insert OrderDetail)
- **Source**: `Services/ShoppingCart.cs` - `CreateOrder(Order order)`
- **EF**: loop with `_gadgetsOnlineEntities.OrderDetails.Add(orderDetail)`
- **MS SQL**: `INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice)`
- **PostgreSQL**: `INSERT INTO orderdetails (orderid, productid, quantity, unitprice) VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice)`
- **DMS Status**: Failed - Metadata model creation failed
- **Conversion Method**: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
- **Equivalency Status**: ERROR (tool returned 'uniqueID' error)

## Package Dependencies

| Package | Version | Status |
|---------|---------|--------|
| Microsoft.Data.SqlClient | N/A | **Not present** (correctly removed) |
| System.Data.SqlClient | N/A | **Not present** (correctly removed) |
| EntityFramework | 6.5.1 | Present |
| EntityFramework6.Npgsql | 6.4.3 | Present |
| Npgsql | 5.0.18 | Present |
| Microsoft.AspNetCore.Hosting.Abstractions | 2.3.0 | Present |
| Microsoft.VisualStudio.Azure.Containers.Tools.Targets | 1.17.0 | Present |

## Connection String

The connection string in `appsettings.json` uses PostgreSQL format:
```
Host=<host>;Database=postgres;Username=<user>;Password=<password>
```

## Static Code Verification

| Check | Result |
|-------|--------|
| No SqlConnection references | ✅ PASS |
| No SqlCommand references | ✅ PASS |
| No SqlDataReader references | ✅ PASS |
| No SqlParameter references | ✅ PASS |
| No System.Data.SqlClient imports | ✅ PASS |
| No Microsoft.Data.SqlClient imports | ✅ PASS |
| Npgsql packages in csproj | ✅ PASS |
| PostgreSQL connection string | ✅ PASS |
| Npgsql provider in app.config | ✅ PASS |
| EF6 NpgsqlServices configured | ✅ PASS |
| EF6 NpgsqlConnectionFactory configured | ✅ PASS |
| All models use lowercase [Table] attributes | ✅ PASS |
| All models use lowercase [Column] attributes | ✅ PASS |
| OnModelCreating uses gadgetsonline_dbo schema | ✅ PASS |
| Build succeeds (0 errors, 0 warnings) | ✅ PASS |

## SQL Re-integration

Since this application uses Entity Framework 6 LINQ queries (not raw SQL), and the entity model already maps to lowercase PostgreSQL table/column names via `[Table]` and `[Column]` attributes and fluent API configuration in `OnModelCreating`, no SQL re-integration into source code was needed. The EF6 Npgsql provider generates correct PostgreSQL SQL at runtime based on the entity model mappings.

## Artifacts Generated

| Artifact | Location |
|----------|----------|
| Extracted MS SQL Statements | `sourceCode/extracted_statements.sql` |
| Converted PostgreSQL Statements | `sourceCode/converted_statements.sql` |
| SQL Equivalency Validation Report | `sourceCode/sql_equivalency_validation_report.json` |
| Build Log | `sourceCode/build.log` |
| Migration Report | `sourceCode/migration_report.md` |

## Recommendations for Manual Review

1. **Equivalency Validation**: All 16 statement pairs returned ERROR from the SQL Equivalency tool due to a `'uniqueID'` internal error. Manual review of statement equivalency is recommended.
2. **Runtime Testing**: Since SQL is generated by EF6 at runtime, integration tests against a PostgreSQL database should be performed to verify actual query generation.
3. **DMS Tool Access**: The DMS tool consistently failed with metadata model errors. If source SQL Server database becomes accessible, re-running DMS conversion is recommended to validate the manual conversions.
4. **DateTime Handling**: The `GadgetsOnlineEntities` context includes a `FixDateTimeKinds()` method that ensures all DateTime values are set to UTC before saving, which is important for PostgreSQL TIMESTAMP compatibility.
5. **Lazy Loading**: The EF6 context has lazy loading enabled. Verify this works correctly with the Npgsql provider in production scenarios.
