-- 1 most visited films in 2018
SELECT film.title, COUNT(1) as cnt FROM film, session ;
	WHERE session.film_id = film.film_id AND ;
	DTOS(session.time) > "12012018" AND ;
	DTOS(session.time) < "31122018" ;
	GROUP BY film.title ;
	ORDER BY cnt DESC
-- 2 most popular genres in 2018
SELECT genre.name, COUNT(1) as cnt FROM film, session, genre ;
	WHERE session.film_id = film.film_id AND ;
	film.genre_id = genre.genre_id and;
	DTOS(session.time) > "12012018" AND ;
	DTOS(session.time) < "31122018" ;
	GROUP BY genre.name ;
	ORDER BY cnt DESC
-- 3 most popular countries, which produce films
SELECT country.name, COUNT(1) as cnt FROM film, session, country;
	WHERE session.film_id = film.film_id AND ;
	film.country_id = country.country_id and;
	DTOS(session.time) > "12012018" AND ;
	DTOS(session.time) < "31122018" ;
	GROUP BY country.name ;
	ORDER BY cnt DESC
-- 4 revenues for all films in date interval
SELECT session.session_id, COUNT(1) FROM session, ticket INTO CURSOR sold;
	WHERE session.session_id = ticket.session_id AND ;
	ticket.is_sold = 1 and ;
    DTOS(session.time) > "12012018" and ;
    DTOS(session.time) < "12012018" ;
	GROUP BY session.session_id

SELECT sold.session_id, (sold.cnt_exp_2 * session.price) as revenue FROM sold, film, session INTO CURSOR ses_sum ;
	WHERE sold.session_id = session.session_id AND ;
	film.film_id = session.film_id

SELECT film.title, SUM(ses_sum.revenue) FROM film, ses_sum, session;
	WHERE ses_sum.session_id = session.session_id AND ;
	session.film_id = film.film_id ;
	GROUP BY film.title
-- 5 average attendance in each hall in date interval
SELECT hall.name, SUM(hall.capacity) as general_cap FROM session, ticket, hall INTO CURSOR cap;
	WHERE session.session_id = ticket.session_id AND ;
	session.hall_id = hall.hall_id AND ;
	DTOS(session.time) > "12012018" AND ;
	DTOS(session.time) < "31122018" ;
	GROUP BY hall.name

SELECT hall.name, COUNT(1) as cnt FROM session, ticket, hall into cursor attend;
	WHERE session.session_id = ticket.session_id AND ;
	ticket.is_sold = 1 AND ;
	session.hall_id = hall.hall_id AND ;
	DTOS(session.time) > "12012018" AND ;
	DTOS(session.time) < "31122018" ;
	GROUP BY hall.name ;
	ORDER BY cnt DESC 

SELECT hall.name, (cap.general_cap / attend.cnt) as avg FROM hall, cap, attend ;
	WHERE hall.name = cap.name AND ;
	hall.name = attend.name ;
	ORDER BY avg desc
-- 6 attendance in each hall in date interval
SELECT hall.name, COUNT(1) as cnt FROM session, ticket, hall ;
	WHERE session.session_id = ticket.session_id AND ;
	ticket.is_sold = 1 AND ;
	session.hall_id = hall.hall_id AND ;
	DTOS(session.time) > "12012018" AND ;
	DTOS(session.time) < "31122018" ;
	GROUP BY hall.name ;
	ORDER BY cnt DESC 

-- amount of films of different types
SELECT type.name, COUNT(1) FROM session, type ;
	WHERE session.type_id = type.type_id ;
	Group BY type.name
-- stats about 2d and 3d films
SELECT type.type_id, SUM(hall.capacity) as gen_cap FROM session, hall, type INTO CURSOR cap; -- HERE I FIND GENERAL CAPACITY IN 2D & 3D films
	WHERE session.type_id = type.type_id AND ;
	session.hall_id = hall.hall_id ;
	GROUP BY type.type_id

SELECT type.type_id, COUNT(1) as gen_attend FROM type, session, ticket INTO CURSOR attend;
	WHERE type.type_id = session.type_id AND ;
	session.session_id = ticket.session_id AND ;
	ticket.is_sold = 1 ;
	group by type.type_id

SELECT type.name, (cap.gen_cap / attend.gen_attend) as avg_attend FROM type, cap, attend ;
	WHERE type.type_id = cap.type_id AND ;
	attend.type_id = type.type_id
-- average attendance in each film
SELECT film.film_id, SUM(hall.capacity) as gen_cap FROM film, session, hall INTO CURSOR cap;
	WHERE film.film_id = session.film_id;
	  AND session.hall_id = hall.hall_id;
	  AND session.time <= DATETIME();
	GROUP BY film.film_id
SELECT film.film_id, COUNT(1) as gen_attend FROM film, session, ticket INTO CURSOR attend;
	WHERE film.film_id = session.film_id;
	  AND session.session_id = ticket.session_id;
	  AND ticket.is_sold = 1;
	  AND session.time <= DATETIME();
	GROUP BY film.film_id
SELECT film.title, (attend.gen_attend / cap.gen_cap) * 100 FROM film, cap, attend ;
	WHERE film.film_id = cap.film_id AND ;
	attend.film_id = film.film_id