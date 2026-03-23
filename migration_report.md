# GadgetsOnline Migration Report
## Microsoft SQL Server to PostgreSQL - .NET ADO/EF6 Application

**Date:** 2026-03-23
**Application:** GadgetsOnline
**Framework:** .NET 8.0 with Entity Framework 6 (LINQ-to-Entities)
**Source Database:** Microsoft SQL Server 2019
**Target Database:** PostgreSQL 13
**DMS Migration Project:** `arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII`

---

## 1. SQL Statement Processing Summary

| Metric | Value |
|--------|-------|
| **Total SQL Statements Processed** | 19 |
| **Source Files Analyzed** | 3 |
| **SELECT Statements** | 10 |
| **INSERT Statements** | 3 |
| **UPDATE Statements** | 4 |
| **DELETE Statements** | 2 |

### Breakdown by Source File

| Source File | Statements | Types |
|-------------|-----------|-------|
| `Inventory.cs` | 5 | 5 SELECT |
| `ShoppingCart.cs` | 13 | 5 SELECT, 2 INSERT, 4 UPDATE, 2 DELETE |
| `OrderProcessing.cs` | 1 | 1 INSERT |

### Statement Extraction Method
The application uses Entity Framework 6 LINQ-to-Entities exclusively (no raw/inline SQL). SQL statements were derived from LINQ query analysis of the EF6 DbContext operations. Each LINQ expression was translated to its equivalent SQL Server T-SQL representation for DMS conversion processing.

---

## 2. DMS Conversion Summary

| Metric | Value |
|--------|-------|
| **Statements Sent to DMS** | 19 |
| **Successfully Converted by DMS** | 0 |
| **DMS Conversion Failures** | 19 |
| **Manually Converted (after DMS failure)** | 19 |

### DMS Attempt Details
All 19 statements were sent to the DMS MCP tool on 2026-03-23 (timestamps T09:11:20 through T09:17:01).
All 19 failed with the same systemic error:
```
Metadata model creation failed: {'error': "Metadata model creation failed:
{'default_error_details': {'message': 'No objects were found according to the
specified selection rules. Please review your selection rules and try again.'}}"}
```

This error indicates a DMS migration project configuration issue where the source database schema metadata could not be loaded. This is a systemic failure, not a per-statement issue.

### Manual Conversion Approach
Since DMS failed for all statements, manual conversion was applied using the method `DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA` with the following rules:
- **Schema mapping:** `dbo` → `gadgetsonline_dbo`
- **Identifier case:** All table names, column names, and aliases converted to lowercase
- **SQL syntax:** `TOP N` → `LIMIT N` (moved to end of statement)
- **Bracket notation:** `[dbo].[TableName]` → `gadgetsonline_dbo.tablename`
- **Column references:** `[Extent1].[ColumnName]` → `"Extent1".columnname`

---

## 3. SQL Equivalency Validation Summary

| Metric | Value |
|--------|-------|
| **Statements Validated** | 19 |
| **EQUIVALENT** | 0 |
| **NOT_EQUIVALENT** | 0 |
| **ERROR** | 19 |

### Equivalency Tool Attempt Details
All 19 statement pairs were sent to the `sql-equivalency___validate_sql_equivalence` tool on 2026-03-23 (timestamps T09:20:08 through T09:21:29).
All 19 returned ERROR:
```json
{"equivalence_status": "ERROR", "error": "'uniqueID'"}
```

This is a systemic tool-side issue (not related to the statement conversions). The error `'uniqueID'` suggests an internal tool configuration problem.

**CRITICAL NOTE:** Per the transformation definition, no agent judgment was used to determine equivalency. All equivalency statuses are recorded exactly as returned by the tool. The ERROR status does not indicate the conversions are incorrect - it indicates the tool was unable to evaluate them.

---

## 4. Schema Mapping Details

### Schema Mapping
| Source (SQL Server) | Target (PostgreSQL) |
|---------------------|---------------------|
| `dbo` | `gadgetsonline_dbo` |

### Table Name Mappings
| Source Table | Target Table |
|-------------|-------------|
| `dbo.Products` | `gadgetsonline_dbo.products` |
| `dbo.Categories` | `gadgetsonline_dbo.categories` |
| `dbo.Carts` | `gadgetsonline_dbo.carts` |
| `dbo.Orders` | `gadgetsonline_dbo.orders` |
| `dbo.OrderDetails` | `gadgetsonline_dbo.orderdetails` |

### Column Name Mappings (Products)
| Source Column | Target Column |
|--------------|--------------|
| `ProductId` | `productid` |
| `CategoryId` | `categoryid` |
| `Name` | `name` |
| `Price` | `price` |
| `ProductArtUrl` | `productarturl` |

### Column Name Mappings (Categories)
| Source Column | Target Column |
|--------------|--------------|
| `CategoryId` | `categoryid` |
| `Name` | `name` |
| `Description` | `description` |

### Column Name Mappings (Carts)
| Source Column | Target Column |
|--------------|--------------|
| `RecordId` | `recordid` |
| `CartId` | `cartid` |
| `ProductId` | `productid` |
| `Count` | `count` |
| `DateCreated` | `datecreated` |

### Column Name Mappings (Orders)
| Source Column | Target Column |
|--------------|--------------|
| `OrderId` | `orderid` |
| `OrderDate` | `orderdate` |
| `Username` | `username` |
| `FirstName` | `firstname` |
| `LastName` | `lastname` |
| `Address` | `address` |
| `City` | `city` |
| `State` | `state` |
| `PostalCode` | `postalcode` |
| `Country` | `country` |
| `Phone` | `phone` |
| `Email` | `email` |
| `Total` | `total` |

### Column Name Mappings (OrderDetails)
| Source Column | Target Column |
|--------------|--------------|
| `OrderDetailId` | `orderdetailid` |
| `OrderId` | `orderid` |
| `ProductId` | `productid` |
| `Quantity` | `quantity` |
| `UnitPrice` | `unitprice` |

### Data Type Mappings
| SQL Server Type | PostgreSQL Type |
|----------------|----------------|
| `INT IDENTITY` | `SERIAL` |
| `INT` | `INT` |
| `NVARCHAR(n)` | `VARCHAR(n)` |
| `NVARCHAR(MAX)` | `TEXT` |
| `DECIMAL(18,2)` | `DECIMAL(18,2)` |
| `DATETIME` | `TIMESTAMP` |

---

## 5. Package Dependency Status

### Current Package References (GadgetsOnline.csproj)
| Package | Version | Status |
|---------|---------|--------|
| `EntityFramework6.Npgsql` | 6.4.3 | ✅ Present |
| `EntityFramework` | 6.5.1 | ✅ Present |
| `Npgsql` | 5.0.18 | ✅ Present |
| `Microsoft.AspNetCore.Hosting.Abstractions` | 2.3.0 | ✅ Present |
| `Microsoft.VisualStudio.Azure.Containers.Tools.Targets` | 1.17.0 | ✅ Present |

### Removed SQL Server Packages
| Package | Status |
|---------|--------|
| `Microsoft.Data.SqlClient` | ✅ Not present (no direct reference) |
| `System.Data.SqlClient` | ✅ Not present (no direct reference) |

### Transitive Dependencies
| Package | Version | Source | Status |
|---------|---------|--------|--------|
| `System.Data.SqlClient` | 4.8.6 | Transitive via EntityFramework 6.5.1 | ⚠️ Unavoidable - EF6 has a built-in dependency on System.Data.SqlClient for SQL Server support. This is a framework-level dependency that cannot be excluded without breaking EF6 itself. The application code does NOT reference System.Data.SqlClient directly - all database access is through the Npgsql provider. |
| `runtime.native.System.Data.SqlClient.sni` | 4.7.0 | Transitive via System.Data.SqlClient | ⚠️ Same as above |

---

## 6. Configuration Verification

### Connection String (appsettings.json)
```json
{
  "ConnectionStrings": {
    "GadgetsOnlineEntities": "Host=gadgetsonline-sqlserver.c6nek0euoyl0.us-east-1.rds.amazonaws.com;Database=virtual-server-gadgetsonline-sqlserver;Username=${DB_USER};Password=${DB_PASSWORD};"
  }
}
```
- ✅ Uses `Host=` (PostgreSQL format)
- ✅ Uses `Database=` parameter
- ✅ Uses `Username=` and `Password=` (PostgreSQL format)
- ✅ No SQL Server specific parameters (e.g., `Integrated Security`)

### Entity Framework Configuration (app.config)
- ✅ Provider: `Npgsql.NpgsqlServices, EntityFramework6.Npgsql`
- ✅ Default Connection Factory: `Npgsql.NpgsqlConnectionFactory, EntityFramework6.Npgsql`
- ✅ DbProviderFactory: `Npgsql.NpgsqlFactory, Npgsql`

### DbContext Configuration (GadgetsOnlineEntities.cs)
- ✅ `GadgetsOnlineEntitiesPostgreSqlConfiguration` class uses `NpgsqlServices.Instance`
- ✅ `NpgsqlConnectionFactory` set as default
- ✅ `[DbConfigurationType(typeof(GadgetsOnlineEntitiesPostgreSqlConfiguration))]` attribute
- ✅ `OnModelCreating` maps all entities to `gadgetsonline_dbo` schema with lowercase names
- ✅ `FixDateTimeKinds()` ensures UTC conversion for PostgreSQL `TIMESTAMP` compatibility

---

## 7. ADO.NET Class Verification

| Class | Status |
|-------|--------|
| `SqlConnection` | ✅ Not found in codebase |
| `SqlCommand` | ✅ Not found in codebase |
| `SqlDataReader` | ✅ Not found in codebase |
| `SqlParameter` | ✅ Not found in codebase |
| `SqlTransaction` | ✅ Not found in codebase |
| `Microsoft.Data.SqlClient` | ✅ Not found in codebase |
| `System.Data.SqlClient` | ✅ Not found in codebase |

**Note:** This application uses EF6 LINQ-to-Entities exclusively and does not use raw ADO.NET classes directly. The EF6 provider handles all database connectivity through Npgsql.

---

## 8. Build Verification

```
Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:06.92
```

- ✅ Build succeeds with 0 errors and 0 warnings
- ✅ Output: `GadgetsOnline.dll` generated in `bin/Debug/net8.0/`

---

## 9. Detailed Statement Conversion Log

| # | Source File | Method | Type | DMS Status | DMS Timestamp | Equivalency | Equiv Timestamp |
|---|-----------|--------|------|------------|---------------|-------------|-----------------|
| 1 | Inventory.cs | GetBestSellers | SELECT | ❌ FAILED | T09:11:20 | ERROR | T09:20:08 |
| 2 | Inventory.cs | GetAllCategories | SELECT | ❌ FAILED | T09:11:35 | ERROR | T09:20:09 |
| 3 | Inventory.cs | GetAllProductsInCategory | SELECT | ❌ FAILED | T09:11:51 | ERROR | T09:20:10 |
| 4 | Inventory.cs | GetProductById | SELECT | ❌ FAILED | T09:12:06 | ERROR | T09:20:11 |
| 5 | Inventory.cs | GetProductNameById | SELECT | ❌ FAILED | T09:12:21 | ERROR | T09:20:12 |
| 6 | ShoppingCart.cs | CreateOrder (Insert OrderDetail) | INSERT | ❌ FAILED | T09:12:55 | ERROR | T09:20:35 |
| 7 | ShoppingCart.cs | CreateOrder (Update Total) | UPDATE | ❌ FAILED | T09:13:10 | ERROR | T09:20:36 |
| 8 | ShoppingCart.cs | EmptyCart (Select) | SELECT | ❌ FAILED | T09:13:26 | ERROR | T09:20:37 |
| 9 | ShoppingCart.cs | EmptyCart (Delete) | DELETE | ❌ FAILED | T09:13:41 | ERROR | T09:20:38 |
| 10 | ShoppingCart.cs | AddToCart (Find) | SELECT | ❌ FAILED | T09:13:56 | ERROR | T09:20:39 |
| 11 | ShoppingCart.cs | AddToCart (Insert) | INSERT | ❌ FAILED | T09:14:27 | ERROR | T09:20:59 |
| 12 | ShoppingCart.cs | AddToCart (Update) | UPDATE | ❌ FAILED | T09:14:43 | ERROR | T09:21:00 |
| 13 | ShoppingCart.cs | GetCount | SELECT | ❌ FAILED | T09:14:58 | ERROR | T09:21:01 |
| 14 | ShoppingCart.cs | RemoveFromCart (Find) | SELECT | ❌ FAILED | T09:15:13 | ERROR | T09:21:02 |
| 15 | ShoppingCart.cs | RemoveFromCart (Decrement) | UPDATE | ❌ FAILED | T09:15:29 | ERROR | T09:21:03 |
| 16 | ShoppingCart.cs | RemoveFromCart (Delete) | DELETE | ❌ FAILED | T09:16:00 | ERROR | T09:21:26 |
| 17 | ShoppingCart.cs | GetCartItems | SELECT | ❌ FAILED | T09:16:15 | ERROR | T09:21:27 |
| 18 | ShoppingCart.cs | GetTotal | SELECT | ❌ FAILED | T09:16:31 | ERROR | T09:21:28 |
| 19 | OrderProcessing.cs | ProcessOrder (Insert) | INSERT | ❌ FAILED | T09:16:46 | ERROR | T09:21:29 |

**All 19 statements:**
- Sent to DMS MCP tool → All failed with metadata model creation error
- Manually converted with `DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA`
- Validated through SQL Equivalency tool → All returned ERROR (tool-side 'uniqueID' issue)

---

## 10. Model Class Verification

### Product.cs
- ✅ `[Table("products", Schema = "gadgetsonline_dbo")]`
- ✅ All columns mapped with `[Column("lowercase_name")]` attributes

### Category.cs
- ✅ `[Table("categories", Schema = "gadgetsonline_dbo")]`
- ✅ All columns mapped with `[Column("lowercase_name")]` attributes

### Cart.cs
- ✅ `[Table("carts", Schema = "gadgetsonline_dbo")]`
- ✅ All columns mapped with `[Column("lowercase_name")]` attributes

### Order.cs
- ✅ `[Table("orders", Schema = "gadgetsonline_dbo")]`
- ✅ All columns mapped with `[Column("lowercase_name")]` attributes

### OrderDetail.cs
- ✅ `[Table("orderdetails", Schema = "gadgetsonline_dbo")]`
- ✅ All columns mapped with `[Column("lowercase_name")]` attributes

### GadgetsOnlineEntities.cs OnModelCreating
- ✅ All 5 entities have `ToTable("tablename", "gadgetsonline_dbo")` configuration
- ✅ All column name mappings use lowercase via `HasColumnName("lowercase_name")`

---

## 11. Known Issues and Recommendations

### Known Issues

1. **DMS Tool Unavailable:** The DMS migration project metadata model could not be created, preventing automated SQL conversion. All 19 statements required manual conversion. The DMS project ARN is valid but the source database metadata appears to be inaccessible.

2. **SQL Equivalency Tool Error:** The SQL Equivalency validation tool returned a systemic error (`'uniqueID'`) for all 19 statement pairs. This prevented automated validation of conversion correctness. Manual review of the conversions is recommended.

3. **System.Data.SqlClient Transitive Dependency:** EntityFramework 6.5.1 brings in System.Data.SqlClient 4.8.6 as a transitive dependency. This cannot be excluded without breaking EF6. The application code does NOT use System.Data.SqlClient directly - all database access is through Npgsql.

4. **EF6 LINQ-to-Entities:** Since the application uses EF6 exclusively (no raw SQL), the actual SQL generated at runtime is controlled by the EF6 Npgsql provider. The extracted statements represent the *logical* SQL that EF6 would generate. The EF6 Npgsql provider will generate PostgreSQL-compatible SQL automatically based on the entity model mappings.

### Recommendations

1. **Manual SQL Review:** Given that both DMS and SQL Equivalency tools encountered errors, a manual review of the 19 converted statements is recommended to verify correctness.

2. **Integration Testing:** Run the application against a PostgreSQL 13 database to verify all EF6 LINQ queries execute correctly.

3. **Connection String Verification:** Verify the PostgreSQL connection string parameters match the target database configuration.

4. **DMS Project Investigation:** Investigate the DMS migration project to ensure source database connectivity and selection rules are configured correctly for future use.

---

## Artifacts Generated

| Artifact | Location | Description |
|----------|----------|-------------|
| `extracted_statements.sql` | `sourceCode/` | 19 original MS SQL Server statements with DMS attempt timestamps |
| `converted_statements.sql` | `sourceCode/` | 19 converted PostgreSQL statements with DMS attempt timestamps |
| `sql_equivalency_validation_report.json` | `sourceCode/` | Comprehensive validation report with 19 entries and equivalency tool results |
| `migration_report.md` | `sourceCode/` | This report |
| `build.log` | `sourceCode/` | Build output confirming 0 errors, 0 warnings |
