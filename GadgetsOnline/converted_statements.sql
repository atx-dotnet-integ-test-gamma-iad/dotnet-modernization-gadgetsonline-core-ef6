-- =====================================================
-- Converted PostgreSQL Statements (from MS SQL Server)
-- Source Application: GadgetsOnline
-- Conversion Date: 2026-03-04 (DMS re-attempted, all 20 statements failed again)
-- Conversion Method: DMS_FAILURE_MANUAL_CONVERSION_WITH_LOWERCASE_SCHEMA
-- DMS Failure Reason: Metadata model creation failed - The selected objects were not found
-- Target Schema: gadgetsonline_dbo
-- Total Statements: 20
-- =====================================================

-- =====================================================
-- Source: Services/Inventory.cs - GetBestSellers(count)
-- Statement 1: SELECT products with LIMIT (converted from TOP)
-- =====================================================
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products LIMIT @count;

-- =====================================================
-- Source: Services/Inventory.cs - GetAllCategories()
-- Statement 2: SELECT all categories
-- =====================================================
SELECT categoryid, name, description FROM gadgetsonline_dbo.categories;

-- =====================================================
-- Source: Services/Inventory.cs - GetAllProductsInCategory(category)
-- Statement 3: SELECT products with JOIN on category name
-- =====================================================
SELECT p.productid, p.categoryid, p.name, p.price, p.productarturl FROM gadgetsonline_dbo.products p INNER JOIN gadgetsonline_dbo.categories c ON p.categoryid = c.categoryid WHERE c.name = @category;

-- =====================================================
-- Source: Services/Inventory.cs - GetProductById(id)
-- Statement 4: SELECT single product by ID with LIMIT (converted from TOP)
-- =====================================================
SELECT productid, categoryid, name, price, productarturl FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- =====================================================
-- Source: Services/Inventory.cs - GetProductNameById(id)
-- Statement 5: SELECT product name by ID with LIMIT (converted from TOP)
-- =====================================================
SELECT name FROM gadgetsonline_dbo.products WHERE productid = @id LIMIT 1;

-- =====================================================
-- Source: Services/ShoppingCart.cs - GetCartItems()
-- Statement 6: SELECT cart items by cart ID
-- =====================================================
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- =====================================================
-- Source: Services/ShoppingCart.cs - GetTotal()
-- Statement 7: SELECT cart total with JOIN
-- =====================================================
SELECT SUM(c.count * p.price) FROM gadgetsonline_dbo.carts c INNER JOIN gadgetsonline_dbo.products p ON c.productid = p.productid WHERE c.cartid = @cartId;

-- =====================================================
-- Source: Services/ShoppingCart.cs - GetCount()
-- Statement 8: SELECT cart item count
-- =====================================================
SELECT SUM(count) FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- =====================================================
-- Source: Services/ShoppingCart.cs - AddToCart(id) - SELECT existing
-- Statement 9: SELECT single cart item with LIMIT (converted from TOP)
-- =====================================================
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @id LIMIT 1;

-- =====================================================
-- Source: Services/ShoppingCart.cs - AddToCart(id) - INSERT new
-- Statement 10: INSERT new cart item
-- =====================================================
INSERT INTO gadgetsonline_dbo.carts (cartid, productid, count, datecreated) VALUES (@cartId, @productId, 1, @dateCreated);

-- =====================================================
-- Source: Services/ShoppingCart.cs - AddToCart(id) - UPDATE existing
-- Statement 11: UPDATE cart item count (increment)
-- =====================================================
UPDATE gadgetsonline_dbo.carts SET count = count + 1 WHERE cartid = @cartId AND productid = @id;

-- =====================================================
-- Source: Services/ShoppingCart.cs - RemoveFromCart(id) - SELECT
-- Statement 12: SELECT cart item for removal with LIMIT (converted from TOP)
-- =====================================================
SELECT recordid, cartid, productid, count, datecreated FROM gadgetsonline_dbo.carts WHERE cartid = @cartId AND productid = @id LIMIT 1;

-- =====================================================
-- Source: Services/ShoppingCart.cs - RemoveFromCart(id) - UPDATE
-- Statement 13: UPDATE cart item count (decrement)
-- =====================================================
UPDATE gadgetsonline_dbo.carts SET count = count - 1 WHERE cartid = @cartId AND productid = @id;

-- =====================================================
-- Source: Services/ShoppingCart.cs - RemoveFromCart(id) - DELETE
-- Statement 14: DELETE single cart item by recordid
-- =====================================================
DELETE FROM gadgetsonline_dbo.carts WHERE recordid = @recordId;

-- =====================================================
-- Source: Services/ShoppingCart.cs - EmptyCart()
-- Statement 15: DELETE all cart items by cartid
-- =====================================================
DELETE FROM gadgetsonline_dbo.carts WHERE cartid = @cartId;

-- =====================================================
-- Source: Services/ShoppingCart.cs - CreateOrder() - INSERT OrderDetail
-- Statement 16: INSERT order detail
-- =====================================================
INSERT INTO gadgetsonline_dbo.orderdetails (productid, orderid, unitprice, quantity) VALUES (@productId, @orderId, @unitPrice, @quantity);

-- =====================================================
-- Source: Services/ShoppingCart.cs - CreateOrder() - UPDATE Order total
-- Statement 17: UPDATE order total
-- =====================================================
UPDATE gadgetsonline_dbo.orders SET total = @total WHERE orderid = @orderId;

-- =====================================================
-- Source: Services/OrderProcessing.cs - ProcessOrder()
-- Statement 18: INSERT new order
-- =====================================================
INSERT INTO gadgetsonline_dbo.orders (orderdate, username, firstname, lastname, address, city, state, postalcode, country, phone, email, total) VALUES (@orderDate, @username, @firstName, @lastName, @address, @city, @state, @postalCode, @country, @phone, @email, @total);

-- =====================================================
-- Source: Models/GadgetsOnlineInitializer.cs - Seed() categories
-- Statement 19: INSERT category seed data
-- =====================================================
INSERT INTO gadgetsonline_dbo.categories (categoryid, name, description) VALUES (@categoryId, @name, @description);

-- =====================================================
-- Source: Models/GadgetsOnlineInitializer.cs - Seed() products
-- Statement 20: INSERT product seed data
-- =====================================================
INSERT INTO gadgetsonline_dbo.products (productid, categoryid, name, price, productarturl) VALUES (@productId, @categoryId, @name, @price, @productArtUrl);
