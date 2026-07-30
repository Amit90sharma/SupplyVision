# SupplyVision Data Dictionary

## Overview

This document describes every table used in the SupplyVision Retail Data Warehouse project.

---

## 1. Categories

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| category_id | Integer | Unique category identifier | Primary Key |
| category_name | String | Product category name | - |

Business Purpose:
Stores the master list of product categories.

---

## 2. Customers

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| customer_id | Integer | Unique customer identifier | Primary Key |
| city | String | Customer city | - |
| signup_date | Date | Customer registration date | - |

Business Purpose:
Stores customer master information.

---

## 3. Stores

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| store_id | Integer | Store identifier | Primary Key |
| city | String | Store location | - |

Business Purpose:
Stores retail store information.

---

## 4. Suppliers

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| supplier_id | Integer | Supplier identifier | Primary Key |
| country | String | Supplier country | - |

Business Purpose:
Stores supplier information.

---

## 5. Products

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| product_id | Integer | Product identifier | Primary Key |
| category_id | Integer | Product category | Foreign Key |
| supplier_id | Integer | Product supplier | Foreign Key |
| price | Integer | Product selling price | - |

Business Purpose:
Product catalog.

---

## 6. Promotions

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| promotion_id | Integer | Promotion identifier | Primary Key |
| discount | Integer | Discount percentage | - |

Business Purpose:
Stores promotional discounts.

---

## 7. Date Dimension (dim_date)

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| date | Date | Calendar date | - |
| date_key | Integer | Surrogate date key (YYYYMMDD) | Primary Key |
| day | Integer | Day of month | - |
| day_name | String | Day name (Monday, Tuesday, etc.) | - |
| day_of_year | Integer | Day number within the year | - |
| is_month_start | Boolean | Indicates first day of month | - |
| is_month_end | Boolean | Indicates last day of month | - |
| is_quarter_start | Boolean | Indicates first day of quarter | - |
| is_quarter_end | Boolean | Indicates last day of quarter | - |

**Business Purpose:**

Provides a reusable calendar dimension for time-based analytics, enabling reporting by day, month, quarter, and year while supporting efficient time intelligence in Power BI.

---

## 8. Orders

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| order_id | Integer | Order identifier | Primary Key |
| customer_id | Integer | Customer placing order | Foreign Key |
| store_id | Integer | Store handling order | Foreign Key |
| order_date | Date | Order date | - |
| promotion_id | Integer | Promotion applied | Foreign Key |

Business Purpose:
Stores customer orders.

---

## 9. Order Items

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| order_item_id | Integer | Order line identifier | Primary Key |
| order_id | Integer | Parent order | Foreign Key |
| product_id | Integer | Purchased product | Foreign Key |
| qty | Integer | Quantity ordered | - |
| price | Integer | Selling price | - |

Business Purpose:
Stores products purchased within each order.

---

## 10. Payments

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| payment_id | Integer | Payment identifier | Primary Key |
| order_id | Integer | Paid order | Foreign Key |
| amount | Integer | Payment amount | - |

Business Purpose:
Stores payment transactions.

---

## 11. Shipments

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| shipment_id | Integer | Shipment identifier | Primary Key |
| order_id | Integer | Shipped order | Foreign Key |
| status | String | Shipment status | - |

Business Purpose:
Tracks order delivery.

---

## 12. Returns

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| return_id | Integer | Return identifier | Primary Key |
| order_item_id | Integer | Returned order item | Foreign Key |
| refund | Integer | Refund amount | - |

Business Purpose:
Stores returned products.

---

## 13. Employees

| Column | Data Type | Description | Key |
|---------|-----------|-------------|-----|
| employee_id | Integer | Employee identifier | Primary Key |
| store_id | Integer | Assigned store | Foreign Key |
| salary | Integer | Employee salary | - |

Business Purpose:
Stores employee information.