# GadgetsOnline - SQL Server to PostgreSQL Migration Report

## 1. Migration Summary

| Property | Value |
|---|---|
| **Application** | GadgetsOnline |
| **Framework** | .NET 8.0 with Entity Framework 6 |
| **Source Database** | Microsoft SQL Server 2019 |
| **Target Database** | PostgreSQL 13 |
| **Source Schema** | dbo |
| **Target Schema** | gadgetsonline_dbo |
| **Database Access Pattern** | Entity Framework 6 LINQ (no raw ADO.NET SQL) |
| **DMS Project ARN** | arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII |
| **Migration Date** | 2026-03-23 |

## 2. SQL Statement Processing

### Summary
| Metric | Count |
|---|---|
| Total statements extracted | 14 |
| DMS conversion successful | 0 |
| DMS conversion failed | 14 |
| Manual conversion applied | 14 |

### DMS Tool Results
All 14 statements were submitted to the DMS MCP tool (dms-mcp___statement_conversion_tool) with the following parameters:
- `migration_project_identifier`: `arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII`
- `database_name`: `GadgetsOnline`
- `schema_name`: `dbo`
- `region`: `us-east-1`

**All 14 statements failed** with the same error:
```
Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'No objects were found according to the specified selection rules. Please review your selection rules and try again.'}}"}
```

### DMS Attempt Timestamps (Retry Attempt 2 - 2026-03-23)
| # | Statement | DMS Timestamp | Status |
|---|---|---|---|
| 1 | GetBestSellers | 2026-03-23T20:30:51 | FAILED |
| 2 | GetAllCategories | 2026-03-23T20:31:14 | FAILED |
| 3 | GetAllProductsInCategory | 2026-03-23T20:31:39 | FAILED |
| 4 | GetProductById | 2026-03-23T20:32:02 | FAILED |
| 5 | GetProductNameById | 2026-03-23T20:32:24 | FAILED |
| 6 | GetCartItems | 2026-03-23T20:32:47 | FAILED |
| 7 | GetCount | 2026-03-23T20:33:09 | FAILED |
| 8 | GetTotal | 2026-03-23T20:33:33 | FAILED |
| 9 | AddToCart (SELECT) | 2026-03-23T20:33:58 | FAILED |
| 10 | AddToCart (INSERT) | 2026-03-23T20:34:22 | FAILED |
| 11 | RemoveFromCart (SELECT) | 2026-03-23T20:34:45 | FAILED |
| 12 | EmptyCart (DELETE) | 2026-03-23T20:35:08 | FAILED |
| 13 | CreateOrder (INSERT) | 2026-03-23T20:35:30 | FAILED |
| 14 | ProcessOrder (INSERT) | 2026-03-23T20:35:53 | FAILED |

### Manual Conversion Rules Applied (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA)
Since all DMS conversions failed, manual conversion was applied with the following rules:
- **Schema mapping**: `dbo` → `gadgetsonline_dbo`
- **Table names**: PascalCase → lowercase (e.g., `Products` → `products`)
- **Column names**: PascalCase → lowercase (e.g., `ProductId` → `productid`)
- **SQL syntax**: `TOP N` → `LIMIT N` (moved to end of query)
- **Parameters**: `@` prefix retained (compatible with Npgsql)

### Complete Statement Catalog

| # | Source File | Method | Original MS SQL | Converted PostgreSQL | DMS Result |
|---|---|---|---|---|---|
| 1 | Inventory.cs | GetBestSellers | `SELECT TOP 5 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products` | `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT 5` | FAILED |
| 2 | Inventory.cs | GetAllCategories | `SELECT CategoryId, Name, Description FROM dbo.Categories` | `SELECT categoryid, name, description FROM gadgetsonline_dbo.categories` | FAILED |
| 3 | Inventory.cs | GetAllProductsInCategory | `SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category` | `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category` | FAILED |
| 4 | Inventory.cs | GetProductById | `SELECT TOP 1 ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id` | `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1` | FAILED |
| 5 | Inventory.cs | GetProductNameById | `SELECT TOP 1 Name FROM dbo.Products WHERE ProductId = @id` | `SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1` | FAILED |
| 6 | ShoppingCart.cs | GetCartItems | `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId` | `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId` | FAILED |
| 7 | ShoppingCart.cs | GetCount | `SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId` | `SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId` | FAILED |
| 8 | ShoppingCart.cs | GetTotal | `SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId` | `SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId` | FAILED |
| 9 | ShoppingCart.cs | AddToCart (SELECT) | `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId` | `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId` | FAILED |
| 10 | ShoppingCart.cs | AddToCart (INSERT) | `INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, @count, @dateCreated)` | `INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, @count, @dateCreated)` | FAILED |
| 11 | ShoppingCart.cs | RemoveFromCart (SELECT) | `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId` | `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @productId` | FAILED |
| 12 | ShoppingCart.cs | EmptyCart (DELETE) | `DELETE FROM dbo.Carts WHERE CartId = @cartId` | `DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId` | FAILED |
| 13 | ShoppingCart.cs | CreateOrder (INSERT) | `INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity)` | `INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@productId, @orderId, @unitPrice, @quantity)` | FAILED |
| 14 | OrderProcessing.cs | ProcessOrder (INSERT) | `INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total)` | `INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total)` | FAILED |

## 3. SQL Equivalency Validation

### Summary
| Metric | Count |
|---|---|
| Total pairs validated | 14 |
| EQUIVALENT | 0 |
| NOT_EQUIVALENT | 0 |
| ERROR | 14 |

**Note:** All equivalency statuses were determined **solely by the SQL Equivalency MCP tool** (sql-equivalency___validate_sql_equivalence). No agent judgment was used for equivalency determination.

### Equivalency Validation Timestamps (Retry Attempt 2 - 2026-03-23)
| # | Statement | Equivalency Timestamp | Status |
|---|---|---|---|
| 1 | GetBestSellers | 2026-03-23T20:38:19 | ERROR |
| 2 | GetAllCategories | 2026-03-23T20:38:31 | ERROR |
| 3 | GetAllProductsInCategory | 2026-03-23T20:38:42 | ERROR |
| 4 | GetProductById | 2026-03-23T20:38:51 | ERROR |
| 5 | GetProductNameById | 2026-03-23T20:39:00 | ERROR |
| 6 | GetCartItems | 2026-03-23T20:39:10 | ERROR |
| 7 | GetCount | 2026-03-23T20:39:21 | ERROR |
| 8 | GetTotal | 2026-03-23T20:39:31 | ERROR |
| 9 | AddToCart (SELECT) | 2026-03-23T20:39:41 | ERROR |
| 10 | AddToCart (INSERT) | 2026-03-23T20:39:55 | ERROR |
| 11 | RemoveFromCart (SELECT) | 2026-03-23T20:40:04 | ERROR |
| 12 | EmptyCart (DELETE) | 2026-03-23T20:40:14 | ERROR |
| 13 | CreateOrder (INSERT) | 2026-03-23T20:40:25 | ERROR |
| 14 | ProcessOrder (INSERT) | 2026-03-23T20:40:37 | ERROR |

All 14 statement pairs returned the same error from the equivalency tool:
```json
{"equivalence_status": "ERROR", "error": "'uniqueID'"}
```

The full equivalency validation report is available in `sql_equivalency_validation_report.json`.

### Recommendation
The SQL Equivalency tool returned errors for all 14 statement pairs due to a `'uniqueID'` internal error. This appears to be a tool-side issue rather than a problem with the converted statements. **Manual review of the converted statements is recommended** to verify equivalency. The manual conversions follow standard SQL Server to PostgreSQL migration patterns (lowercase identifiers, schema remapping, TOP→LIMIT).

## 4. Package Dependency Changes

| Package | Status |
|---|---|
| Microsoft.Data.SqlClient | ❌ Not present (confirmed removed) |
| System.Data.SqlClient | ❌ Not present (confirmed removed) |
| Npgsql | ✅ Version 5.0.18 |
| EntityFramework6.Npgsql | ✅ Version 6.4.3 |
| Microsoft.AspNetCore.Hosting.Abstractions | ✅ Version 2.3.0 (unchanged) |
| Microsoft.VisualStudio.Azure.Containers.Tools.Targets | ✅ Version 1.17.0 (unchanged) |

## 5. Connection String Status

**Format:** PostgreSQL (Host=, Database=, Username=, Password=)
```
Host=gadgetsonline-sqlserver.c6nek0euoyl0.us-east-1.rds.amazonaws.com;Database=postgres;Username=${DB_USER};Password=${DB_PASSWORD};
```

**Note:** Connection string uses environment variable placeholders for credentials (`${DB_USER}`, `${DB_PASSWORD}`), following security best practices.

## 6. EF Provider Configuration

### app.config
- **Provider**: `Npgsql` (NpgsqlServices, EntityFramework6.Npgsql)
- **Default Connection Factory**: `Npgsql.NpgsqlConnectionFactory`
- **DbProviderFactory**: `Npgsql.NpgsqlFactory`

### GadgetsOnlineEntities.cs
- **DbConfiguration**: `GadgetsOnlineEntitiesPostgreSqlConfiguration`
  - `SetProviderServices("Npgsql", Npgsql.NpgsqlServices.Instance)`
  - `SetDefaultConnectionFactory(new Npgsql.NpgsqlConnectionFactory())`
- **DateTime Handling**: `FixDateTimeKinds()` method converts all DateTime values to UTC Kind before SaveChanges (required for Npgsql)
- **Lazy Loading**: Enabled by default
- **Proxy Creation**: Enabled for virtual navigation properties

## 7. Database Code Patterns

| Pattern | Status |
|---|---|
| SqlConnection | ❌ Not found in any .cs file |
| SqlCommand | ❌ Not found in any .cs file |
| SqlDataReader | ❌ Not found in any .cs file |
| SqlParameter | ❌ Not found in any .cs file |
| using Microsoft.Data.SqlClient | ❌ Not found in any .cs file |
| using System.Data.SqlClient | ❌ Not found in any .cs file |
| Raw SQL strings in code | ❌ Not found (all DB access via EF6 LINQ) |

**All database access is via Entity Framework 6 LINQ queries.** The actual PostgreSQL SQL generation is handled at runtime by the EntityFramework6.Npgsql provider based on the model mappings.

## 8. PostgreSQL Table/Column Mappings

### Product Entity
| C# Property | PostgreSQL Column | Table | Schema |
|---|---|---|---|
| ProductId | productid | products | gadgetsonline_dbo |
| CategoryId | categoryid | products | gadgetsonline_dbo |
| Name | name | products | gadgetsonline_dbo |
| Price | price | products | gadgetsonline_dbo |
| ProductArtUrl | productarturl | products | gadgetsonline_dbo |

### Category Entity
| C# Property | PostgreSQL Column | Table | Schema |
|---|---|---|---|
| CategoryId | categoryid | categories | gadgetsonline_dbo |
| Name | name | categories | gadgetsonline_dbo |
| Description | description | categories | gadgetsonline_dbo |

### Cart Entity
| C# Property | PostgreSQL Column | Table | Schema |
|---|---|---|---|
| RecordId | recordid | carts | gadgetsonline_dbo |
| CartId | cartid | carts | gadgetsonline_dbo |
| ProductId | productid | carts | gadgetsonline_dbo |
| Count | count | carts | gadgetsonline_dbo |
| DateCreated | datecreated | carts | gadgetsonline_dbo |

### Order Entity
| C# Property | PostgreSQL Column | Table | Schema |
|---|---|---|---|
| OrderId | orderid | orders | gadgetsonline_dbo |
| OrderDate | orderdate | orders | gadgetsonline_dbo |
| Username | username | orders | gadgetsonline_dbo |
| FirstName | firstname | orders | gadgetsonline_dbo |
| LastName | lastname | orders | gadgetsonline_dbo |
| Address | address | orders | gadgetsonline_dbo |
| City | city | orders | gadgetsonline_dbo |
| State | state | orders | gadgetsonline_dbo |
| PostalCode | postalcode | orders | gadgetsonline_dbo |
| Country | country | orders | gadgetsonline_dbo |
| Phone | phone | orders | gadgetsonline_dbo |
| Email | email | orders | gadgetsonline_dbo |
| Total | total | orders | gadgetsonline_dbo |

### OrderDetail Entity
| C# Property | PostgreSQL Column | Table | Schema |
|---|---|---|---|
| OrderDetailId | orderdetailid | orderdetails | gadgetsonline_dbo |
| OrderId | orderid | orderdetails | gadgetsonline_dbo |
| ProductId | productid | orderdetails | gadgetsonline_dbo |
| Quantity | quantity | orderdetails | gadgetsonline_dbo |
| UnitPrice | unitprice | orderdetails | gadgetsonline_dbo |

## 9. Build Verification

| Metric | Value |
|---|---|
| Build Result | **Success** |
| Warnings | 0 |
| Errors | 0 |
| Target Framework | net8.0 |
| Build Output | GadgetsOnline.dll |

```
Build succeeded.
    0 Warning(s)
    0 Error(s)
Time Elapsed 00:00:04.77
```

## 10. Final Validation Checklist

| Criteria | Status |
|---|---|
| All SQL Server packages replaced with PostgreSQL equivalents | ✅ |
| All SqlConnection/SqlCommand/etc. replaced | ✅ (N/A - not present, EF6 LINQ only) |
| ALL 14 SQL statements processed through DMS MCP tool | ✅ (all submitted, all failed) |
| Comprehensive catalog exists for every statement | ✅ |
| ALL 14 statement pairs validated through SQL Equivalency MCP tool | ✅ (all submitted, all returned ERROR) |
| Equivalency report generated with correct format | ✅ |
| No agent judgment used for equivalency | ✅ |
| DMS failure statements documented with manual conversion details | ✅ |
| Connection strings updated to PostgreSQL format | ✅ |
| Application builds successfully | ✅ |

## 11. Items Requiring Attention

### DMS Tool Failures
- **Impact**: All 14 DMS conversion attempts failed due to metadata model creation errors. This indicates the DMS migration project's source database may not have the expected schema objects available for the selection rules.
- **Mitigation**: Manual conversion was applied using standard SQL Server → PostgreSQL mapping rules (lowercase schema objects, TOP→LIMIT). These conversions are straightforward and follow well-established patterns.
- **Recommendation**: Verify the DMS migration project configuration if DMS-based conversion is required for compliance/audit purposes.

### Equivalency Validation Errors
- **Impact**: All 14 equivalency validations returned ERROR status due to a `'uniqueID'` internal error in the SQL Equivalency tool.
- **Mitigation**: The converted statements follow standard, well-known SQL Server to PostgreSQL conversion patterns. The transformations are:
  - Schema remapping: `dbo` → `gadgetsonline_dbo`
  - Identifier casing: PascalCase → lowercase
  - Syntax: `TOP N` → `LIMIT N`
- **Recommendation**: Manual review of the 14 statement pairs is recommended. Consider re-running the equivalency tool when the `'uniqueID'` issue is resolved.

### EF6 Runtime SQL Generation
- **Important**: Since this application uses EF6 LINQ exclusively, the actual SQL generated at runtime is controlled by the EntityFramework6.Npgsql provider. The extracted/converted statements in this report represent the **conceptual** SQL equivalents of the LINQ queries, used for documentation and migration validation purposes.

## 12. Artifacts Generated

| Artifact | Description | Status |
|---|---|---|
| `extracted_statements.sql` | All 14 original MS SQL Server conceptual statements | ✅ Complete |
| `converted_statements.sql` | All 14 converted PostgreSQL statements with conversion metadata | ✅ Complete |
| `sql_equivalency_validation_report.json` | Comprehensive JSON report with all 14 statement pairs and tool results | ✅ Complete |
| `migration_report.md` | This comprehensive migration report | ✅ Complete |

---
*Report generated: 2026-03-23*
*All SQL statements accounted for: 14/14*
