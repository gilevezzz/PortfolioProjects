--CLIENT WANTS TO KNOW WHAT FILM RATINGS DO THE DVD RENTAL STORE HAVE

SELECT DISTINCT rating 
FROM film
------------------------------------------------

--CLIENT ASKS TO PROVIDE A LIST OF ALL THE FILMS THAT HAVE A G RATING
--CLIENT WANTS TO SEE THE TITLE AND THE RATING OF THE FILMS

SELECT title, rating
FROM film
WHERE rating = 'G'
----------------------------------------------

--QUERY A LIST OF THE FIRST 20 PAYMENTS MADE FROM THE PAYMENT TABLE

SELECT payment_id, payment_date
FROM payment
ORDER BY payment_date
LIMIT 20
----------------------------------------------

--CLIENT ASKS FOR A LIST OF ALL THE TITLE OF THE FILMS AND THEIR RENTAL RATES FOR FILMS WITH RENTAL RATE BETWEEN 0.99 AND 2.99

SELECT title, rental_rate
FROM film
WHERE rental_rate BETWEEN 0.99 AND 2.99
ORDER BY title
----------------------------------------------

--IDENTIFY THE CUSTOMER ID NUMBERS WITH THE ONLY GIVEN DETAILS HAVING FIRST NAME DEBORAH, TYLER, AND VIRGIL THAT LAST NAME STARTS WITH W

SELECT customer_id, first_name, last_name
FROM customer
WHERE last_name LIKE 'W%'
AND first_name IN ('Virgil', 'Tyler', 'Deborah')
----------------------------------------------

--PROVIDE AN OUTPUT SHOWING DIFFERENT RATINGS OF THE DVD RENTAL STORE'S FILMS AND HOW MANY TITLES THERE ARE PER RATING

SELECT rating, count(*) AS number_of_films
FROM film
GROUP BY rating
----------------------------------------------

--CLIENT WANTS A LIST OF CUSTOMER IDS WITH 35 OR MORE PAYMENT TRANSACTIONS

SELECT customer_id, COUNT(*) AS number_of_transactions
FROM payment
GROUP BY customer_id
HAVING COUNT(*) >= 35
ORDER BY customer_id
--------------------------------------------------

--PROVIDE A LIST OF EMAIL ADDRESSES OF CUSTOMERS FROM CALIFORNIA

SELECT district, email
FROM customer JOIN address
ON address.address_id = customer.address_id
WHERE district = 'California'
------------------------------------------------

--PROVIDE A LIST OF CUSTOMER ID WITH AN AVERAGE PAYMENT AMOUNT GREATER THAN THE AVERAGE PAYMENT AMOUNT MADE BY ALL THE CUSTOMERS

SELECT customer_id, AVG(amount)
FROM payment
GROUP BY customer_id
HAVING AVG(amount) > (SELECT AVG(amount) FROM payment)
ORDER BY customer_id
----------------------------------------------

--CASE FUNCTIONS

SELECT title, length,
CASE
	WHEN length = 115 THEN 'Average'
	WHEN length < 115 THEN 'Short'
	ELSE 'Long'
END AS length_analysis
FROM film
ORDER BY title
----------------------------------------------


