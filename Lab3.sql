-- 1 In the table actor, which are the actors whose last names are not repeated? 
-- For example if you would sort the data in the table actor by last_name, 
-- you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
-- These three actors have the same last name. So we do not want to include this last name in our output.
-- Last name “Astaire” is present only one time with actor “Angelina Astaire”, hence we would want this in our output list.
SELECT	
    sakila.actor.first_name,
    sakila.actor.last_name
FROM
	sakila.actor
GROUP BY
	last_name,
	first_name
HAVING
	COUNT(sakila.actor.last_name) = 1
;
    
    
#2 Which last names appear more than once? We would use the same logic as in the previous question but this time 
-- we want to include the last names of the actors where the last name was present more than once
SELECT	
    COUNT(sakila.actor.last_name) AS appearances,
    sakila.actor.last_name
FROM
	sakila.actor
GROUP BY
	last_name	
HAVING
	appearances > 1
;
#3 Using the rental table, find out how many rentals were processed by each employee.
SELECT
	sakila.staff.staff_id,
    concat( sakila.staff.First_Name,' ',
    sakila.staff.Last_Name) AS Name,
    count(sakila.rental.rental_id) AS Rentals
FROM
	sakila.rental
JOIN staff on rental.staff_id = staff.staff_id
GROUP BY name,
    staff_id
;

#4 Using the film table, find out how many films were released each year.
SELECT
	sakila.film.release_year,
	count(sakila.film.title) AS Films
FROM
	sakila.film
GROUP BY
	release_year
;
#5 Using the film table, find out for each rating how many films were there.
SELECT
	sakila.film.rating,
    count(sakila.film.rating)
FROM
	sakila.film
GROUP BY
	sakila.film.rating
;

#6 What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT
	sakila.film.rating,
    ROUND(AVG(sakila.film.length),2) AS Average_Length
FROM
	sakila.film
GROUP BY
	sakila.film.rating
;

#7 Which kind of movies (rating) have a mean duration of more than two hours?
SELECT
	sakila.film.rating,
    AVG(sakila.film.length) AS Average_Length
FROM
	sakila.film
GROUP BY
	sakila.film.rating
HAVING
	Average_Length > 120
;

#8 Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT
	RANK() OVER (ORDER BY sakila.film.length) DESC AS 'Rank',
    sakila.film.title,
    sakila.film.length
    #rank
FROM
    sakila.film
WHERE
	length is not null
AND
	length > 0
ORDER BY
	length desc
;







