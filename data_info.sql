select * from movies;
select * from finantials;
select * from actors;
select * from movie_actor;
select * from languages;

select count( * ) from movies;
select count(*) from finantials;
select count(*) from actors;
select count(*) from movie_actor;



-- The dataset 5 tables with the following contents:
-- 1. Movies — movie id, title, industry, release year, 
	--IMDB rating, studio, language id
-- 2. Movie Actor — movie id, actor id
-- 3. Actors — actor id, name, birth year
-- 4. Financials — movie id, budget, revenue, unit, currency
-- 5. Languages — language id, name
