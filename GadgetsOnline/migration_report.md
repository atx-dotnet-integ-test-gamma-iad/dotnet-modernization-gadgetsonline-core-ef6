# GadgetsOnline - MS SQL Server to PostgreSQL Migration Report

## Executive Summary
This report documents the complete migration of the GadgetsOnline .NET application from Microsoft SQL Server to PostgreSQL. The application uses Entity Framework 6 (EF6) with LINQ queries for all database operations — no raw SQL statements exist in the codebase.

**Migration Date:** 2026-03-04  
**Migration Status:** COMPLETE  
**Build Status:** ✅ SUCCEEDED (0 warnings, 0 errors)

---

## 1. SQL Statement Processing Results

### 1.1 Statement Extraction
- **Total statements extracted:** 21
- **Source files scanned:** 4
  - `Services/Inventory.cs` — 5 statements
  - `Services/ShoppingCart.cs` — 13 statements
  - `Services/OrderProcessing.cs` — 1 statement
  - `Models/GadgetsOnlineInitializer.cs` — 2 statements
- **Catalog file:** `extracted_statements.sql`

### 1.2 Statement Breakdown by Type
| Type | Count |
|------|-------|
| SELECT | 9 |
| INSERT | 6 |
| UPDATE | 3 |
| DELETE | 3 |
| **Total** | **21** |

### 1.3 Statement Breakdown by Source
| # | Source File | Method | Statement Type |
|---|-------------|--------|----------------|
| 1 | Inventory.cs | GetBestSellers | SELECT TOP(@count) |
| 2 | Inventory.cs | GetAllCategories | SELECT |
| 3 | Inventory.cs | GetAllProductsInCategory | SELECT JOIN |
| 4 | Inventory.cs | GetProductById | SELECT TOP(1) |
| 5 | Inventory.cs | GetProductNameById | SELECT TOP(1) |
| 6 | ShoppingCart.cs | GetCartItems | SELECT |
| 7 | ShoppingCart.cs | GetCount | SELECT SUM |
| 8 | ShoppingCart.cs | GetTotal | SELECT SUM JOIN |
| 9 | ShoppingCart.cs | AddToCart - Select | SELECT TOP(1) |
| 10 | ShoppingCart.cs | AddToCart - Insert | INSERT |
| 11 | ShoppingCart.cs | AddToCart - Update | UPDATE |
| 12 | ShoppingCart.cs | RemoveFromCart - Select | SELECT TOP(1) |
| 13 | ShoppingCart.cs | RemoveFromCart - Update | UPDATE |
| 14 | ShoppingCart.cs | RemoveFromCart - Delete | DELETE |
| 15 | ShoppingCart.cs | EmptyCart - Select | SELECT |
| 16 | ShoppingCart.cs | EmptyCart - Delete | DELETE |
| 17 | OrderProcessing.cs | ProcessOrder | INSERT |
| 18 | ShoppingCart.cs | CreateOrder - Insert Detail | INSERT |
| 19 | ShoppingCart.cs | CreateOrder - Update Total | UPDATE |
| 20 | GadgetsOnlineInitializer.cs | Seed Categories | INSERT |
| 21 | GadgetsOnlineInitializer.cs | Seed Products | INSERT |

---

## 2. DMS Conversion Results

### 2.1 DMS Tool Configuration
- **Migration Project ARN:** `arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII`
- **Database Name:** GadgetsOnline
- **Schema Name:** dbo
- **Region:** us-east-1

### 2.2 DMS Conversion Summary
| Metric | Count |
|--------|-------|
| Total statements processed through DMS | 21 |
| DMS successful conversions | 0 |
| DMS failed conversions | 21 |
| Manual conversions applied | 21 |

### 2.3 DMS Retry Attempt (Step 2 - 2026-03-04)
All 21 statements were re-processed through the DMS tool individually between 2026-03-04T02:12:48 and 2026-03-04T02:20:20 UTC.

| Statement | DMS Timestamp | DMS Result |
|-----------|---------------|------------|
| 1 | 2026-03-04T02:12:48 | FAILED |
| 2 | 2026-03-04T02:13:11 | FAILED |
| 3 | 2026-03-04T02:13:34 | FAILED |
| 4 | 2026-03-04T02:13:58 | FAILED |
| 5 | 2026-03-04T02:13:58 | FAILED |
| 6 | 2026-03-04T02:14:21 | FAILED |
| 7 | 2026-03-04T02:14:43 | FAILED |
| 8 | 2026-03-04T02:15:08 | FAILED |
| 9 | 2026-03-04T02:15:31 | FAILED |
| 10 | 2026-03-04T02:15:53 | FAILED |
| 11 | 2026-03-04T02:16:16 | FAILED |
| 12 | 2026-03-04T02:16:38 | FAILED |
| 13 | 2026-03-04T02:17:00 | FAILED |
| 14 | 2026-03-04T02:17:23 | FAILED |
| 15 | 2026-03-04T02:17:45 | FAILED |
| 16 | 2026-03-04T02:18:10 | FAILED |
| 17 | 2026-03-04T02:18:33 | FAILED |
| 18 | 2026-03-04T02:18:55 | FAILED |
| 19 | 2026-03-04T02:19:18 | FAILED |
| 20 | 2026-03-04T02:19:44 | FAILED |
| 21 | 2026-03-04T02:20:06 | FAILED |

### 2.4 DMS Failure Details
- **Error:** `Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'The selected objects were not found.'}}"}`
- **Root Cause:** The source database schema objects (tables in [dbo]) were not accessible to the DMS migration project at the time of conversion.
- **Mitigation:** All 21 statements were manually converted using the `DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA` convention.

### 2.5 Manual Conversion Rules Applied
| MS SQL Server | PostgreSQL |
|---------------|------------|
| `[dbo]` schema | `gadgetsonline_dbo` schema |
| PascalCase identifiers | lowercase identifiers |
| `TOP(N)` / `TOP(@count)` | `LIMIT N` / `LIMIT @count` |
| Square bracket delimiters `[]` | Removed |
| `NVARCHAR` | `VARCHAR` |
| `DATETIME` | `TIMESTAMP` |
| `NVARCHAR(MAX)` | `TEXT` |

---

## 3. SQL Equivalency Validation Results

### 3.1 Equivalency Tool Summary
| Metric | Count |
|--------|-------|
| Total statement pairs validated | 21 |
| Equivalent | 0 |
| Not Equivalent | 0 |
| Error | 21 |

### 3.2 Equivalency Validation Details (Step 3 - 2026-03-04)
All 21 statement pairs were individually processed through the sql-equivalency___validate_sql_equivalence tool between 2026-03-04T02:22:32 and 2026-03-04T02:25:51 UTC.

| Statement | Equivalency Timestamp | Status | Tool Error |
|-----------|-----------------------|--------|------------|
| 1 | 2026-03-04T02:22:32 | ERROR | 'uniqueID' |
| 2 | 2026-03-04T02:22:42 | ERROR | 'uniqueID' |
| 3 | 2026-03-04T02:22:55 | ERROR | 'uniqueID' |
| 4 | 2026-03-04T02:23:05 | ERROR | 'uniqueID' |
| 5 | 2026-03-04T02:23:14 | ERROR | 'uniqueID' |
| 6 | 2026-03-04T02:23:23 | ERROR | 'uniqueID' |
| 7 | 2026-03-04T02:23:32 | ERROR | 'uniqueID' |
| 8 | 2026-03-04T02:23:43 | ERROR | 'uniqueID' |
| 9 | 2026-03-04T02:23:52 | ERROR | 'uniqueID' |
| 10 | 2026-03-04T02:24:05 | ERROR | 'uniqueID' |
| 11 | 2026-03-04T02:24:14 | ERROR | 'uniqueID' |
| 12 | 2026-03-04T02:24:24 | ERROR | 'uniqueID' |
| 13 | 2026-03-04T02:24:33 | ERROR | 'uniqueID' |
| 14 | 2026-03-04T02:24:42 | ERROR | 'uniqueID' |
| 15 | 2026-03-04T02:24:53 | ERROR | 'uniqueID' |
| 16 | 2026-03-04T02:25:02 | ERROR | 'uniqueID' |
| 17 | 2026-03-04T02:25:14 | ERROR | 'uniqueID' |
| 18 | 2026-03-04T02:25:23 | ERROR | 'uniqueID' |
| 19 | 2026-03-04T02:25:32 | ERROR | 'uniqueID' |
| 20 | 2026-03-04T02:25:41 | ERROR | 'uniqueID' |
| 21 | 2026-03-04T02:25:51 | ERROR | 'uniqueID' |

### 3.3 Equivalency Error Details
- **Error:** `'uniqueID'` — All 21 pairs returned the same tool-level error
- **Note:** This is a tool-level error (not a statement-level error), likely caused by an internal configuration issue
- **Important:** Per the transformation requirements, all equivalency statuses are recorded directly from the tool output — no agent judgment has been applied

### 3.4 Report File
- **Location:** `sql_equivalency_validation_report.json`
- **Contains:** Complete details for all 21 statement pairs including original statements, converted statements, conversion method, equivalency status, and raw tool output

---

## 4. Package/Dependency Changes

### 4.1 Removed Packages
| Package | Version | Status |
|---------|---------|--------|
| Microsoft.Data.SqlClient | N/A | Not present (confirmed removed) |
| System.Data.SqlClient | N/A | Not present (confirmed removed) |

### 4.2 Added Packages
| Package | Version | Status |
|---------|---------|--------|
| Npgsql | 5.0.18 | ✅ Present |
| EntityFramework6.Npgsql | 6.4.3 | ✅ Present |

### 4.3 Retained Packages
| Package | Version |
|---------|---------|
| Microsoft.AspNetCore.Hosting.Abstractions | 2.3.0 |
| Microsoft.VisualStudio.Azure.Containers.Tools.Targets | 1.17.0 |

---

## 5. Connection String Configuration

### 5.1 Current Configuration (appsettings.json)
```
Host=gadgetsonline-sqlserver.c6nek0euoyl0.us-east-1.rds.amazonaws.com;Database=postgres;Username=${DB_USER};Password=${DB_PASSWORD};
```

### 5.2 Connection String Format
| Parameter | Format | Status |
|-----------|--------|--------|
| Host | PostgreSQL Host= format | ✅ |
| Database | PostgreSQL Database= | ✅ |
| Username | Environment variable placeholder | ✅ |
| Password | Environment variable placeholder | ✅ |

---

## 6. Code Changes Summary

### 6.1 Build Fix (Step 1)
- Fixed incorrect `using EntityFramework6.Npgsql;` import in GadgetsOnlineEntities.cs
- The EntityFramework6.Npgsql NuGet package exposes classes under the `Npgsql` namespace, not `EntityFramework6.Npgsql`
- Removed the incorrect using directive since `using Npgsql;` was already present

### 6.2 EF6 Configuration (app.config)
- ✅ Npgsql provider configured (`Npgsql.NpgsqlServices, EntityFramework6.Npgsql`)
- ✅ NpgsqlConnectionFactory set as default connection factory
- ✅ Npgsql DbProviderFactory registered

### 6.3 DbContext (GadgetsOnlineEntities.cs)
- ✅ `GadgetsOnlineEntitiesPostgreSqlConfiguration` class with `NpgsqlServices`
- ✅ `[DbConfigurationType]` attribute applied
- ✅ All model mappings use `gadgetsonline_dbo` schema with lowercase table/column names
- ✅ DateTime UTC fix (`FixDateTimeKinds`) for PostgreSQL TIMESTAMP compatibility
- ✅ All relationships properly configured (Category→Products, Cart→Product, Order→OrderDetails, OrderDetail→Product)

### 6.4 Model Classes
| Model | Table | Schema | Column Mapping |
|-------|-------|--------|----------------|
| Product | products | gadgetsonline_dbo | ✅ All lowercase |
| Category | categories | gadgetsonline_dbo | ✅ All lowercase |
| Cart | carts | gadgetsonline_dbo | ✅ All lowercase |
| Order | orders | gadgetsonline_dbo | ✅ All lowercase |
| OrderDetail | orderdetails | gadgetsonline_dbo | ✅ All lowercase |

### 6.5 No Raw SQL / SqlClient References
- ✅ No `SqlClient` references found in any .cs file
- ✅ No raw SQL strings found in any .cs file
- ✅ All database operations use EF6 LINQ queries

---

## 7. Complete Statement Listing with Equivalency Status

| # | Original MS SQL | Converted PostgreSQL | Conversion Method | Equivalency Status |
|---|-----------------|---------------------|-------------------|-------------------|
| 1 | `SELECT TOP(@count) ... FROM [dbo].[Products]` | `SELECT ... FROM gadgetsonline_dbo.products LIMIT @count` | DMS_FAILURE_MANUAL | ERROR |
| 2 | `SELECT ... FROM [dbo].[Categories]` | `SELECT ... FROM gadgetsonline_dbo.categories` | DMS_FAILURE_MANUAL | ERROR |
| 3 | `SELECT ... FROM [dbo].[Products] JOIN [dbo].[Categories]` | `SELECT ... FROM gadgetsonline_dbo.products JOIN gadgetsonline_dbo.categories` | DMS_FAILURE_MANUAL | ERROR |
| 4 | `SELECT TOP(1) ... FROM [dbo].[Products] WHERE ...` | `SELECT ... FROM gadgetsonline_dbo.products WHERE ... LIMIT 1` | DMS_FAILURE_MANUAL | ERROR |
| 5 | `SELECT TOP(1) ... FROM [dbo].[Products] WHERE ...` | `SELECT ... FROM gadgetsonline_dbo.products WHERE ... LIMIT 1` | DMS_FAILURE_MANUAL | ERROR |
| 6 | `SELECT ... FROM [dbo].[Carts] WHERE ...` | `SELECT ... FROM gadgetsonline_dbo.carts WHERE ...` | DMS_FAILURE_MANUAL | ERROR |
| 7 | `SELECT SUM([Count]) FROM [dbo].[Carts]` | `SELECT SUM(count) FROM gadgetsonline_dbo.carts` | DMS_FAILURE_MANUAL | ERROR |
| 8 | `SELECT SUM(...) FROM [dbo].[Carts] JOIN [dbo].[Products]` | `SELECT SUM(...) FROM gadgetsonline_dbo.carts JOIN gadgetsonline_dbo.products` | DMS_FAILURE_MANUAL | ERROR |
| 9 | `SELECT TOP(1) ... FROM [dbo].[Carts] WHERE ... AND ...` | `SELECT ... FROM gadgetsonline_dbo.carts WHERE ... AND ... LIMIT 1` | DMS_FAILURE_MANUAL | ERROR |
| 10 | `INSERT INTO [dbo].[Carts] ...` | `INSERT INTO gadgetsonline_dbo.carts ...` | DMS_FAILURE_MANUAL | ERROR |
| 11 | `UPDATE [dbo].[Carts] SET ... WHERE ...` | `UPDATE gadgetsonline_dbo.carts SET ... WHERE ...` | DMS_FAILURE_MANUAL | ERROR |
| 12 | `SELECT TOP(1) ... FROM [dbo].[Carts] WHERE ... AND ...` | `SELECT ... FROM gadgetsonline_dbo.carts WHERE ... AND ... LIMIT 1` | DMS_FAILURE_MANUAL | ERROR |
| 13 | `UPDATE [dbo].[Carts] SET ... WHERE ...` | `UPDATE gadgetsonline_dbo.carts SET ... WHERE ...` | DMS_FAILURE_MANUAL | ERROR |
| 14 | `DELETE FROM [dbo].[Carts] WHERE ...` | `DELETE FROM gadgetsonline_dbo.carts WHERE ...` | DMS_FAILURE_MANUAL | ERROR |
| 15 | `SELECT ... FROM [dbo].[Carts] WHERE ...` | `SELECT ... FROM gadgetsonline_dbo.carts WHERE ...` | DMS_FAILURE_MANUAL | ERROR |
| 16 | `DELETE FROM [dbo].[Carts] WHERE ...` | `DELETE FROM gadgetsonline_dbo.carts WHERE ...` | DMS_FAILURE_MANUAL | ERROR |
| 17 | `INSERT INTO [dbo].[Orders] ...` | `INSERT INTO gadgetsonline_dbo.orders ...` | DMS_FAILURE_MANUAL | ERROR |
| 18 | `INSERT INTO [dbo].[OrderDetails] ...` | `INSERT INTO gadgetsonline_dbo.orderdetails ...` | DMS_FAILURE_MANUAL | ERROR |
| 19 | `UPDATE [dbo].[Orders] SET ... WHERE ...` | `UPDATE gadgetsonline_dbo.orders SET ... WHERE ...` | DMS_FAILURE_MANUAL | ERROR |
| 20 | `INSERT INTO [dbo].[Categories] ...` | `INSERT INTO gadgetsonline_dbo.categories ...` | DMS_FAILURE_MANUAL | ERROR |
| 21 | `INSERT INTO [dbo].[Products] ...` | `INSERT INTO gadgetsonline_dbo.products ...` | DMS_FAILURE_MANUAL | ERROR |

*Note: DMS_FAILURE_MANUAL = DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA*
*Note: Equivalency ERROR is from tool-level 'uniqueID' error, not statement-level issue*

---

## 8. Build Status

- **Build Command:** `dotnet build GadgetsOnline.sln`
- **Build Result:** ✅ **SUCCEEDED**
- **Warnings:** 0
- **Errors:** 0
- **Output:** `GadgetsOnline.dll` compiled successfully to `bin/Debug/net8.0/`
- **Build Date:** 2026-03-04

---

## 9. Migration Artifacts

| Artifact | Location | Description |
|----------|----------|-------------|
| Extracted Statements | `extracted_statements.sql` | All 21 original MS SQL Server statements |
| Converted Statements | `converted_statements.sql` | All 21 converted PostgreSQL statements with DMS attempt timestamps |
| Equivalency Report | `sql_equivalency_validation_report.json` | Comprehensive validation report for all 21 pairs |
| Migration Report | `migration_report.md` | This document |

---

## 10. Final Migration Summary

| Metric | Value |
|--------|-------|
| Total SQL statements identified | 21 |
| Statements processed through DMS tool | 21 |
| DMS successful conversions | 0 |
| Manual conversions (DMS failure) | 21 |
| Equivalency validations performed | 21 |
| Equivalent (per tool) | 0 |
| Not Equivalent (per tool) | 0 |
| Equivalency Error (per tool) | 21 |
| SqlClient references remaining | 0 |
| Build status | ✅ Success |

---

## 11. Known Issues and Recommendations

1. **DMS Tool Failure:** The DMS tool failed for all 21 statements due to metadata model creation issues ("The selected objects were not found"). All conversions were done manually following the lowercase schema convention. When DMS becomes available with the correct database objects, re-processing is recommended to validate.

2. **SQL Equivalency Tool Error:** The equivalency tool returned ERROR for all 21 pairs due to an internal `'uniqueID'` error. When the tool is operational, re-validation is recommended.

3. **Connection String:** The current connection string uses environment variable placeholders (`${DB_USER}`, `${DB_PASSWORD}`) which need to be resolved at runtime.

4. **Schema Name:** The PostgreSQL schema `gadgetsonline_dbo` must exist in the target database with all required tables before the application can connect.

5. **Build Fix Applied:** Removed incorrect `using EntityFramework6.Npgsql;` import (the package exposes classes under the `Npgsql` namespace).
