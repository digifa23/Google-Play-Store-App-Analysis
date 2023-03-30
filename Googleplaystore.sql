SELECT *
FROM googleplaystore$


--Removing data with inconsistent values 
Delete from googleplaystore$
where Rating is null or Category =  '1.9'

--Removing the '+' and ',' sign from the installs column
UPDATE googleplaystore$
SET Installs = REPLACE(Installs, ',', '')
WHERE Installs LIKE '%,%';

---Adding new colmn to perform aggregation on it
ALTER TABLE googleplaystore$ ADD count_install BIGINT;

UPDATE googleplaystore$
SET count_install = install_count
FROM googleplaystore$

--DROPPING install_count COLUMN
alter table googleplaystore$
drop column install_count




--category with the highest rating 
select category, AVG(rating) as rating
from googleplaystore$
group by Category
order by rating desc


--Genre with the highest rating 
select Genres, AVG(rating) as rating
from googleplaystore$
group by Genres
order by rating desc


--Category with the highest review 
select category, AVG(Reviews) as Review_count
from googleplaystore$
group by Category
order by Review_count desc


--Genre with the highest review 
select Genres, AVG(Reviews) as Review_count
from googleplaystore$
group by Genres
order by Review_count desc


-- most popular Category by installation
SELECT  category, avg(Average_rating) as Average_Rating,
       SUM(installation_count) AS total_installations,
       SUM(installation_count) * 100.0 / SUM(SUM(installation_count)) OVER() AS percentage
FROM (
    SELECT category,avg(Rating) as Average_Rating, sum(count_install) AS installation_count
    FROM googleplaystore$
    GROUP BY category
) t
GROUP BY category
order by percentage desc


-- Most Popular Genres by Installation
SELECT Genres, avg(Average_rating) as Average_Rating,
       SUM(installation_count) AS total_installations,
       SUM(installation_count) * 100.0 / SUM(SUM(installation_count)) OVER() AS percentage
FROM (
    SELECT Genres,avg(rating) as Average_rating, sum(count_install) AS installation_count
    FROM googleplaystore$
    GROUP BY Genres
) t
GROUP BY Genres
order by percentage desc


--Most Popular Apps
SELECT app, category,rating,
       SUM(installation_count) AS total_installations,
       SUM(installation_count) * 100.0 / SUM(SUM(installation_count)) OVER() AS percentage
FROM (
    SELECT app,category, rating, sum(count_install) AS installation_count
    FROM googleplaystore$
    GROUP BY app,category,rating
) t
GROUP BY app,Category,rating
order by percentage desc

--Most Popular Apps by game category
SELECT app, category,rating,
       SUM(installation_count) AS total_installations,
       SUM(installation_count) * 100.0 / SUM(SUM(installation_count)) OVER() AS percentage
FROM (
    SELECT app,category,rating,  sum(count_install) AS installation_count
    FROM googleplaystore$
	where Category = 'game'
    GROUP BY app,category,rating
) t
GROUP BY app,Category,rating
order by percentage desc

--Most Popular Apps by communication category
SELECT app, category,rating,
       SUM(installation_count) AS total_installations,
       SUM(installation_count) * 100.0 / SUM(SUM(installation_count)) OVER() AS percentage
FROM (
    SELECT app,category,rating,  sum(count_install) AS installation_count
    FROM googleplaystore$
	where Category = 'communication'
    GROUP BY app,category,rating
) t
GROUP BY app,Category,rating
order by percentage desc

--Most Popular Apps by Productivity category
SELECT app, category,rating,
       SUM(installation_count) AS total_installations,
       SUM(installation_count) * 100.0 / SUM(SUM(installation_count)) OVER() AS percentage
FROM (
    SELECT app,category,rating,  sum(count_install) AS installation_count
    FROM googleplaystore$
	where Category = 'Productivity'
    GROUP BY app,category,rating
) t
GROUP BY app,Category,rating
order by percentage desc


--Most Popular Apps by social category
SELECT app, category,rating,
       SUM(installation_count) AS total_installations,
       SUM(installation_count) * 100.0 / SUM(SUM(installation_count)) OVER() AS percentage
FROM (
    SELECT app,category,rating,  sum(count_install) AS installation_count
    FROM googleplaystore$
	where Category = 'social'
    GROUP BY app,category,rating
) t
GROUP BY app,Category,rating
order by percentage desc



















select *
from googleplaystore$
group by Genres