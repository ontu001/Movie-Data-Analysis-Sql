-- We will be looking at the following business questions to query using PostgreSQL :

-- Sort with count 
select 
	release_year,
	count(movie_id) count_ 
from movies 
group by 1 
order by 2 desc; 


-- Print the year in which “The Godfather” movie was released.
select 
	title,
	release_year
from 
	movies
where 
	title = 'The Godfather';






-- Print all movies in the order of their release year (latest first).
select release_year, title from movies
order by release_year desc; 



-- Select all movies that are by Marvel Studios and Hombale Films.
select * from movies
where studio in ('Marvel Studios','Hombale Films');


-- Select all movies that are not from Marvel Studios.
select * from movies
where studio not in ('Marvel Studios');


-- Print a year and how many movies were released in that year starting with the latest year?
select release_year, count(*) 
from movies
group by release_year
order by release_year desc;


-- Print profit % for all the movies?
select *, revenue-budget*100/budget as profit_pers from finantials;


-- Show all the movies with their language names?
select m.title,l.name
from
movies m
left join languages l
on m.language_id = l.language_id;


-- Show all Telugu movie names (assuming you don’t know the language id for Telugu)?
select m.title,l.name
from
movies m
left join languages l
on m.language_id = l.language_id
where l.name = 'Telugu';


-- Generate a report of all Hindi movies sorted by their revenue amount in millions. Print movie name, revenue, currency, and unit?
select m.title, f.revenue, f.currency, f.unit,
case when unit = 'Thousands' then round(revenue/1000,2)
when unit = 'Billions' then round(revenue*1000,2)
else revenue
end as revenue_mln
from
movies m
inner join finantials f
on m.movie_id = f.movie_id
inner join languages l
on m.language_id = l.language_id
where l.name = 'Hindi'
order by revenue_mln desc;


-- Select all the movies with minimum and maximum release year?
select title,release_year
from
movies
where release_year in (
(select max(release_year) from movies),
(select min(release_year) from movies)
)
order by release_year desc;


-- Select all the rows from the movies table whose imdb_rating is higher than the average rating?
select * from movies
where imdb_rating > (select avg(imdb_rating) from movies)
order by imdb_rating desc;



-- Select all Hollywood movies released after the year 2000 that made more than 500 million $ profit?
with x as (select * from movies
where industry = 'Hollywood'),
y as (select *,(revenue-budget)*100/budget  as percentage_profit from finantials
where (revenue-budget)*100/budget > 500 )
select x.movie_id, x.title,x.release_year, y.percentage_profit
from x
join y
on x.movie_id = y.movie_id
where release_year > 2000;



---- Language-wise Financial Success
SELECT
    l.name AS language,
    COUNT(m.movie_id) AS total_movies,
    SUM(f.revenue) AS total_revenue,
    AVG(f.revenue) AS avg_revenue
FROM
    movies m
JOIN finantials f ON m.movie_id = f.movie_id
JOIN languages l ON m.language_id = l.language_id
GROUP BY l.name
ORDER BY total_revenue DESC;


select * from movies where language_id = 7;
select * from finantials where movie_id = 127;
select * from actors;



-- Actor Popularity – Number of Movies per Actor


SELECT
    a.name AS actor_name,
    COUNT(ma.movie_id) AS total_movies
FROM
    actors a
JOIN movie_actor ma ON a.actor_id = ma.actor_id
GROUP BY a.actor_id, a.name
ORDER BY total_movies DESC;


---- Impact of Actor Popularity on IMDB Rating
WITH actor_movie_count AS (
    SELECT
        ma.actor_id,
        COUNT(ma.movie_id) AS total_movies
    FROM
        movie_actor ma
    GROUP BY ma.actor_id
),
top_actors AS (
    SELECT
        amc.actor_id
    FROM actor_movie_count amc
    ORDER BY total_movies DESC
    LIMIT 10
)
SELECT
    a.name,
    COUNT(m.movie_id) AS total_movies,
    AVG(m.imdb_rating) AS avg_rating
FROM
    movie_actor ma
JOIN top_actors ta ON ma.actor_id = ta.actor_id
JOIN movies m ON ma.movie_id = m.movie_id
JOIN actors a ON a.actor_id = ta.actor_id
GROUP BY a.name
ORDER BY avg_rating DESC;

--- ROI by Studio with High IMDB Ratings
SELECT
    m.studio,
    COUNT(m.movie_id) AS total_movies,
    AVG(m.imdb_rating) AS avg_rating,
    AVG((f.revenue - f.budget) * 1.0 / f.budget) AS avg_roi
FROM
    movies m
JOIN finantials f ON m.movie_id = f.movie_id
WHERE
    m.imdb_rating > 7.0
GROUP BY m.studio
ORDER BY avg_roi DESC
LIMIT 10;

--  Optional — Year-wise Trend of Movie Production
SELECT
    release_year,
    COUNT(movie_id) AS total_movies
FROM
    movies
GROUP BY release_year
ORDER BY release_year;