| Parent Table | Child Table | Relationship             |
| ------------ | ----------- | ------------------------ |
| Customers    | Orders      | 1 : Many                 |
| Stores       | Orders      | 1 : Many                 |
| Promotions   | Orders      | 1 : Many                 |
| Orders       | Order Items | 1 : Many                 |
| Products     | Order Items | 1 : Many                 |
| Categories   | Products    | 1 : Many                 |
| Suppliers    | Products    | 1 : Many                 |
| Orders       | Payments    | 1 : 1 *(dataset design)* |
| Orders       | Shipments   | 1 : 1 *(dataset design)* |
| Order Items  | Returns     | 1 : Many                 |
