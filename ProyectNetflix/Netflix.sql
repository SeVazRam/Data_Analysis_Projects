use proyectssql;

Select * from netflix_titles;

-- 1.Count the number of Movies vs TV Shows
select type, count(type) as NumberElemnts
from netflix_titles
group by type;

-- 2.  Find the most common rating for movies and TV shows
create table tab1 as
SELECT 
	type,rating,count(rating)
FROM netflix_titles
WHERE type = 'Movie'
group by rating
order by  count(rating) DESC
limit 1;

create table tab2 as
SELECT 
	type,rating,count(rating) 
FROM netflix_titles
WHERE type = 'Tv show'
group by rating
order by  count(rating) DESC
limit 1;

select * from tab1;
select * from tab2;

SELECT *
FROM tab1
UNION ALL
SELECT *
FROM tab2;

WITH Tabla1 AS (
  SELECT 
	type,rating,count(rating) 
FROM netflix_titles
WHERE type = 'Movie'
group by rating
order by  count(rating) DESC
limit 1
),
Tabla2 AS (
  SELECT 
	type,rating,count(rating) 
FROM netflix_titles
WHERE type = 'Tv show'
group by rating
order by  count(rating) DESC
limit 1
)
SELECT *
FROM tabla1
UNION ALL
SELECT *
FROM tabla2;

-- 3.  List all movies released in a specific year (e.g., 2020)

Select * from netflix_titles
where	type = 'Movie' AND release_year = 2020; 

-- 4.  Find the top 5 countries with the most content on Netflix

Select country, count(show_id) as NetflixCounts 
from netflix_titles
group by country
order by NetflixCounts DESC
limit 5;

-- 5.  Identify the longest movie

Select title, CAST(substring(duration,1,5) as UNSIGNED) AS DURATION
from netflix_titles
where type='movie'
ORDER BY CAST(substring(duration,1,5) as UNSIGNED) DESC
limit 1;

-- 6. Find content added in the last 5 years

Select date_added, 
	STR_TO_DATE(date_added,'%M %d, %Y') as data_added2, 
    year(STR_TO_DATE(date_added, '%M %d, %Y')) as data_added3 
from netflix_titles
where STR_TO_DATE(date_added,'%M %d, %Y') >= DATE_SUB(DATE('2021-09-01'), INTERVAL 5 YEAR)
order by data_added2 desc;

Select * from netflix_titles
where STR_TO_DATE(date_added,'%M %d, %Y') >= DATE_SUB(DATE('2021-09-01'), INTERVAL 5 YEAR)
order by STR_TO_DATE(date_added,'%M %d, %Y') desc;

-- 7.  Find all the movies/TV shows by director 'Rajiv Chilakanetflix_titles’!

Select * from netflix_titles
where director like '%Rajiv Chilaka%';

-- 8.  List all TV shows with more than 5 seasons

Select title, SUBSTRING_INDEX(duration,' ',1) AS seasons 
from netflix_titles
where type = 'TV Show' and CAST(SUBSTRING_INDEX(duration,' ',1)AS UNSIGNED) >5;

-- 9.  Count the number of content items in each genre

Select listed_in, count(*) count 
from netflix_titles
group by listed_in
order by count DESC;

-- 10. Find each year and the average numbers of content release in India on Netflix.
--     	return top 5 year with highest avg content release!

Select 
	year(STR_TO_DATE(date_added, '%M %d, %Y')) as year ,
	count(show_id) as content,
    count(show_id) / (select count(show_id) from netflix_titles where country like '%India%' )*100 as AVG_release
from netflix_titles
where country like '%India%'
group by year
order by content desc limit 5;

-- 11. List all movies that are documentaries

Select type, listed_in
from netflix_titles
where type = 'Movie' and listed_in like '%Documentaries%';

-- 12. Find all content without a director

Select  *
from netflix_titles
where director is NUll;

-- 13.  Find how many movies actor 'Salman Khan' appeared in last 10 years!

Select  *
from netflix_titles
where cast like '%Salman Khan%' and release_year > year(curdate())-15;

-- 14. 	Categorize the content based on the presence of the keywords 'kill' and 'violence’ 
-- in the description field. Label content containing these keywords as 'Bad' and all other content as 'Good'. 
-- Count how many items fall into each category.

WITH TableGoodOrBad AS (
  SELECT *,
	case
		when description like '%Kill%' then 'Bad_content'
        when description like '%violence%' then 'Bad_content'
		else 'Good_content'
	end as category
FROM netflix_titles)
SELECT category, count(*) as total_content
FROM TableGoodOrBad
group by category;

-- 15. Find the oldest movie or TV show on Netflix.
Select  *
from netflix_titles
where release_year = (select min(release_year) from netflix_titles);

-- 16. Find the shortest movie on Netflix.

SELECT * 
FROM 
	netflix_titles
WHERE 
	type='Movie' AND CAST(SUBSTRING_INDEX(duration,' ',1)AS UNSIGNED)=
	(SELECT MIN(CAST(SUBSTRING_INDEX(duration,' ',1)AS UNSIGNED)) AS durations
 FROM 
	netflix_titles
WHERE 
	type = 'Movie' );

-- 17. Calculate the total number of seasons for all TV shows combined.

SELECT 
	SUM(CAST(SUBSTRING_INDEX(duration,' ',1)AS UNSIGNED)) AS season_count
FROM netflix_titles
WHERE type = 'TV Show';

-- 18. Identify the average runtime for movies and TV shows.
SELECT 
	type, CASE 		
			WHEN type = 'Movie' THEN ROUND(AVG(SUBSTRING_INDEX(duration,' ',1)),2)	
		 END AS avg_runtime,	
	 	 CASE 		
			WHEN type = 'TV Show' THEN ROUND(AVG(SUBSTRING_INDEX(duration,' ',1)),2) 
		 END AS avg_season
FROM
	netflix_titles 
GROUP BY type;

-- 19. Calculate the ratio of movies to TV shows for each year.
SELECT 
	release_ year, T.movie_count, T.tv_show_count, ROUND((T.movie_count/T.tv_show_count),2) AS movie_to_tv_ratio
FROM 	
	(SELECT
		release_year, COUNT(CASE WHEN type = 'Movie' THEN 1 END) AS movie_count,			
		COUNT(CASE WHEN type = 'TV Show' THEN 1 END) AS tv_show_count	
	FROM
		 netflix_titles	
	GROUP BY 
		release_year) AS T                                                                                                                        
ORDER BY 
	release_year DESC;

-- 20. Calculate the average time gap between content additions on Netflix.
WITH day_diff 
AS  (SELECT 
		STR_TO_DATE(date_added,'%M %d, %Y') AS formated_date,		
		LAG(STR_TO_DATE(date_added,'%M %d, %Y')) OVER (ORDER BY STR_TO_DATE(date_added,'%M %d, %Y')) AS previous_date	
	FROM 
		netflix_titles    
	WHERE 
		date_added IS NOT NULL)
SELECT 
	AVG(DATEDIFF(formated_date, previous_date)) AS avg_gap_diff
FROM 
	day_diff
 WHERE 
	previous_date IS NOT NULL
