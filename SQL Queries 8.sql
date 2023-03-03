USE sakila ;

#Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output
SELECT * FROM film;
SELECT title, length, RANK() OVER(ORDER BY length desc) AS "rank"
FROM film WHERE length IS NOT NULL ; 

#Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank
SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS 'Rank'
FROM film
WHERE length <> '' AND length IS NOT NULL ;
 
#How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category"
SELECT count(fc.film_id) AS count_per_category, c.name
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name ;

#Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears
SELECT * FROM actor ;
SELECT a.first_name, a.last_name, count(fa.film_id) as number_of_films
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 1,2
ORDER BY number_of_films DESC ;

#Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT * FROM customer ;
SELECT c.customer_id, c.first_name, c.last_name, count(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
GROUP BY 1,2,3
ORDER BY rental_count DESC
LIMIT 1 ;

#Bonus: Which is the most rented film? 
SELECT count(r.rental_id) AS number_of_rentals, f.title
FROM rental r
JOIN inventory i 
ON i.inventory_id = r.inventory_id
JOIN film f
ON f.film_id = i.film_id
GROUP BY 2
ORDER BY number_of_rentals DESC
LIMIT 1 ;
