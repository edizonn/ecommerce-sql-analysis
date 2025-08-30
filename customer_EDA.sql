# Customer Details EDA

USE e_commerce_db;

SELECT *
FROM customer_details
;

# find duplicate record
SELECT 
    customer_id,
    sex,
    customer_age,
    age_bracket,
    tenure,
    tenure_year,
    tenure_group,
    COUNT(*) AS count
FROM customer_details
GROUP BY 
    customer_id,
    sex,
    customer_age,
    age_bracket,
    tenure,
    tenure_year,
    tenure_group
HAVING count > 1
;

# grouping tenure by years
SELECT 
  *,
  ROUND(tenure / 12, 1) AS tenure_in_years
FROM customer_details
ORDER BY tenure
;

# tenure by years groupings
SELECT 
  *,
  ROUND(tenure / 12, 1) AS tenure_in_years,
  CASE
	WHEN tenure < 12 THEN 'Less than 1 year'
    WHEN tenure BETWEEN 12 AND 36 THEN '1-3 years'
    WHEN tenure BETWEEN 37 AND 60 THEN '3-5 years'
    WHEN tenure BETWEEN 61 AND 120 THEN '5-10 years'
    ELSE 'Over 10 years'
  END AS tenure_group
FROM customer_details
ORDER BY tenure
;

# tenure by years (GROUP BY)
# GOAL: to find the number of customers who are in range of <1 yr, 1-3 yr, 3-5 yr, 5-10 yr and >10 yr 
SELECT tenure_group, COUNT(customer_id) AS customer_number
FROM (
	SELECT 
	   customer_id,
	  ROUND(tenure / 12, 1) AS tenure_in_years,
	  CASE
		WHEN tenure < 12 THEN 'Less than 1 year'
		WHEN tenure BETWEEN 12 AND 36 THEN '1-3 years'
		WHEN tenure BETWEEN 37 AND 60 THEN '3-5 years'
		WHEN tenure BETWEEN 61 AND 120 THEN '5-10 years'
		ELSE 'Over 10 years'
	  END AS tenure_group
	FROM customer_details
	) AS subquery_1
GROUP BY tenure_group
ORDER BY tenure_group
;

# AGE QUERY
# COUNT of age of users < 16 or > 100
# found out some age are questionable (users who are < 16 yrs old and has age > 100 yrs old)
SELECT customer_age, COUNT(*)
FROM customer_details
GROUP BY customer_age
HAVING customer_age < 16 OR customer_age > 100
ORDER BY customer_age ASC
;

# COUNT of age of users > 16 and < 100
SELECT customer_age, COUNT(*)
FROM customer_details
GROUP BY customer_age
HAVING customer_age > 16 AND customer_age < 100
ORDER BY customer_age ASC
;

# DELETING invalid age
SELECT * 
FROM customer_details
WHERE customer_age < 0
;

# change my mind and just made the age positive, since it's seems like a typo of - sign. All credentials are valid.
UPDATE customer_details
SET customer_age = ABS(customer_age)
WHERE customer_age = -34
;

# FIND < 16 and > 100 years to NULL for the reason that, it seems sketchy for customer to have that too young age and too old age. 
SELECT 
	customer_id,
    sex,
    customer_age,
	CASE 
		WHEN customer_age < 16 THEN NULL
		WHEN customer_age > 100 THEN NULL
		ELSE customer_age
	END AS clean_age,
    tenure
FROM customer_details
;

# GROUP BY Age bracket
SELECT
	CASE 
		WHEN clean_age BETWEEN 16 AND 24 THEN '16-24: Teenager'
		WHEN clean_age BETWEEN 25 AND 34 THEN '25-34: Young Adult'
		WHEN clean_age BETWEEN 35 AND 44 THEN '35-44: Adult'
		WHEN clean_age BETWEEN 45 AND 54 THEN '45-54: Middle-aged Adult'
		WHEN clean_age BETWEEN 55 AND 64 THEN '55-64: Mature Adult'
		WHEN clean_age >= 65 THEN '65+: Senior Citizen'
		ELSE 'Invalid Age'
	END AS age_bracket,
    COUNT(*) AS Total
FROM (
	SELECT 
		customer_id,
		sex,
		customer_age,
		CASE 
			WHEN customer_age < 16 THEN NULL
			WHEN customer_age > 100 THEN NULL
			ELSE customer_age
		END AS clean_age,
		tenure
	FROM customer_details
) AS subquery2
GROUP BY age_bracket
ORDER BY age_bracket
;

# UPDATE tenure
# updating the age in the table.
# update age < 16 or > 100 to NULL
UPDATE customer_details
SET customer_age = NULL
WHERE customer_age < 16 OR customer_age > 100
;

#GOAL: add the 3 new column
ALTER TABLE customer_details
ADD COLUMN age_bracket VARCHAR(50),
ADD COLUMN tenure_year VARCHAR(50),
ADD COLUMN tenure_group VARCHAR(50)
;

# update age bracket
UPDATE customer_details
SET age_bracket = CASE
    WHEN customer_age BETWEEN 16 AND 24 THEN 'Teen'
    WHEN customer_age BETWEEN 25 AND 34 THEN 'Young Adult'
    WHEN customer_age BETWEEN 35 AND 44 THEN 'Adult'
    WHEN customer_age BETWEEN 45 AND 54 THEN 'Middle-aged Adult'
    WHEN customer_age BETWEEN 55 AND 64 THEN 'Mature Adult'
    WHEN customer_age >= 65 THEN 'Senior Citizen'
    ELSE 'Invalid or Missing Age'
END;

# update tenure_year
UPDATE customer_details
SET tenure_year = ROUND(tenure / 12, 1)
;

UPDATE customer_details
SET tenure_group = 
	CASE
		WHEN tenure < 12 THEN 'Less than 1 year'
		WHEN tenure BETWEEN 12 AND 36 THEN '1-3 years'
		WHEN tenure BETWEEN 37 AND 60 THEN '3-5 years'
		WHEN tenure BETWEEN 61 AND 120 THEN '5-10 years'
		ELSE 'Over 10 years'
	END
  ;


# COUNT gender of users
SELECT sex, COUNT(*) AS total
FROM customer_details
GROUP BY sex
;

# found out different sex/gender input
SELECT *
FROM customer_details
WHERE sex = 'kvkktalepsilindi'
;

SELECT *
FROM customer_details
WHERE sex = 'UNKNOWN'
;

# there are sex that is not reliable
UPDATE customer_details
SET sex = NULL
WHERE sex = 'kvkktalepsilindi'
;

# updating faulty sex/gender input
UPDATE customer_details
SET sex = NULL
WHERE sex = 'UNKNOWN'
;

UPDATE customer_details
SET sex = 'Unspecified'
WHERE sex IS NULL
;

SELECT * 
FROM customer_details
;

# REPOSITIONING
CREATE TABLE customer_details_new AS
SELECT
    customer_id,
    sex,
    customer_age,
    age_bracket,     
    tenure,
    tenure_year,
    tenure_group
FROM customer_details
;

# REPOSITION 2
CREATE TABLE customer_details_new1 AS
SELECT
    customer_id,
    sex,
    customer_age,
    age_bracket,      
    tenure,
    tenure_year,
    tenure_group
FROM customer_details
;

SELECT * 
FROM customer_details_new1
;

DROP TABLE 
customer_details_new
;

DROP TABLE 
customer_details
;

RENAME TABLE customer_details_new1 
TO customer_details
;

SELECT * 
FROM customer_details
;

ALTER TABLE customer_details
ADD COLUMN month_activity VARCHAR(20)
;

#update ACTIVE
UPDATE customer_details AS c
JOIN (
    SELECT DISTINCT customer_id
    FROM basket_details
) AS b ON c.customer_id = b.customer_id
SET c.month_activity = 'ACTIVE';


-- Set the rest as NOT ACTIVE
UPDATE customer_details
SET month_activity = 'NOT ACTIVE'
WHERE month_activity IS NULL;

SELECT *
FROM customer_details
;

SELECT COUNT(DISTINCT c.customer_id)
FROM customer_details c
JOIN basket_details b ON c.customer_id = b.customer_id
;

UPDATE customer_details c
JOIN (
    SELECT DISTINCT customer_id
    FROM basket_details
) b ON c.customer_id = b.customer_id
SET c.month_activity = 'ACTIVE'
WHERE c.month_activity IS NULL OR c.month_activity != 'ACTIVE';

# FAILED ATTEMPT
ALTER TABLE customer_details
DROP COLUMN month_activity
;
