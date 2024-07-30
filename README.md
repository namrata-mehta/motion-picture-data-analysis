# motion-picture-data-analysis
Using the Sakila database for motion picture data analysis involves examining various aspects of the film industry as represented in the database. 
Here’s a comprehensive summary of tasks for motion picture data analysis using the Sakila database:

Revenue Analysis

Calculate total rental revenue for each film, category, and store.
Compare revenue generated across different time periods.
Rental Trends

Identify which films are rented the most and analyze their rental patterns.
Track rental trends over time to identify seasonal or long-term changes.
Actor Contributions

Determine which actors appear most frequently in rentals and their influence on revenue.
Analyze the correlation between actors’ presence and film rental success.
Genre Analysis

Examine the popularity of different film genres based on rental data.
Assess how genre preferences change over time or across different regions.
Customer Insights

Analyze rental behaviors, including frequency, duration, and film preferences.
Explore customer demographics to understand their rental patterns (if demographic data is available).
Store Performance

Evaluate which stores generate the most revenue and have the highest rental rates.
Compare performance metrics across different store locations.
Inventory Management

Track which films are most frequently rented and manage inventory levels accordingly.
Assess the availability and turnover rate of films in inventory.
Sample Queries:
Revenue by Film: SELECT film.title, SUM(payment.amount) AS total_revenue FROM film JOIN inventory ON film.film_id = inventory.film_id JOIN rental ON inventory.inventory_id = rental.inventory_id JOIN payment ON rental.rental_id = payment.rental_id GROUP BY film.title;

Top Actors: SELECT actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS film_count FROM actor JOIN film_actor ON actor.actor_id = film_actor.actor_id GROUP BY actor.actor_id ORDER BY film_count DESC;

Popular Genres: SELECT category.name, COUNT(film_category.film_id) AS rental_count FROM category JOIN film_category ON category.category_id = film_category.category_id JOIN inventory ON film_category.film_id = inventory.film_id JOIN rental ON inventory.inventory_id = rental.inventory_id GROUP BY category.name ORDER BY rental_count DESC;

Store Revenue: SELECT store.store_id, SUM(payment.amount) AS total_revenue FROM store JOIN staff ON store.store_id = staff.store_id JOIN rental ON staff.staff_id = rental.staff_id JOIN payment ON rental.rental_id = payment.rental_id GROUP BY store.store_id ORDER BY total_revenue DESC;
