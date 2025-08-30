# EXPLORE DATABASE

USE e_commerce_db;


SELECT *
FROM customer_details
;

#LEFT JOIN TABLE
SELECT *
FROM customer_details AS t1
LEFT JOIN basket_details AS t2
ON t1.customer_id = t2.customer_id
;

#FULL JOIN TABLE
SELECT t1.customer_id, t2.customer_id
FROM customer_details AS t1
LEFT JOIN basket_details AS t2
ON t1.customer_id = t2.customer_id
UNION
SELECT t1.customer_id, t2.customer_id
FROM customer_details AS t1
RIGHT JOIN basket_details AS t2
ON t1.customer_id = t2.customer_id
;

#COUNT user from table 2 that match to table 1
SELECT t1.customer_id, COUNT(t2.customer_id)
FROM customer_details AS t1
LEFT JOIN basket_details AS t2
ON t1.customer_id = t2.customer_id
GROUP BY t1.customer_id
;

SELECT t1.customer_id, COUNT(t1.customer_id)
FROM customer_details AS t1
LEFT JOIN basket_details AS t2
ON t1.customer_id = t2.customer_id
GROUP BY t1.customer_id
;

# backup data
CREATE TABLE A_customer_details_backup AS
SELECT * FROM customer_details
;

CREATE TABLE B_basket_details_backup AS
SELECT * FROM basket_details
;



