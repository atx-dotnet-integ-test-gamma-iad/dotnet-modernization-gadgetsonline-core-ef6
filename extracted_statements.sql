-- ============================================================================
-- EXTRACTED SQL STATEMENTS CATALOG
-- GadgetsOnline - SQL Server to PostgreSQL Migration
-- Generated: 2026-03-22
-- ============================================================================
-- 
-- SUMMARY: This application uses Entity Framework 6 (EF6) with LINQ queries
-- exclusively for all database operations. No raw SQL statements, inline SQL,
-- string-concatenation SQL, parameterized SQL, StringBuilder-constructed SQL,
-- FromSqlRaw, ExecuteSqlRaw, SqlQuery, ExecuteSqlCommand, SqlCommand,
-- SqlConnection, SqlDataReader, SqlParameter, or SqlTransaction usage was found
-- in any source file.
--
-- The Npgsql EF6 provider handles all SQL generation at runtime.
--
-- TOTAL RAW SQL STATEMENTS FOUND: 0
-- TOTAL FILES SCANNED: 40 (22 .cs, 13 .cshtml, 5 .config/.json)
-- ============================================================================

-- ============================================================================
-- FILES SCANNED (Exhaustive Scan Results)
-- ============================================================================

-- === Service Layer Files (6 files) ===
-- File: GadgetsOnline/Services/Inventory.cs
--   Status: SCANNED - No raw SQL found
--   Database Access Pattern: EF6 LINQ via DbSet<Product>, DbSet<Category>
--   Operations: .Take(), .Where(), .ToList(), .FirstOrDefault()
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Services/ShoppingCart.cs
--   Status: SCANNED - No raw SQL found
--   Database Access Pattern: EF6 LINQ via DbSet<Cart>, DbSet<OrderDetail>
--   Operations: .SingleOrDefault(), .Where(), .Sum(), .Single(), .Add(), .Remove(), .SaveChanges()
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Services/OrderProcessing.cs
--   Status: SCANNED - No raw SQL found
--   Database Access Pattern: EF6 LINQ via DbSet<Order>
--   Operations: .Add(), .SaveChanges()
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Services/IInventory.cs
--   Status: SCANNED - No raw SQL found
--   Type: Interface definition only
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Services/IShoppingCart.cs
--   Status: SCANNED - No raw SQL found
--   Type: Interface definition only
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Services/IOrderProcessing.cs
--   Status: SCANNED - No raw SQL found
--   Type: Interface definition only
--   SQL Constructs Found: NONE

-- === Controller Files (4 files) ===
-- File: GadgetsOnline/Controllers/HomeController.cs
--   Status: SCANNED - No raw SQL found
--   Database Access Pattern: Via IInventory service (LINQ)
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Controllers/StoreController.cs
--   Status: SCANNED - No raw SQL found
--   Database Access Pattern: Via IInventory, IShoppingCart services (LINQ)
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Controllers/ShoppingCartController.cs
--   Status: SCANNED - No raw SQL found
--   Database Access Pattern: Via IShoppingCart, IInventory services (LINQ)
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Controllers/CheckoutController.cs
--   Status: SCANNED - No raw SQL found
--   Database Access Pattern: Via IOrderProcessing service (LINQ)
--   SQL Constructs Found: NONE

-- === Model Files (7 files) ===
-- File: GadgetsOnline/Models/GadgetsOnlineEntities.cs
--   Status: SCANNED - No raw SQL found
--   Type: DbContext with Fluent API configuration (OnModelCreating)
--   PostgreSQL Config: GadgetsOnlineEntitiesPostgreSqlConfiguration (Npgsql provider)
--   Schema: gadgetsonline_dbo (lowercase table/column names)
--   Tables Mapped: categories, products, carts, orders, orderdetails
--   SQL Constructs Found: NONE (Fluent API table/column mappings are not SQL statements)

-- File: GadgetsOnline/Models/GadgetsOnlineInitializer.cs
--   Status: SCANNED - No raw SQL found
--   Type: Database seeder using EF6 DbSet.Add() and SaveChanges()
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Models/Cart.cs
--   Status: SCANNED - No raw SQL found
--   Type: Entity model with data annotations [Table("carts", Schema="gadgetsonline_dbo")]
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Models/Category.cs
--   Status: SCANNED - No raw SQL found
--   Type: Entity model with data annotations [Table("categories", Schema="gadgetsonline_dbo")]
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Models/Order.cs
--   Status: SCANNED - No raw SQL found
--   Type: Entity model with data annotations [Table("orders", Schema="gadgetsonline_dbo")]
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Models/OrderDetail.cs
--   Status: SCANNED - No raw SQL found
--   Type: Entity model with data annotations [Table("orderdetails", Schema="gadgetsonline_dbo")]
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Models/Product.cs
--   Status: SCANNED - No raw SQL found
--   Type: Entity model with data annotations [Table("products", Schema="gadgetsonline_dbo")]
--   SQL Constructs Found: NONE

-- === Component Files (1 file) ===
-- File: GadgetsOnline/Components/CategoryMenuViewComponent.cs
--   Status: SCANNED - No raw SQL found
--   Database Access Pattern: Via IInventory service (LINQ)
--   SQL Constructs Found: NONE

-- === ViewModel Files (2 files) ===
-- File: GadgetsOnline/ViewModel/ShoppingCartViewModel.cs
--   Status: SCANNED - No raw SQL found
--   Type: ViewModel (data transfer object)
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/ViewModel/ShoppingCartRemoveViewModel.cs
--   Status: SCANNED - No raw SQL found
--   Type: ViewModel (data transfer object)
--   SQL Constructs Found: NONE

-- === Application Configuration Files (2 .cs files) ===
-- File: GadgetsOnline/Program.cs
--   Status: SCANNED - No raw SQL found
--   Type: Application entry point (Host builder)
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Startup.cs
--   Status: SCANNED - No raw SQL found
--   Type: DI configuration, middleware pipeline
--   Database Config: Connection string via Configuration.GetConnectionString()
--   EF6 Initializer: Database.SetInitializer(new GadgetsOnlineInitializer())
--   SQL Constructs Found: NONE

-- === Configuration Files (5 files) ===
-- File: GadgetsOnline/appsettings.json
--   Status: SCANNED - No raw SQL found
--   Contains: PostgreSQL connection string (Host=..., Database=..., Username=..., Password=...)
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/app.config
--   Status: SCANNED - No raw SQL found
--   Contains: EF6 Npgsql provider configuration, DbProviderFactories for Npgsql
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Properties/launchSettings.json
--   Status: SCANNED - No raw SQL found
--   Type: IDE launch profile settings
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/Views/Web.config
--   Status: SCANNED - No raw SQL found
--   Type: Views configuration (Razor pages, namespace imports)
--   SQL Constructs Found: NONE

-- File: GadgetsOnline/libman.json
--   Status: SCANNED - No raw SQL found
--   Type: Client-side library manager configuration
--   SQL Constructs Found: NONE

-- === View Files (Razor .cshtml) (13 files) ===
-- File: GadgetsOnline/Views/Checkout/AddressAndPayment.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/Checkout/Complete.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/Home/About.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/Home/Contact.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/Home/Index.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/Shared/Components/CategoryMenu/Default.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/Shared/Error.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/Shared/_Layout.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/ShoppingCart/Index.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/Store/Browse.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/Store/CategoryMenu.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/Store/Details.cshtml
--   Status: SCANNED - No raw SQL found

-- File: GadgetsOnline/Views/_ViewStart.cshtml
--   Status: SCANNED - No raw SQL found

-- ============================================================================
-- POSTGRESQL MIGRATION STATE VERIFICATION
-- ============================================================================
-- The codebase has ALREADY been migrated to PostgreSQL. Verification:
--
-- 1. GadgetsOnline.csproj:
--    - NO Microsoft.Data.SqlClient or System.Data.SqlClient packages
--    - Npgsql 5.0.18 present
--    - EntityFramework6.Npgsql 6.4.3 present
--    - EntityFramework 6.5.1 present
--
-- 2. GadgetsOnlineEntities.cs:
--    - Uses 'using Npgsql;' import
--    - GadgetsOnlineEntitiesPostgreSqlConfiguration with NpgsqlServices.Instance
--    - NpgsqlConnectionFactory as default connection factory
--    - [DbConfigurationType] attribute set
--    - All entities mapped to 'gadgetsonline_dbo' schema with lowercase names
--
-- 3. app.config:
--    - Npgsql provider in entityFramework section
--    - NpgsqlConnectionFactory as default connection factory
--    - Npgsql in DbProviderFactories
--
-- 4. appsettings.json:
--    - PostgreSQL connection string: Host=...; Database=postgres; Username=...; Password=...
--
-- 5. Entity Models (Cart.cs, Category.cs, Order.cs, OrderDetail.cs, Product.cs):
--    - All have [Table(..., Schema = "gadgetsonline_dbo")] annotations
--    - All have [Column(...)] annotations with lowercase column names
--
-- ============================================================================
-- SEARCH PATTERNS USED
-- ============================================================================
-- 1. Inline SQL strings: SELECT, INSERT, UPDATE, DELETE, CREATE TABLE, ALTER TABLE,
--    DROP TABLE, EXEC, DECLARE, BEGIN TRANSACTION
-- 2. String concatenation SQL: "SELECT ... " + variable patterns
-- 3. StringBuilder SQL: StringBuilder with SQL keywords
-- 4. Parameterized SQL: @param patterns with SqlParameter/NpgsqlParameter
-- 5. EF Raw SQL methods: FromSqlRaw, ExecuteSqlRaw, SqlQuery, ExecuteSqlCommand,
--    Database.SqlQuery, Database.ExecuteSql
-- 6. ADO.NET classes: SqlCommand, SqlConnection, SqlDataReader, SqlParameter,
--    SqlTransaction, SqlDataAdapter
-- 7. SQL Server namespaces: System.Data.SqlClient, Microsoft.Data.SqlClient
--
-- CONCLUSION: Zero (0) raw SQL statements found across all 40 files scanned.
-- All database operations use EF6 LINQ queries. The Npgsql EF6 provider
-- generates appropriate PostgreSQL SQL at runtime.
-- ============================================================================
