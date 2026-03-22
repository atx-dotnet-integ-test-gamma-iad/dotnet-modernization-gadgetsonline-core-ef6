-- Converted SQL Statements for PostgreSQL - GadgetsOnline Application
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA (all 5 statements)
-- DMS Error (all statements): Metadata model creation failed: {'error': "Metadata model creation failed: {'default_error_details': {'message': 'No objects were found according to the specified selection rules. Please review your selection rules and try again.'}}"}
-- Manual conversion applied: dbo schema mapped to gadgetsonline_dbo, all table and column names converted to lowercase per transformation definition rules.

-- Statement 1: Products table
-- DMS Conversion Attempted: 2026-03-22T04:31:41 | Status: error | Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products;

-- Statement 2: Categories table
-- DMS Conversion Attempted: 2026-03-22T04:32:07 | Status: error | Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- Statement 3: Carts table
-- DMS Conversion Attempted: 2026-03-22T04:32:31 | Status: error | Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts;

-- Statement 4: Orders table
-- DMS Conversion Attempted: 2026-03-22T04:32:55 | Status: error | Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT orderid, orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total FROM gadgetsonline_dbo.orders;

-- Statement 5: OrderDetails table
-- DMS Conversion Attempted: 2026-03-22T04:33:18 | Status: error | Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
SELECT orderdetailid, orderid, productid, quantity, unitprice FROM gadgetsonline_dbo.orderdetails;
