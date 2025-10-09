# E-Commerce Customer and Basket Analysis

## **Executive Summary**
This project performs an exploratory data analysis (EDA) on an e-commerce dataset from Kaggle focusing on customer demographics and purchasing activity. Using SQL I cleaned, joined, and aggregated data from two tables Customer Details and Basket Details to uncover patterns in customer behavior and transaction trends. 

Key findings from analysis the include: 
- 29% of customers have invalid ages
- Most customers have been with the company for 5–10 years 
- 42 only appears on both table while 13k has missing customer records
- The transactions declined from May to June 2019. 

The recommendations include the importance of improving data accuracy, monitoring sales trends, and strengthening engagement strategies for both new and loyal customers. 

## **Statement of the Problem**
E-commerce businesses often struggle to translate large volumes of customer and transaction data into actionable insights.  This project explores the relationships between customer demographics (age, sex, and tenure) and basket activity. It aims to uncover insights that can help identify patterns in customer engagement and purchasing habits. 

### **Objectives:**
* Explore potential relationships between customers and their shopping activity. 
* Understand the demographic distribution of customers (age, sex, and tenure). 
* Identify trends or patterns in product purchases over time. 

## **Methodology**
* I cleaned and standardized the data using SQL
* I explored customer table using aggregating functions, grouping data, adding new columns.
* I explored basket table using aggregating functions, grouping data, and joins.

## **Skills**
* SQL - Joins, Group By, Aggregating Functions, Subquery

## **Results**
Here's what I found out:
* There's a large count of customers that has invalid age (age below 16 or above 100) in the dataset. It is approximately 29.1% of all customers. 
* Most customers have been with the company for 5–10 years, followed closely by those with 1–3 years of membership. 
* Only 42 customers appear in both tables, while 13k have basket data but missing customer records. 
* Transaction volume decreases from 8.9k in May 2019 to 6.1k in June 2019. 
* May 27, 2019 recorded the highest daily transactions with 1.6k while June 6, 2019 had the lowest daily transactions with only 187. 

## **Recommendations**
Here's my recommendation for the stakeholders:
* Validate the age data since there is a large number of invalid ages.
* Investigate the sales decline between May and June 2019.
* Grant promo deals for customers with 1 - 3 yrs membership and provide more benefits and exclusive promo deals for customers with 5 - 10 yrs of membership.
