| Parent Table | Child Table | Relationship                  |
| ------------ | ----------- | ----------------------------- |
| Customers    | Orders      | One-to-Many                   |
| Stores       | Orders      | One-to-Many                   |
| Promotions   | Orders      | One-to-Many                   |
| Dim_Date     | Orders      | One-to-Many                   |
| Orders       | Order Items | One-to-Many                   |
| Products     | Order Items | One-to-Many                   |
| Categories   | Products    | One-to-Many                   |
| Suppliers    | Products    | One-to-Many                   |
| Orders       | Payments    | One-to-One *(Dataset Design)* |
| Orders       | Shipments   | One-to-One *(Dataset Design)* |
| Order Items  | Returns     | One-to-Many                   |
| Stores       | Employees   | One-to-Many                   |

Relationship Notes
Customer places multiple orders.
Each order belongs to one store.
Orders can contain multiple products through the Order Items table.
Products belong to one category and one supplier.
Each order has one payment and one shipment in this synthetic dataset.
Returned products are tracked at the Order Item level.
Employees are assigned to stores.
The Date Dimension (dim_date) enables time-based analytics such as yearly, quarterly, monthly, and daily reporting.