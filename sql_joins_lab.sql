USE SAKILA;

#1. List the number of films per category:
SELECT 
    category.name AS category_name,
    COUNT(film.film_id) AS number_of_films
FROM 
    film
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY 
    category.name;

#2. Retrieve the store ID, city, and country for each store:
SELECT 
    store.store_id,
    city.city,
    country.country
FROM 
    store
JOIN 
    address ON store.address_id = address.address_id
JOIN 
    city ON address.city_id = city.city_id
JOIN 
    country ON city.country_id = country.country_id;

#3. Calculate the total revenue generated by each store in dollars:
SELECT 
    store.store_id,
    SUM(payment.amount) AS total_revenue
FROM 
    payment
JOIN 
    rental ON payment.rental_id = rental.rental_id
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    store ON inventory.store_id = store.store_id
GROUP BY 
    store.store_id;

#4. Determine the average running time of films for each category:
SELECT 
    category.name AS category_name,
    AVG(film.length) AS average_running_time
FROM 
    film
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY 
    category.name;

#5. Identify the film categories with the longest average running time:
SELECT 
    category.name AS category_name,
    AVG(film.length) AS average_running_time
FROM 
    film
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY 
    category.name
ORDER BY 
    average_running_time DESC;

#6. Display the top 10 most frequently rented movies in descending order:
SELECT 
    film.title,
    COUNT(rental.rental_id) AS rental_count
FROM 
    rental
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON inventory.film_id = film.film_id
GROUP BY 
    film.title
ORDER BY 
    rental_count DESC
LIMIT 10;

#7. Determine if "Academy Dinosaur" can be rented from Store 1:
SELECT 
    film.title,
    inventory.store_id,
    IFNULL(inventory.inventory_id, 'NOT available') AS availability_status
FROM 
    inventory
JOIN 
    film ON inventory.film_id = film.film_id
WHERE 
    film.title = 'Academy Dinosaur' 
    AND inventory.store_id = 1;

#8. Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.'
SELECT 
    film.title,
    CASE 
        WHEN inventory.inventory_id IS NOT NULL THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM 
    film
LEFT JOIN 
    inventory ON film.film_id = inventory.film_id
GROUP BY 
    film.title;

