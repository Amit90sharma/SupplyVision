/*=========================================================
 SupplyVision
 Database Validation Script

 Purpose:
 1. Verify all tables exist
 2. Validate row counts
 3. Validate primary key uniqueness
 4. Validate foreign key integrity

 Author: Amit Sharma
=========================================================*/

USE supplyvision;

SHOW TABLES;

SELECT COUNT(*) AS categories FROM categories;
SELECT COUNT(*) AS customers FROM customers;
SELECT COUNT(*) AS employees FROM employees;
SELECT COUNT(*) AS stores FROM stores;
SELECT COUNT(*) AS suppliers FROM suppliers;
SELECT COUNT(*) AS products FROM products;
SELECT COUNT(*) AS promotions FROM promotions;
SELECT COUNT(*) AS dim_date FROM dim_date;
SELECT COUNT(*) AS orders FROM orders;
SELECT COUNT(*) AS order_items FROM order_items;
SELECT COUNT(*) AS payments FROM payments;
SELECT COUNT(*) AS shipments FROM shipments;
SELECT COUNT(*) AS returns_table FROM returns;

-- ======================================
-- Primary Key Validation
-- ======================================

SELECT COUNT(*) total_rows,
COUNT(DISTINCT customer_id) unique_customers
FROM customers;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT category_id) unique_category
FROM categories;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT product_id) unique_products
FROM products;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT store_id) unique_store
FROM stores;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT supplier_id) unique_supplier
FROM suppliers;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT employee_id) unique_employees
FROM employees;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT promotion_id) unique_promotions
FROM promotions;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT order_id) unique_orders
FROM orders;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT payment_id) unique_paymentid
FROM payments;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT shipment_id) unique_shipment
FROM shipments;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT return_id) unique_returns
FROM returns;

SELECT COUNT(*) total_rows,
COUNT(DISTINCT date_key) unique_dates
FROM dim_date;

-- ======================================
-- Foreign Key Validation
-- ======================================

SELECT
'Orders -> Customers' AS Relationship,
COUNT(*) AS Invalid_Records
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT
'Orders -> Stores' AS Relationship,
COUNT(*) AS Invalid_Records
FROM orders o
LEFT JOIN stores s
ON o.store_id = s.store_id
WHERE s.store_id IS NULL;

SELECT
'Order Items -> Orders' AS Relationship,
COUNT(*) AS Invalid_Records
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT
'Order Items -> Products' AS Relationship,
COUNT(*) AS Invalid_Records
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT
'Products -> Categories' AS Relationship,
COUNT(*) AS Invalid_Records
FROM products p
LEFT JOIN categories c
ON p.category_id = c.category_id
WHERE c.category_id IS NULL;

SELECT
'Products -> Suppliers' AS Relationship,
COUNT(*) AS Invalid_Records
FROM products p
LEFT JOIN suppliers s
ON p.supplier_id = s.supplier_id
WHERE s.supplier_id IS NULL;

SELECT
'Payments -> Orders' AS Relationship,
COUNT(*) AS Invalid_Records
FROM payments p
LEFT JOIN orders o
ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT
'Validation Complete' AS Status,
'All validation queries executed successfully.' AS Message;
