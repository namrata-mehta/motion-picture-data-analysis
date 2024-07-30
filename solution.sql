USE sakila;

/* Motion Pictures Data Analysis */

/*Task 1: 
The name of an actor plays a vital role in a business's profit. 
The board members want to see the list of actors available on the database table and the last updated date. */

SELECT concat(first_name,"  ",last_name) as name FROM actor;

/*Task 2: 
Many actors have adopted more attractive screen names, mostly at the behest of producers and directors. 
The board members want to know:
a. Is there any change in the actor's first name or last name?
b. How many actors have the same first names and last names? List out all these actors.
C. How many actors have unique names? What is the count of these actors in the database table?*/

select concat(first_name, " ",last_name)as name_of_actor,last_update from actor;

select count(actor_id) from actor
where first_name=last_name;

SELECT COUNT(*)
FROM (
    SELECT first_name, last_name
    FROM actor
    GROUP BY first_name, last_name
    HAVING COUNT(*) = 1
) AS unique_actors;



/*Task 3: To avoid confusion amongst the actors' names,
 the board wants to know the list of the actors whose names are repeated and the list of those whose names are not repeated.*/
 
#List of Actors with Repeated Names 
SELECT CONCAT(first_name, ' ', last_name) AS actor_name
FROM actor
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;

#List of Actors with Unique Names
SELECT CONCAT(first_name, ' ', last_name) AS actor_name
FROM actor
GROUP BY first_name, last_name
HAVING COUNT(*) = 1;


/*Task 4: The board need to categorize the actors playing identity roles, such as Action, 
Romance, Horror, and Mystery. For this, the board members want to have a 
detailed overview of films based on the actors' preferences.*/
select * from actor;
select * from category;
select * from film;
select * from film_category;
select * from film_Actor;
SELECT 
    CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name,
    category.name AS category_name,
    COUNT(film.film_id) AS number_of_films
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name IN ('Action', 'Romance', 'Horror', 'Mystery')
GROUP BY actor.actor_id, category.category_id
ORDER BY actor_name, category_name;


/*Task 5: The board needs to analyze the trend for movies based on their categories and determine 
which movie category has a majority count.
For this, the board wants to know various rating categories with descriptions. 
It needs to determine which movies are suitable for kids, 
which movies are restricted for all under 16 unless accompanied by a parent, 
and which movies are restricted for all audiences under 18*/

#1. List Movie Categories and Descriptions
SELECT 
    category.name AS category_name
FROM category;

-- 2. Movies Suitable for Kids (Assuming 'G' rating for General Audience)
SELECT film.title ,category.name ,film.rating
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE film.rating = 'G';

-- 3. Movies Restricted for All Under 16 Unless Accompanied by a Parent (Assuming 'PG-13' rating)
SELECT film.title,category.name ,film.rating
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE film.rating = 'PG-13';

-- 4. Movies Restricted for All Audiences Under 18 (Assuming 'R' rating)
SELECT film.title,category.name,film.rating
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE film.rating = 'R';

-- 5. Determine Which Movie Category Has the Majority Count
SELECT category.name,COUNT(film.film_id)
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY COUNT(film.film_id) DESC
LIMIT 1;


/*Task 6: The board members want to understand the
replacement cost, that is, the amount of money required to replace an existing asset with an equally valued or similar asset at 
the current market price.
a. Figure out the movie titles where the replacement cost is up to $9.
b. Get the movie titles where the replacement cost is between $15 and $20.
c. Find the movies with the highest replacement cost but the lowest rental cost.*/

SELECT title
FROM film
WHERE replacement_cost <= 9.00;


SELECT title
FROM film
WHERE replacement_cost BETWEEN 15.00 AND 20.00;


SELECT title,replacement_cost,rental_rate
FROM film
WHERE replacement_cost = (SELECT MAX(replacement_cost)FROM film)
ORDER BY rental_rate ASC
LIMIT 1;

/*Task 7: The board members need to know the list all the films along with the number of actors listed for each film.*/

SELECT f.title AS FilmName, COUNT(fa.actor_id) AS NumberOfActors
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.title
LIMIT 1000;

/* task 8   Task 8: The music of Queen and Kris Kristofferson has seen an unlikely resurgence.
 As an unintended consequence, films starting with the letters 'K' and 'Q' have also soared in popularity.
 Display the titles of the movies starting with the letters 'K' and 'Q*/

USE sakila;

SELECT title
FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%'
ORDER BY title;



/* Task 9: As the film 'AGENT TRUMAN' has been a great success, display all the actors who appeared in this film.*/
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'AGENT TRUMAN';


/*Task 10: Sales have been lagging among young families, so a board member wants to promote all family movies.
 Identify all the movies categorized as family films.   */
 SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';


/*Task 11: Display the most frequently rented movies in descending order to maintain more copies of those movies. */

SELECT movie_title, COUNT(*) AS rental_count
FROM rentals
GROUP BY movie_title
ORDER BY rental_count DESC;


/* Task 12: In how many film categories, the average difference between the film replacement cost and the rental rate is greater
 than $15?*/
 USE your_database_name;
use sakila;
USE sakila;

SELECT c.name AS category,AVG(f.replacement_cost - f.rental_rate) AS avg_difference
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.replacement_cost - f.rental_rate) > 15;

/* Task 13: Board members want to identify the genres having 60- 70 films. List the names of these categories and the number of films per category, 
sorted by the number of films. */

USE sakila;

SELECT c.name AS category,COUNT(f.film_id) AS film_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING COUNT(f.film_id) BETWEEN 60 AND 70
ORDER BY film_count;





















