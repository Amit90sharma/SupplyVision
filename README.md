# 📦 SupplyVision
### End-to-End Retail Data Warehouse & Business Intelligence Solution

![Python](https://img.shields.io/badge/Python-3.12-blue?logo=python)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?logo=mysql)
![Power%20BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Processing-150458?logo=pandas)
![SQL](https://img.shields.io/badge/SQL-Analytics-blue)
![Status](https://img.shields.io/badge/Project-Completed-brightgreen)

---

## 📖 Overview

SupplyVision is an end-to-end Retail Data Warehouse and Business Intelligence project that demonstrates how raw transactional retail data can be transformed into meaningful business insights.

The project combines Python-based ETL, Data Quality Validation, MySQL relational modeling, advanced SQL analytics, and interactive Power BI dashboards to support business decision-making.

Instead of analyzing a single flat dataset, SupplyVision models an enterprise retail environment using multiple relational tables representing customers, products, suppliers, stores, orders, shipments, returns, and payments.

---

## 🎯 Business Problem

Retail organizations generate millions of transactional records across multiple business functions.

Without a centralized analytics platform, decision-makers face challenges in:

- Tracking sales performance
- Monitoring customer purchasing behavior
- Managing inventory efficiently
- Evaluating supplier performance
- Measuring product returns
- Monitoring store performance
- Producing executive reports

SupplyVision addresses these challenges by creating a centralized data warehouse and interactive reporting solution.

---

## 🚀 Project Objectives

- Build a Retail Data Warehouse using MySQL
- Develop a complete ETL pipeline using Python
- Validate data quality before loading
- Design a relational database schema
- Perform advanced SQL business analytics
- Build an interactive Power BI dashboard
- Generate business recommendations using analytical insights

---

## 🛠 Technology Stack

| Category | Tools |
|----------|-------|
| Programming | Python |
| Data Processing | Pandas |
| Database | MySQL |
| Query Language | SQL |
| Visualization | Power BI |
| Documentation | Markdown |
| Data Modeling | Draw.io |

---

## 📊 Dataset Overview

The project uses a retail analytics dataset consisting of **13 relational tables**.

| Table | Records |
|---------|---------:|
| Customers | 50,000 |
| Orders | 300,000 |
| Order Items | 600,000 |
| Products | 10,000 |
| Categories | 30 |
| Suppliers | 200 |
| Stores | 100 |
| Employees | 1,000 |
| Payments | 300,000 |
| Shipments | 300,000 |
| Returns | 30,000 |
| Promotions | 50 |
| Date Dimension | Calendar Table |

---

## 🏗 Project Architecture

```
CSV Files
     │
     ▼
Python ETL Pipeline
     │
     ▼
Data Cleaning
     │
     ▼
Data Quality Validation
     │
     ▼
MySQL Data Warehouse
     │
     ▼
Advanced SQL Analytics
     │
     ▼
Power BI Dashboard
     │
     ▼
Business Decision Center
```


---

## 🔄 ETL Pipeline

The ETL pipeline consists of three stages:

### Extract

- Imported 13 CSV datasets
- Loaded data using Pandas

### Transform

- Cleaned missing values
- Standardized data types
- Created Date Dimension
- Validated primary and foreign keys
- Generated business-ready tables

### Load

- Loaded transformed data into MySQL
- Created relational warehouse
- Established foreign-key relationships

---

## ✅ Data Quality Framework

SupplyVision includes a structured Data Quality Framework to ensure reliable analytics.

Validation checks include:

- Completeness
- Uniqueness
- Primary Key Validation
- Foreign Key Validation
- Referential Integrity
- Data Type Validation
- Consistency Checks

Results:

- ✅ No duplicate primary keys
- ✅ Referential integrity maintained
- ✅ High data completeness
- ✅ Valid relational model

---

## 🗄 Data Warehouse Design

The warehouse consists of 13 normalized tables connected through primary and foreign keys.

Main entities include:

- Customers
- Orders
- Order Items
- Products
- Categories
- Suppliers
- Stores
- Employees
- Payments
- Shipments
- Returns
- Promotions
- Date Dimension

*(ER Diagram available in `docs\ER_Diagram_SupplyVision_v1.0.png.jpg`.)*

---

## 📈 SQL Analytics

Implemented **21 advanced SQL business queries**, including:

- Customer Lifetime Value (CLV)
- Store Revenue Ranking
- Category Performance Analysis
- Supplier Performance Analysis
- Promotion Effectiveness
- Return Analysis
- Revenue Contribution
- Monthly Revenue Growth
- Pareto Analysis (80/20 Rule)
- Basket Size Analysis
- Store Performance Dashboard Queries

---

## 📊 Power BI Dashboard

The interactive dashboard provides executive-level insights into retail performance.

### Key Performance Indicators

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value

### Dashboard Visualizations

- Revenue by Category
- Revenue by Supplier Country
- Revenue by Month
- Customer Distribution
- Shipment Status
- Return Analysis

The dashboard supports interactive filtering by:

- Year
- Quarter
- Month

*(Dashboard screenshot available in `images\PowerBI Dashboard.png`.)*

---

## 💼 Business Decision Center

Based on analytical findings, SupplyVision provides business recommendations such as:

- Improve customer retention through loyalty programs
- Reduce product return rates
- Optimize inventory allocation
- Strengthen supplier relationships
- Improve store-level performance
- Monitor promotion effectiveness
- Enhance executive reporting

Detailed recommendations are available in:

```
reports/decision_center.md
```

---

## 📁 Project Structure

```
SupplyVision/
│
├── data/
├── images/
├── docs/
├── reports/
├── notebooks/
├── powerbi/
├── sql/
├── src/
├── README.md
├── requirements.txt
```

---

## 📚 Key Learnings

This project strengthened practical skills in:

- Data Engineering
- ETL Development
- Data Warehousing
- SQL Analytics
- Data Modeling
- Business Intelligence
- Dashboard Design
- Business Reporting

---

## 🔮 Future Improvements

Potential enhancements include:

- Automated ETL Scheduling
- Incremental Data Loading
- Cloud Deployment (Azure/AWS)
- Real-Time Data Streaming
- Predictive Demand Forecasting
- Customer Segmentation using Machine Learning

---

## 👨‍💻 Author

**Amit Sharma**

B.Sc. Computer Science

Aspiring Data Analyst

---

## ⭐ If you found this project useful, consider giving it a star!