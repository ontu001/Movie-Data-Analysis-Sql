
-- We will be looking at the following business questions to query using PostgreSQL :


-- Top 5 movie based on IMDB rating
select 
	title,
	industry,
	release_year,
	imdb_rating
from movies
order by imdb_rating desc
limit 5;



-- How many number of move released over the year
select
	release_year,
	count (movie_id) as Total_movie_realeased
from movies
group by 1
order by 1 asc;





-- Released Movies from Marvel Studio
select 
	title,
	imdb_rating,
	release_year,
	studio
from movies
where studio = 'Marvel Studios'




-- Find all the avengers movie
select
	title,
	release_year,
	imdb_rating
from movies
where title like '%Avenger%'



-- Find All the movies from Bolloywood Industy
select
	title,
	release_year,
	imdb_rating
from movies
where industry = 'Bollywood'



-- Find all the movies which released in 2022
select
	title,
	release_year
from movies
where release_year = 2022;



-- Find all the movies which released after 2022 and IMDB rating is more than 8
select
	title,
	release_year,
	imdb_rating
from movies
where release_year > 2020 and imdb_rating > 8
order by 3 desc;







-- Find all the movies which released between 2015 to 2020 and IMDB rating is more than 8
select
	title,
	release_year,
	imdb_rating
from movies
where release_year between 2015 and 2020 and imdb_rating > 8
order by 3 desc;




-- Find all the thor series movies (ordered by year)
select
	title,
	release_year
from movies
where lower(title) like '%thor%'
order by 2 desc;



-- Find which Language has the highest number of movies
select 
	l.name,
	count(distinct movie_id) as number_of_movies
from movies m
left join languages l on l.language_id = m.language_id
group by 1
order by 2 desc;




-- Find movies from Bengali language
select 
	l.name,
	m.title
from movies m
left join languages l on l.language_id = m.language_id
where l.name = 'Bengali';


-- Find movies from Telugu language
select 
	m.title,
	l.name
from movies m
left join languages l on l.language_id = m.language_id
where l.name = 'Telugu';




-- Find the revenue of Hindi movies
select 
	title,
	case
		when unit = 'Thousands' then round(revenue/1000,2)
		when unit = 'Billions' then round(revenue*1000,2)
		else revenue
	end as revenue_millions
from movies m
inner join finantials f on f.movie_id = m.movie_id
inner join languages l on l.language_id = m.language_id
where l.name = 'Hindi'
order by 2 desc;





-- Find the highest revenue Hindi movies
select 
	title,
	case
		when unit = 'Thousands' then round(revenue/1000,2)
		when unit = 'Billions' then round(revenue*1000,2)
		else revenue
	end as revenue_millions
from movies m
inner join finantials f on f.movie_id = m.movie_id
inner join languages l on l.language_id = m.language_id
where l.name = 'Hindi'
order by 2 desc
limit 1;






-- Find the recent and the starting year from this database
select
	max(release_year) as Recent_Year,
	min(release_year) as Starting_year
from movies;




-- Find the highest IMDB rating movies compared to avegarge ratings.
select
	title,
	imdb_rating
from movies
where imdb_rating> (select avg(imdb_rating) from movies)
order by 2 desc;
