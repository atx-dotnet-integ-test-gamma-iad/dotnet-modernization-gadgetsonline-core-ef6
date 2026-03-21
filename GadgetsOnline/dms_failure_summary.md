# DMS Conversion Failure Summary
# Date: 2026-03-21
# Migration Project ARN: arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII

## Summary
All 19 SQL statements were submitted to the DMS MCP statement_conversion_tool.
All 19 failed DMS conversion with the same metadata model creation error.
Manual conversion was applied using lowercase schema object names (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA).

## DMS Error (same for all 19 statements)
```
Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'No objects were found according to the specified selection rules. Please review your selection rules and try again.'}}"}
```

## DMS Parameters Used
- database_name: GadgetsOnline
- migration_project_identifier: arn:aws:dms:us-east-1:812756961751:migration-project:D2EE2K7HIVGZNMUDN2HU6AMQII
- schema_name: dbo
- server_name: gadgetsonline-sqlserver.c6nek0euoyl0.us-east-1.rds.amazonaws.com
- region: us-east-1

## DMS Call Log (All 19 Statements)

| # | Statement | DMS Timestamp | Status |
|---|-----------|--------------|--------|
| 1 | GetBestSellers - SELECT TOP(5) | 2026-03-21T12:52:19 | FAILED |
| 2 | GetAllCategories - SELECT | 2026-03-21T12:52:54 | FAILED |
| 3 | GetAllProductsInCategory - SELECT JOIN | 2026-03-21T12:53:17 | FAILED |
| 4 | GetProductById - SELECT WHERE | 2026-03-21T12:53:41 | FAILED |
| 5 | GetProductNameById - SELECT WHERE | 2026-03-21T12:54:04 | FAILED |
| 6 | GetCartItems - SELECT WHERE | 2026-03-21T12:54:29 | FAILED |
| 7 | GetCount - SELECT SUM | 2026-03-21T12:54:51 | FAILED |
| 8 | GetTotal - SELECT SUM JOIN | 2026-03-21T12:55:13 | FAILED |
| 9 | AddToCart SELECT | 2026-03-21T12:55:35 | FAILED |
| 10 | AddToCart INSERT | 2026-03-21T12:55:58 | FAILED |
| 11 | AddToCart UPDATE | 2026-03-21T12:56:20 | FAILED |
| 12 | RemoveFromCart SELECT | 2026-03-21T12:55:35 | FAILED |
| 13 | RemoveFromCart DELETE | 2026-03-21T12:56:48 | FAILED |
| 14 | RemoveFromCart UPDATE | 2026-03-21T12:57:16 | FAILED |
| 15 | EmptyCart DELETE | 2026-03-21T12:57:37 | FAILED |
| 16 | CreateOrder INSERT OrderDetail | 2026-03-21T12:58:01 | FAILED |
| 17 | ProcessOrder INSERT Order | 2026-03-21T12:58:23 | FAILED |
| 18 | Seed INSERT Category | 2026-03-21T12:58:45 | FAILED |
| 19 | Seed INSERT Product | 2026-03-21T12:59:09 | FAILED |

## Root Cause Analysis
The DMS migration project metadata model could not find any objects matching the 'dbo' schema
selection rules. This may indicate that:
1. The source database objects have already been migrated/removed from the source SQL Server
2. The DMS migration project selection rules do not match the actual database schema
3. Network connectivity issues preventing DMS from accessing the source database

## Manual Conversion Rules Applied (DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA)
1. Schema mapping: dbo.* -> gadgetsonline_dbo.* (lowercase)
2. Column names: PascalCase -> lowercase (e.g., ProductId -> productid)
3. Table names: PascalCase -> lowercase (e.g., Products -> products)
4. SQL Server TOP(n) -> PostgreSQL LIMIT n
5. Parameter syntax: @param -> :param (for documentation; EF6 handles parameter binding)
6. Data types: NVARCHAR -> VARCHAR, DATETIME -> TIMESTAMP, IDENTITY -> SERIAL

## Statements and Manual Conversions

### Statement 1: GetBestSellers (Inventory.cs)
- Original: `SELECT TOP(5) ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products;`
- Converted: `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT 5;`

### Statement 2: GetAllCategories (Inventory.cs)
- Original: `SELECT CategoryId, Name, Description FROM dbo.Categories;`
- Converted: `SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;`

### Statement 3: GetAllProductsInCategory (Inventory.cs)
- Original: `SELECT p.ProductId, p.CategoryId, p.Name, p.Price, p.ProductArtUrl FROM dbo.Products p INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId WHERE c.Name = @category;`
- Converted: `SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = :category;`

### Statement 4: GetProductById (Inventory.cs)
- Original: `SELECT ProductId, CategoryId, Name, Price, ProductArtUrl FROM dbo.Products WHERE ProductId = @id;`
- Converted: `SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = :id;`

### Statement 5: GetProductNameById (Inventory.cs)
- Original: `SELECT Name FROM dbo.Products WHERE ProductId = @id;`
- Converted: `SELECT name FROM gadgetsonline_dbo.products WHERE productid = :id;`

### Statement 6: GetCartItems (ShoppingCart.cs)
- Original: `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId;`
- Converted: `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = :cartId;`

### Statement 7: GetCount (ShoppingCart.cs)
- Original: `SELECT SUM(Count) FROM dbo.Carts WHERE CartId = @cartId;`
- Converted: `SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = :cartId;`

### Statement 8: GetTotal (ShoppingCart.cs)
- Original: `SELECT SUM(c.Count * p.Price) FROM dbo.Carts c INNER JOIN dbo.Products p ON c.ProductId = p.ProductId WHERE c.CartId = @cartId;`
- Converted: `SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = :cartId;`

### Statement 9: AddToCart - SELECT (ShoppingCart.cs)
- Original: `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;`
- Converted: `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = :cartId AND productid = :productId;`

### Statement 10: AddToCart - INSERT (ShoppingCart.cs)
- Original: `INSERT INTO dbo.Carts (CartId, ProductId, Count, DateCreated) VALUES (@cartId, @productId, 1, @dateCreated);`
- Converted: `INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (:cartId, :productId, 1, :dateCreated);`

### Statement 11: AddToCart - UPDATE (ShoppingCart.cs)
- Original: `UPDATE dbo.Carts SET Count = Count + 1 WHERE CartId = @cartId AND ProductId = @productId;`
- Converted: `UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE cartid = :cartId AND productid = :productId;`

### Statement 12: RemoveFromCart - SELECT (ShoppingCart.cs)
- Original: `SELECT RecordId, CartId, ProductId, Count, DateCreated FROM dbo.Carts WHERE CartId = @cartId AND ProductId = @productId;`
- Converted: `SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = :cartId AND productid = :productId;`

### Statement 13: RemoveFromCart - DELETE (ShoppingCart.cs)
- Original: `DELETE FROM dbo.Carts WHERE RecordId = @recordId;`
- Converted: `DELETE FROM gadgetsonline_dbo.carts WHERE recordid = :recordId;`

### Statement 14: RemoveFromCart - UPDATE (ShoppingCart.cs)
- Original: `UPDATE dbo.Carts SET Count = Count - 1 WHERE RecordId = @recordId;`
- Converted: `UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE recordid = :recordId;`

### Statement 15: EmptyCart (ShoppingCart.cs)
- Original: `DELETE FROM dbo.Carts WHERE CartId = @cartId;`
- Converted: `DELETE FROM gadgetsonline_dbo.carts WHERE cartid = :cartId;`

### Statement 16: CreateOrder - INSERT OrderDetail (ShoppingCart.cs)
- Original: `INSERT INTO dbo.OrderDetails (ProductId, OrderId, UnitPrice, Quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);`
- Converted: `INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (:productId, :orderId, :unitPrice, :quantity);`

### Statement 17: ProcessOrder - INSERT Order (OrderProcessing.cs)
- Original: `INSERT INTO dbo.Orders (OrderDate, Username, FirstName, LastName, Address, City, State, PostalCode, Country, Phone, Email, Total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);`
- Converted: `INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (:orderDate, :username, :firstName, :lastName, :address, :city, :state, :postalCode, :country, :phone, :email, :total);`

### Statement 18: Seed - INSERT Category (GadgetsOnlineInitializer.cs)
- Original: `INSERT INTO dbo.Categories (CategoryId, Name, Description) VALUES (@categoryId, @name, @description);`
- Converted: `INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (:categoryId, :name, :description);`

### Statement 19: Seed - INSERT Product (GadgetsOnlineInitializer.cs)
- Original: `INSERT INTO dbo.Products (ProductId, CategoryId, Name, Price, ProductArtUrl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);`
- Converted: `INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (:productId, :categoryId, :name, :price, :productArtUrl);`
