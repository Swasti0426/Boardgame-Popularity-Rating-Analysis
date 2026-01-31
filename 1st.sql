use BoardGameDB1;
select * from BoardGames;

--checking duplicacy
select boardgame, release_year, count(*) as cnt
from BoardGames
group by boardgame, release_year 
having count(*) > 1;

--checking inconsistent player count
select *
from boardgames
where min_players > max_players;

--check odd play time
select * from boardgames
where min_playtime > max_playtime
   or min_playtime <= 0
   or max_playtime <= 0;

--strange ages
select *
from boardgames
where minimum_age < 0 or minimum_age > 120;

--extreme outliers
select *
from boardgames
where avg_rating < 0 or avg_rating > 10;

--deleting duplicate values
delete from boardgames
where row_id not in (
    select min(row_id)
    from boardgames
    group by boardgame, release_year
);

--solving the problem of strange ages
update boardgames
set min_playtime = (
    select avg(min_playtime) from boardgames where min_playtime > 0
),
    max_playtime = (
    select avg(max_playtime) from boardgames where max_playtime > 0
)
where min_playtime <= 0 OR max_playtime <= 0;


--removing 0 from years with avg of years
select avg(release_year) as mean_release_year
from boardgames
where release_year > 0;

update boardgames
set release_year = 2013
where release_year = 0;

--rounding off the value of avg_rating and complexity
update boardgames
set avg_rating = round(avg_rating, 2),
    complexity = round(complexity, 2);

--cleaning the null values from avg_rating
update boardgames
set avg_rating = (
    select round(avg(avg_rating), 2)
    from boardgames
    where avg_rating IS NOT NULL
)
where avg_rating IS NULL;

--removing 0 from min_age
update boardgames
set minimum_age = (
    select round(avg(minimum_age), 0)
    from boardgames
    where minimum_age > 0
)
where minimum_age = 0;

--selecting not described data
select * 
from boardgames
where description = 'No description';

--Creating derived helper columns for better interpretations
alter table boardgames add players_range int;
alter table boardgames add playtime_range int;

update boardgames
set players_range = max_players - min_players,
playtime_range = max_playtime - min_playtime;

--#1.List the top 5 boardgames with the highest avg_rating
select top 5 boardgame, avg_rating
from BoardGames
order by avg_rating desc;

--2.Find the games released after 2020 with an average rating above 8.0
select boardgame, release_year, avg_rating
from BoardGames
where release_year > 2020
  and avg_rating > 8.0;

--#3.Show the top 10 games by total_plays
select top 10 boardgame, total_plays
from BoardGames
order by total_plays desc;

--4.Calculate the average complexity per release_year
select release_year, avg(complexity) as avg_complexity
from BoardGames
group by release_year
order by release_year;

--5.Find the boardgames with more than 50,000 fans
select boardgame, fans
from boardGames
where fans > 50000
order by fans desc;

--6 Get the top 5 games with the highest wishlisted count
select top 5 boardgame, wishlisted
from BoardGames
order by wishlisted desc;

--7.Show the solo games (min_players = 1) with their avg_rating
select boardgame, avg_rating
from BoardGames
where min_players = 1
order by avg_rating desc;

--8.List boardgames released after 2015 where avg_rating is above the overall average, ordered by total_plays
select boardgame, release_year, avg_rating, total_plays
from BoardGames
where release_year > 2015
  and avg_rating > (select avg(avg_rating) from BoardGames)
order by total_plays desc;

--9.Identify release years where the average complexity is higher than 3.5, and show number of games released in those years
select release_year, count(*) as num_games, avg(complexity) as avg_complexity
from BoardGames
group by release_year
having avg(complexity) > 3.5
order by avg_complexity desc;


-- Shortest playtime games
select top 5 boardgame, min_playtime, max_playtime
from BoardGames
order by max_playtime asc;

-- Longest playtime games
select top 5 boardgame, min_playtime, max_playtime
from BoardGames
order by max_playtime desc;

-- Lowest complexity
select top 5 boardgame, complexity
from BoardGames
order by complexity asc;

-- Highest complexity
select top 5 boardgame, complexity
from BoardGames
order by complexity desc;

--#Games with biggest player range
select top 5 boardgame, min_players, max_players, 
       (max_players - min_players) as player_range
from BoardGames
order by player_range desc;

--Games with huge fan base but low ownership
select top 5 boardgame, fans, owned
from BoardGames
where fans > 20000 and owned < 500
order by fans desc;

--Average rating per decade
select (release_year/10)*10 as decade, 
       round(avg(avg_rating), 2) as avg_decade_rating
from BoardGames
group by (release_year/10)*10
order by decade;

--Most boardgames released in a year
select top 1 release_year, count(*) as num_games
from BoardGames
group by release_year
order by num_games desc;

-- #Yearly growth in games
select release_year, count(*) as num_games
from BoardGames
group by release_year
order by num_games desc;

-- Least played Games but having higher ratings
select top 10 boardgame, total_plays, avg_rating
from BoardGames
where avg_rating >= 8
order by total_plays asc;

-- Best games for kids
select top 10 boardgame, minimum_age, avg_rating, total_plays
from BoardGames
where minimum_age < 15
order by avg_rating desc, total_plays desc;

-- Having high owner, wishlist but getting lower rating
select boardgame, owned, wishlisted, avg_rating
from BoardGames
where owned >= 10000 and wishlisted >= 5000 and avg_rating < 7;

-- Having low complexity but it has higher rating
select boardgame, complexity ,avg_rating 
from BoardGames
where complexity <= 3 and avg_rating > 6
order by complexity, avg_rating desc;

--popular game
--#3.Show the top 10 games by total_plays year vise
select top 10 boardgame, total_plays,release_year
from BoardGames
order by total_plays desc;
 select max(release_year) as max,min(release_year) as min from BoardGames;

 -- IMP --Show the top 5 most played games released b/w 1980-2025
select top 10 boardgame,release_year, total_plays
from BoardGames
where release_year >=1980 and release_year <=2025
order by total_plays desc;

--Most boardgames released in a year
select top 5 release_year, count(*) as num_games
from BoardGames
group by release_year
order by num_games desc;

--Top 5 years by game releases with added metrics for quality and complexity
select top 5 release_year,count(*) as num_games, round(avg(avg_rating), 2) as avg_rating_in_year,
 round(avg(complexity), 2) as avg_complexity_in_year
from BoardGames
where release_year > 1990 
group by release_year
order by num_games desc;

-- Analyze the popularity of different player counts
select max_players,count(*) as num_games, round(avg(avg_rating), 2) as avg_rating_for_player_count,
round(avg(total_plays), 0) as avg_plays_for_player_count
from BoardGames
where max_players <= 8
group by max_players
order by num_games desc;

-- Find old but still highly-rated and popular games
select top 10 boardgame,release_year,avg_rating,owned
from BoardGames
where release_year < 2010 and avg_rating > 7.0 and owned > 50000
order by avg_rating desc;