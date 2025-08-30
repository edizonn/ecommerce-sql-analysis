# Basket Details EDA

USE e_commerce_db;

# ALTER TABLE change datetime to date only
ALTER TABLE basket_details
MODIFY COLUMN basket_date DATE
;

# find DUPLICATE
SELECT 
	customer_id,
    product_id,
    basket_date,
    basket_count,
    COUNT(*) AS check_duplicate
FROM basket_details
GROUP BY 
	customer_id,
    product_id,
    basket_date,
    basket_count
HAVING check_duplicate > 1
;

SELECT * 
FROM basket_details
;

# find most bought product
SELECT product_id, COUNT(*) AS num_purchased
FROM basket_details
GROUP BY product_id
ORDER BY num_purchased DESC
;

# most customer who bought product
SELECT customer_id, COUNT(*) AS customer_purchased
FROM basket_details
GROUP BY customer_id
ORDER BY customer_purchased DESC
;

# total basket_count per customer
SELECT customer_id, SUM(basket_count) AS total_basket
FROM basket_details
GROUP BY customer_id
;

# customer who has record of purchases and registered (USE JOIN)
# RESULT: 42
SELECT COUNT(DISTINCT t1.customer_id) 
FROM customer_details AS t1
INNER JOIN basket_details AS t2
ON t1.customer_id = t2.customer_id
;

# UNREGISTERED user but has record of trasactions
#result: 13,829
SELECT COUNT(DISTINCT t2.customer_id) 
FROM customer_details AS t1
RIGHT JOIN basket_details AS t2
ON t1.customer_id = t2.customer_id
WHERE t1.customer_id IS NULL
;

#TEST
SELECT COUNT(DISTINCT t2.customer_id) 
FROM customer_details AS t1
RIGHT JOIN basket_details AS t2
ON t1.customer_id = t2.customer_id
WHERE t2.customer_id IS NULL
;

#EXPERIMENT 3 -- USING LEFT JOIN
SELECT COUNT(DISTINCT t1.customer_id) 
FROM basket_details AS t1
LEFT JOIN customer_details AS t2
ON t1.customer_id = t2.customer_id
WHERE t2.customer_id IS NULL
;

# COUNT of all customer id in basket_details
# RESULT: 13,871
SELECT COUNT(DISTINCT customer_id)
FROM basket_details
;

# COUNT of all customer in customer_details
# RESULT: 11,631
SELECT COUNT(DISTINCT customer_id) 
FROM customer_details
;

# USERS who are active and not
SELECT 
    t1.*,
    CASE 
        WHEN t2.customer_id IS NOT NULL THEN 'Active'
        ELSE 'Not Active'
    END AS month_activity
FROM customer_details AS t1
LEFT JOIN basket_details AS t2
    ON t1.customer_id = t2.customer_id
;
    
# COUNT active
# ACTIVE: 42
SELECT 
	COUNT(month_activity) AS num_active
FROM (
	SELECT 
		DISTINCT t1.customer_id,
		CASE 
			WHEN t2.customer_id IS NOT NULL THEN 'Active'
			ELSE 'Not Active'
		END AS month_activity
	FROM customer_details AS t1
	LEFT JOIN basket_details AS t2
		ON t1.customer_id = t2.customer_id
) AS subquery1
WHERE month_activity = 'Active'
;

# COUNT not active
# NOT ACTIVE: 11,589
SELECT 
	COUNT(month_activity) AS num_not_active
FROM (
	SELECT 
		DISTINCT t1.customer_id,
		CASE 
			WHEN t2.customer_id IS NOT NULL THEN 'Active'
			ELSE 'Not Active'
		END AS month_activity
	FROM customer_details AS t1
	LEFT JOIN basket_details AS t2
		ON t1.customer_id = t2.customer_id
) AS subquery1
WHERE month_activity = 'Not Active'
;

# DATE RANGE and total transactions
SELECT 
    MIN(basket_date) AS earliest_date,
    MAX(basket_date) AS latest_date,
    COUNT(*) AS total_transactions
FROM basket_details
;

# transactions every DAY
SELECT 
    DATE(basket_date) AS daily,
    COUNT(*) AS daily_transactions
FROM basket_details
GROUP BY daily
ORDER BY daily
;

# transactions every MONTH
SELECT 
DATE_FORMAT(basket_date,'%Y-%m') AS monthly,
COUNT(*) AS monthly_transactions
FROM basket_details
GROUP BY monthly
ORDER BY monthly
;

#highest and lowest performing day -- use subquery?
#easiest approach (perform 2 different queries)
# MAX
SELECT 
	DATE(basket_date) AS daily,
    COUNT(*) AS daily_transaction
FROM basket_details
GROUP BY daily
ORDER BY daily_transaction DESC
LIMIT 1
;

# MIN
SELECT 
	DATE(basket_date) AS daily,
    COUNT(*) AS daily_transaction
FROM basket_details
GROUP BY daily
ORDER BY daily_transaction ASC
LIMIT 1
;

# TOP 5 performing day
SELECT 
	DATE(basket_date) AS daily,
    COUNT(*) AS daily_transaction
FROM basket_details
GROUP BY daily
ORDER BY daily_transaction DESC
LIMIT 5
;

# AVERAGE basket per day
SELECT 
    DATE(basket_date) AS order_day,
    AVG(basket_count) AS avg_basket_count
FROM basket_details
GROUP BY order_day
ORDER BY order_day;

# BASKET_COUNT per day
SELECT 
    DATE(basket_date) AS order_day,
    SUM(basket_count)
FROM basket_details
GROUP BY order_day
ORDER BY order_day
;

# MAX basket_count
SELECT 
    DATE(basket_date) AS order_day,
    SUM(basket_count) AS total_basket
FROM basket_details
GROUP BY order_day
ORDER BY total_basket DESC
LIMIT 1
;

# MIN basket_count
SELECT 
    DATE(basket_date) AS order_day,
    SUM(basket_count) AS total_basket
FROM basket_details
GROUP BY order_day
ORDER BY total_basket ASC
LIMIT 1
;