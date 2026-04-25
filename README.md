# 📊 Social Media Churn & Monetization Analysis

## 📌 Project Overview
This project challenges the common assumption that higher user screen time leads to higher revenue. The objective was to analyze user behavior, quantify burnout-driven churn risk, and identify hidden inefficiencies in platform monetization.

---

## 🎯 Business Problem
Social media platforms prioritize maximum engagement, assuming it directly increases revenue. This project investigates:
- Does higher screen time actually improve monetization?
- What is the financial impact of user burnout?
- Are highly engaged users at higher risk of churn?

---

## 🛠️ Data Architecture (SQL)

### 🔹 Data Modeling
- Ingested raw flat files and transformed them into a structured relational model
- Created datasets for user behavior, engagement, and revenue metrics

### 🔹 Data Transformation
- Used JOIN operations to combine user activity with financial data
- Applied complex `CASE WHEN` logic to segment users into **'Flight Risk' categories** based on:
  - Spending habits  
  - Engagement levels  
  - Mental health impact  

### 🔹 Optimization
- Built a centralized **Master VIEW** to store all transformations
- Improved query performance and enabled seamless BI integration

---

## 📈 Business Intelligence (Power BI)

### 🔹 Data Connection
- Connected Power BI directly to the SQL Master View

### 🔹 DAX Measures
- Created dynamic measures to:
  - Calculate at-risk revenue  
  - Identify churn-prone users  
  - Segment high-value customers  

### 🔹 Key Visualization
- Built a **"Monetization vs Addiction" scatter plot**
- Highlighted inefficiencies in high-engagement business models

---

## 🔍 Key Insights

### 💰 The $62K Threat
- Identified **$62,000/month** in potential churn risk
- Primarily from premium users with high engagement but declining well-being

### 👥 The Gen Z Bleed
- **56% of churn risk** comes from users aged **18–34**

### ⚖️ Efficiency vs Exhaustion
- High addiction levels (Level 3+) lead to **lower revenue conversion**
- Balanced engagement results in **better monetization efficiency**

---

## 🚀 Conclusion
> More engagement does not always mean more revenue.

Sustainable user engagement leads to stronger monetization, while excessive usage creates burnout and financial risk.

---

## 🧠 Skills Demonstrated
- SQL (Joins, CASE WHEN, Views, Data Modeling)
- Power BI (DAX, Dashboard Design, Visualization)
- Data Analysis (Churn Analysis, Revenue Risk, Segmentation)
- Business Insight Generation

---

## 📷 Dashboard Preview
(Add your dashboard screenshot here)

---
