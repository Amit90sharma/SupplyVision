USE supplyvision;

/*==============================================================
ADVANCED QUERY 1
TOP 10 CUSTOMERS BY REVENUE
---------------------------------------------------------------
Purpose:
Identify the customers who generated the highest revenue.

Business Value:
• Identifies high-value customers
• Supports customer segmentation
• Helps design loyalty programs
==============================================================*/

SELECT
    c.customer_id,
    c.city,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    SUM(oi.qty) AS Total_Items_Purchased,
    ROUND(SUM(oi.qty * oi.price), 2) AS Total_Revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.city
ORDER BY Total_Revenue DESC
LIMIT 10;

/*==============================================================
ADVANCED QUERY 2
TOP 10 PRODUCTS BY REVENUE
---------------------------------------------------------------
Purpose:
Identify the products generating the highest revenue.

Business Value:
• Identifies best-performing products
• Helps inventory optimization
• Supports pricing decisions
==============================================================*/

SELECT
    oi.product_id,
    p.category_id,
    p.supplier_id,
    SUM(oi.qty) AS Units_Sold,
    ROUND(SUM(oi.qty * oi.price),2) AS Total_Revenue,
    ROUND(AVG(oi.price),2) AS Average_Selling_Price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    oi.product_id,
    p.category_id,
    p.supplier_id
ORDER BY Total_Revenue DESC
LIMIT 10;

/*==============================================================
ADVANCED QUERY 3
STORE REVENUE RANKING
---------------------------------------------------------------
Purpose:
Rank stores based on total revenue generated.

Business Value:
• Identify top-performing stores
• Compare store performance
• Support management decisions
==============================================================*/

SELECT
    s.store_id,
    s.city,
    ROUND(SUM(oi.qty * oi.price),2) AS Total_Revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(oi.qty * oi.price) DESC
    ) AS Revenue_Rank
FROM stores s
JOIN orders o
    ON s.store_id = o.store_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    s.store_id,
    s.city
ORDER BY
    Revenue_Rank;

/*==============================================================
ADVANCED QUERY 4
MONTHLY REVENUE WITH RUNNING TOTAL
---------------------------------------------------------------
Purpose:
Calculate monthly revenue and cumulative revenue over time.

Business Value:
• Monitor business growth
• Identify seasonal trends
• Track cumulative sales performance
==============================================================*/

WITH MonthlyRevenue AS
(
    SELECT
        o.order_year,
        o.order_month,
        o.order_month_name,
        ROUND(
            SUM(oi.qty * oi.price),
        2) AS Monthly_Revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        o.order_year,
        o.order_month,
        o.order_month_name
)
SELECT
    order_year,
    order_month,
    order_month_name,
    Monthly_Revenue,
    ROUND(
        SUM(Monthly_Revenue)
        OVER(
            ORDER BY
                order_year,
                order_month
        ),
    2) AS Running_Total_Revenue
FROM MonthlyRevenue
ORDER BY
    order_year,
    order_month;
    
   /*==============================================================
ADVANCED QUERY 5
REVENUE CONTRIBUTION (%) BY STORE
---------------------------------------------------------------
Purpose:
Calculate each store's contribution to total company revenue.

Business Value:
• Identify high-performing stores
• Compare store contribution
• Support regional business planning
==============================================================*/

SELECT
    s.store_id,
    s.city,
    ROUND(
        SUM(oi.qty * oi.price),
    2) AS Store_Revenue,
    ROUND(
        SUM(oi.qty * oi.price)
        /
        SUM(SUM(oi.qty * oi.price)) OVER ()
        * 100,
    2) AS Revenue_Percentage
FROM stores s
JOIN orders o
    ON s.store_id = o.store_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    s.store_id,
    s.city
ORDER BY
    Store_Revenue DESC; 
    
/*==============================================================
ADVANCED QUERY 6
CUSTOMER LIFETIME VALUE (CLV)
---------------------------------------------------------------
Purpose:
Calculate the lifetime value of each customer based on
their total spending and purchasing activity.

Business Value:
• Identify high-value customers
• Support customer segmentation
• Improve retention strategies
==============================================================*/

SELECT
    c.customer_id,
    c.city,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    SUM(oi.qty) AS Total_Items_Purchased,
    ROUND(
        SUM(oi.qty * oi.price),
    2) AS Lifetime_Revenue,
    ROUND(
        SUM(oi.qty * oi.price) /
        COUNT(DISTINCT o.order_id),
    2) AS Average_Order_Value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.city
ORDER BY
    Lifetime_Revenue DESC
LIMIT 20;
    
/*==============================================================
ADVANCED QUERY 7
CATEGORY PERFORMANCE ANALYSIS
---------------------------------------------------------------
Purpose:
Analyze the revenue generated by each product category.

Business Value:
• Identify best-performing categories
• Improve inventory allocation
• Support category-level business decisions
==============================================================*/

SELECT
    c.category_id,
    COUNT(DISTINCT p.product_id) AS Total_Products,
    SUM(oi.qty) AS Units_Sold,
    ROUND(
        SUM(oi.qty * oi.price),
    2) AS Total_Revenue,
    ROUND(
        AVG(oi.price),
    2) AS Average_Selling_Price
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id
ORDER BY
    Total_Revenue DESC;
    
/*==============================================================
ADVANCED QUERY 8
SUPPLIER PERFORMANCE ANALYSIS
---------------------------------------------------------------
Purpose:
Evaluate supplier performance based on revenue generated,
products supplied, and units sold.

Business Value:
• Identify high-performing suppliers
• Support supplier negotiations
• Improve procurement decisions
==============================================================*/

SELECT
    s.supplier_id,
    COUNT(DISTINCT p.product_id) AS Products_Supplied,
    SUM(oi.qty) AS Units_Sold,
    ROUND(
        SUM(oi.qty * oi.price),
    2) AS Total_Revenue,
    ROUND(
        AVG(p.price),
    2) AS Average_Product_Price,
    RANK() OVER(
        ORDER BY SUM(oi.qty * oi.price) DESC
    ) AS Supplier_Rank
FROM suppliers s
JOIN products p
    ON s.supplier_id = p.supplier_id
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    s.supplier_id
ORDER BY
    Total_Revenue DESC;
    
/*==============================================================
ADVANCED QUERY 9
PROMOTION EFFECTIVENESS ANALYSIS
---------------------------------------------------------------
Purpose:
Evaluate the performance of each promotion based on
orders, revenue, and average order value.

Business Value:
• Measure promotion effectiveness
• Identify high-performing campaigns
• Support future marketing decisions
==============================================================*/

SELECT
    p.promotion_id,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    SUM(oi.qty) AS Total_Items_Sold,
    ROUND(
        SUM(oi.qty * oi.price),
    2) AS Total_Revenue,
    ROUND(
        SUM(oi.qty * oi.price)
        /
        COUNT(DISTINCT o.order_id),
    2) AS Average_Order_Value
FROM promotions p
JOIN orders o
    ON p.promotion_id = o.promotion_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    p.promotion_id
ORDER BY
    Total_Revenue DESC;
    
/*==============================================================
ADVANCED QUERY 10
RETURN ANALYSIS & REFUND IMPACT
---------------------------------------------------------------
Purpose:
Analyze product returns and the financial impact of refunds.

Business Value:
• Measure return volume
• Calculate refund costs
• Identify revenue loss due to returns
• Support quality improvement initiatives
==============================================================*/

SELECT
    COUNT(DISTINCT r.return_id) AS Total_Returns,
    COUNT(DISTINCT r.order_item_id) AS Returned_Order_Items,
    ROUND(
        SUM(r.refund),
    2) AS Total_Refund_Amount,
    ROUND(
        AVG(r.refund),
    2) AS Average_Refund,
    ROUND(
        MAX(r.refund),
    2) AS Highest_Refund,
    ROUND(
        MIN(r.refund),
    2) AS Lowest_Refund
FROM returns r;

/*==============================================================
ADVANCED QUERY 11
RETURN RATE
---------------------------------------------------------------
Purpose:
Calculate the percentage of sold order items that were returned.

Business Value:
• Measure product return rate
• Monitor customer satisfaction
• Evaluate product quality
==============================================================*/

SELECT
    COUNT(DISTINCT r.order_item_id) AS Returned_Items,
    COUNT(DISTINCT oi.order_item_id) AS Total_Items,
    ROUND(
        COUNT(DISTINCT r.order_item_id)
        * 100.0
        /
        COUNT(DISTINCT oi.order_item_id),
    2) AS Return_Rate_Percentage
FROM order_items oi
LEFT JOIN returns r
    ON oi.order_item_id = r.order_item_id;
   
/*==============================================================
ADVANCED QUERY 12
TOP 5 STORES BY REVENUE IN EACH QUARTER
---------------------------------------------------------------
Purpose:
Rank stores within each quarter based on total revenue.

Business Value:
• Identify the best-performing stores each quarter
• Compare quarterly performance
• Support regional and seasonal sales analysis
==============================================================*/

WITH StoreQuarterRevenue AS
(
    SELECT
        o.order_year,
        o.order_quarter,
        o.store_id,
        ROUND(
            SUM(oi.qty * oi.price),
        2) AS Total_Revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        o.order_year,
        o.order_quarter,
        o.store_id
)

SELECT
    order_year,
    order_quarter,
    store_id,
    Total_Revenue,
    DENSE_RANK() OVER
    (
        PARTITION BY order_year, order_quarter
        ORDER BY Total_Revenue DESC
    ) AS Store_Rank
FROM StoreQuarterRevenue
ORDER BY
    order_year,
    order_quarter,
    Store_Rank;

/*==============================================================
ADVANCED QUERY 13
TOP 5 STORES IN EACH QUARTER
==============================================================*/

WITH StoreQuarterRevenue AS
(
    SELECT
        o.order_year,
        o.order_quarter,
        o.store_id,
        ROUND(
            SUM(oi.qty * oi.price),
        2) AS Total_Revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        o.order_year,
        o.order_quarter,
        o.store_id
),
RankedStores AS
(
    SELECT
        *,
        DENSE_RANK() OVER
        (
            PARTITION BY order_year, order_quarter
            ORDER BY Total_Revenue DESC
        ) AS Store_Rank
    FROM StoreQuarterRevenue
)

SELECT *
FROM RankedStores
WHERE Store_Rank <= 5
ORDER BY
    order_year,
    order_quarter,
    Store_Rank;
    
/*==============================================================
ADVANCED QUERY 14
MONTH-OVER-MONTH REVENUE GROWTH
---------------------------------------------------------------
Purpose:
Compare each month's revenue with the previous month.

Business Value:
• Measure business growth
• Identify declining sales months
• Track month-over-month performance
==============================================================*/

WITH MonthlyRevenue AS
(
    SELECT
        o.order_year,
        o.order_month,
        o.order_month_name,
        ROUND(
            SUM(oi.qty * oi.price),
        2) AS Monthly_Revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        o.order_year,
        o.order_month,
        o.order_month_name
)

SELECT
    order_year,
    order_month,
    order_month_name,
    Monthly_Revenue,
    LAG(Monthly_Revenue)
    OVER(
        ORDER BY
            order_year,
            order_month
    ) AS Previous_Month_Revenue,
    ROUND(
        Monthly_Revenue -
        LAG(Monthly_Revenue)
        OVER(
            ORDER BY
                order_year,
                order_month
        ),
    2) AS Revenue_Growth
FROM MonthlyRevenue
ORDER BY
    order_year,
    order_month;
    
/*==============================================================
ADVANCED QUERY 15
MONTH-OVER-MONTH REVENUE GROWTH PERCENTAGE
---------------------------------------------------------------
Purpose:
Calculate the percentage increase or decrease in revenue
compared to the previous month.

Business Value:
• Measure monthly business growth
• Identify strong and weak sales periods
• Support executive performance reporting
==============================================================*/

WITH MonthlyRevenue AS
(
    SELECT
        o.order_year,
        o.order_month,
        o.order_month_name,
        ROUND(
            SUM(oi.qty * oi.price),
        2) AS Monthly_Revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        o.order_year,
        o.order_month,
        o.order_month_name
),
RevenueComparison AS
(
    SELECT
        order_year,
        order_month,
        order_month_name,
        Monthly_Revenue,
        LAG(Monthly_Revenue)
        OVER(
            ORDER BY
                order_year,
                order_month
        ) AS Previous_Month_Revenue
    FROM MonthlyRevenue
)
SELECT
    order_year,
    order_month,
    order_month_name,
    Monthly_Revenue,
    Previous_Month_Revenue,
    ROUND(
        (
            (Monthly_Revenue - Previous_Month_Revenue)
            / Previous_Month_Revenue
        ) * 100,
    2) AS Growth_Percentage
FROM RevenueComparison
ORDER BY
    order_year,
    order_month;
    
/*==============================================================
ADVANCED QUERY 16
CUSTOMER PURCHASE FREQUENCY ANALYSIS
---------------------------------------------------------------
Purpose:
Analyze customer purchasing behavior based on
order frequency and spending.

Business Value:
• Identify loyal customers
• Detect one-time buyers
• Support customer segmentation
• Improve retention strategies
==============================================================*/

SELECT
    c.customer_id,
    c.city,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    SUM(oi.qty) AS Total_Items,
    ROUND(
        SUM(oi.qty * oi.price),
    2) AS Total_Revenue,
    ROUND(
        SUM(oi.qty * oi.price)
        /
        COUNT(DISTINCT o.order_id),
    2) AS Average_Order_Value,
    CASE
        WHEN COUNT(DISTINCT o.order_id) >= 15
            THEN 'High Frequency'
        WHEN COUNT(DISTINCT o.order_id) BETWEEN 8 AND 14
            THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS Customer_Segment
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.city
ORDER BY
    Total_Orders DESC,
    Total_Revenue DESC;
    
/*==============================================================
ADVANCED QUERY 17
PARETO ANALYSIS (80/20 RULE)
---------------------------------------------------------------
Purpose:
Identify the products contributing the highest percentage
of total revenue using cumulative revenue analysis.

Business Value:
• Identify high-value products
• Focus inventory investment
• Optimize promotions
• Improve product portfolio decisions
==============================================================*/

WITH ProductRevenue AS
(
    SELECT
        oi.product_id,
        ROUND(
            SUM(oi.qty * oi.price),
        2) AS Revenue
    FROM order_items oi
    GROUP BY
        oi.product_id
),
RevenueRanking AS
(
    SELECT
        product_id,
        Revenue,
        SUM(Revenue)
        OVER(
            ORDER BY Revenue DESC
        ) AS Cumulative_Revenue,
        SUM(Revenue)
        OVER() AS Total_Revenue
    FROM ProductRevenue
)
SELECT
    product_id,
    Revenue,
    Cumulative_Revenue,
    ROUND(
        (Cumulative_Revenue / Total_Revenue) * 100,
    2) AS Cumulative_Percentage,
    CASE
        WHEN
            (Cumulative_Revenue / Total_Revenue) <= 0.80
        THEN 'Top 80% Revenue'
        ELSE 'Remaining Products'
    END AS Revenue_Category
FROM RevenueRanking
ORDER BY Revenue DESC;

/*==============================================================
ADVANCED QUERY 18
RETURN RATE BY PRODUCT
==============================================================*/

SELECT
    oi.product_id,
    COUNT(DISTINCT oi.order_item_id) AS Items_Sold,
    COUNT(r.return_id) AS Returned_Items,
    ROUND(
        COUNT(r.return_id) * 100.0 /
        COUNT(DISTINCT oi.order_item_id),
    2) AS Return_Rate_Percentage
FROM order_items oi
LEFT JOIN returns r
ON oi.order_item_id = r.order_item_id
GROUP BY
    oi.product_id
ORDER BY
    Return_Rate_Percentage DESC,
    Returned_Items DESC;
    

/*==============================================================
ADVANCED QUERY 19
SUPPLIER REVENUE CONTRIBUTION
==============================================================*/

SELECT
    p.supplier_id,
    COUNT(DISTINCT p.product_id) AS Total_Products,
    ROUND(
        SUM(oi.qty * oi.price),
    2) AS Revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY
    p.supplier_id
ORDER BY Revenue DESC;

/*==============================================================
ADVANCED QUERY 20
AVERAGE BASKET SIZE
==============================================================*/

SELECT
    ROUND(
        AVG(Order_Items),
    2) AS Average_Items_Per_Order
FROM
(
    SELECT
        order_id,
        SUM(qty) AS Order_Items
    FROM order_items
    GROUP BY order_id
) Basket;

/*==============================================================
ADVANCED QUERY 21
STORE PERFORMANCE DASHBOARD
==============================================================*/

SELECT
    s.store_id,
    s.city,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    COUNT(DISTINCT o.customer_id) AS Unique_Customers,
    SUM(oi.qty) AS Units_Sold,
    ROUND(
        SUM(oi.qty * oi.price),
    2) AS Revenue,
    ROUND(
        AVG(oi.price),
    2) AS Average_Product_Price
FROM stores s
JOIN orders o
ON s.store_id = o.store_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY
    s.store_id,
    s.city
ORDER BY Revenue DESC;