# Analyzing Netflix indrusty/ catalog

The following project present a brif analysis of netflix to determinate common  question about Netflix bussiness. 


The dataset cointain information in 12 columns.

| Column | Type |
| -------------------------------- | -----------------------------------|
| _Record_number | int |
| cast | varchar(771) |
| country | varchar(123) |
| date_added | varchar(18) |
| description | varchar(248) |
| director | varchar(208) |
| duration | varchar(10) |
| listed_in | varchar(79) |
| rating | varchar(8) |
| release_year | int |
| show_id | varchar(5) |
| title | varchar(104) |
| type | varchar(7) |
| | 

the objetives is analize Netflix data in two main characteristics movies and tv shows. The present work use SQL to extract information from dataset. The following questions present the Business problems.

1. Count the number of Movies vs TV Shows
2.  Find the most common rating for movies and TV shows
3.  List all movies released in a specific year (e.g., 2020)
4.  Find the top 5 countries with the most content on Netflix
5.  Identify the longest movie
6. Find content added in the last 5 years
7.  Find all the movies/TV shows by director 'Rajiv Chilaka'!
8.  List all TV shows with more than 5 seasons
9.  Count the number of content items in each genre
10. Find each year and the average numbers of content release in India on Netflix.      	return top 5 year with highest avg content release!
11. List all movies that are documentaries
12. Find all content without a director
13.  Find how many movies actor 'Salman Khan' appeared in last 10 years!
14. Categorize the content based on the presence of the keywords 'kill' and 'violence’ 	in the description field. Label content containing these keywords as 'Bad' and all 	other content as 'Good'. Count how many items fall into each category.
15. Find the oldest movie or TV show on Netflix.
16. Find the shortest movie on Netflix.
17. Calculate the total number of seasons for all TV shows combined.
18. Identify the average runtime for movies and TV shows.
19. Calculate the ratio of movies to TV shows for each year.
20. Calculate the average time gap between content additions on Netflix.

---------------------------------------
Approach:
--------------------------------------

# 1.Count the number of Movies vs TV Shows

### The SQL query:
~~~sql
select type, count(type) as NumberElemnts
from netflix_titles
group by type;
~~~

### The output table:
| type                     | NumberElements |
|--------------------------|----------------|
| Movie                    | 6131           |
| Tv Show                  | 2676           |
||

# 2.  Find the most common rating for movies and TV shows

### The SQL query option 1:
~~~sql
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

SELECT *
FROM tab1
UNION ALL
SELECT *
FROM tab2;

~~~

### The SQL query option 2:
~~~sql
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
~~~

### The output table:
| type                     | rating         | count(rating) |
|--------------------------|----------------|---------------|
| Movie                    | 6131           |     2062      |
| Tv Show                  | 2676           |     1145      |
||


# 3.  List all movies released in a specific year (e.g., 2020)

### The SQL query:
~~~sql
Select * from netflix_titles
where	type = 'Movie' AND release_year = 2020; 
~~~

### The output table:
| show_id |type | title | director | cast | Country | date_added | release_year | rating| duration| listed_in | description |
| ---- |--- | --- | --- | --- | --- | --- | --- |---| -----|----- | ---------- |
s1|Movie|"Dick Johnson Is Dead"|"Kirsten Johnson"|NULL|"United States"|"September 25, 2021"|2020|PG-13|"90 min"|Documentaries|"As her father nears the end of his life| filmmaker Kirsten Johnson stages his death in inventive and comical ways to help them both face the inevitable."|
s17|Movie|"Europe's Most Dangerous Man: Otto Skorzeny in Spain"|"Pedro de Echave GarcÃ­a, Pablo AzorÃ­n Williams"|NULL|NULL|"September 22, 2021"|2020|TV-MA|"67 min"|"Documentaries, International Movies"|"Declassified documents reveal the post-WWII..."
...
s79|Movie|"Tughlaq Durbar"|"Delhiprasad Deenadayalan"|"Vijay Sethupathi, Parthiban, Raashi Khanna"|NULL|"September 11, 2021"|2020|TV-14|"145 min"|"Comedies, Dramas, International Movies"|"A budding politician has devious plans ..."



# 4.  Find the top 5 countries with the most content on Netflix

### The SQL query:
~~~sql
Select country, count(show_id) as NetflixCounts 
from netflix_titles
group by country
order by NetflixCounts DESC
limit 5;
~~~

### The output table:
| Country                  | NetflixCounts |
|--------------------------|----------------|
| United States            | 2818           |
| India                    | 972           |
| Null                     | 831           |
| United Kingdom           | 419           |
| Japan                    | 245           |
||


# 5.  Identify the longest movie

### The SQL query:
~~~sql
Select title, CAST(substring(duration,1,5) as UNSIGNED) AS DURATION
from netflix_titles
where type='movie'
ORDER BY CAST(substring(duration,1,5) as UNSIGNED) DESC
limit 1;
~~~

### The output table:
| titlr                     | Duration      |
|--------------------------|----------------|
| Black Mirror: Bandersnatch                    | 312           |
||


# 6. Find content added in the last 5 years

### The SQL query:
~~~sql
Select * from netflix_titles
where STR_TO_DATE(date_added,'%M %d, %Y') >= DATE_SUB(DATE('2025-02-11'), INTERVAL 5 YEAR)
order by STR_TO_DATE(date_added,'%M %d, %Y') desc;
~~~

### The output table:
| show_id |type | title | director | cast | Country | date_added | release_year | rating| duration| listed_in | description |
| ---- |--- | --- | --- | --- | --- | --- | --- |---| -----|----- | ---------- |	
|s1|	Movie|	Dick Johnson Is Dead	|Kirsten Johnson	| Null	|United States |	September 25, 2021	|2020|	PG-13|	90 min|	Documentaries|	As her father nears the end of his life, ...|
.......
||

# 7.  Find all the movies/TV shows by director 'Rajiv Chilaka'!

### The SQL query:
~~~sql
Select * from netflix_titles
where director like '%Rajiv Chilaka%';
~~~

### The output table:
| show_id |type | title | director | cast | Country | date_added | release_year | rating| duration| listed_in | description |
| ---- |--- | --- | --- | --- | --- | --- | --- |---| -----|----- | ---------- |	
|s407|	Movie|	Chhota Bheem - Neeli Pahaadi  | Rajiv Chilaka	| Vatsal Dubey, , ...	| Null |	July 22, 2021	|2013| TV-Y7 | 64 min|	Children & Family Movies|	Things get spooky when Bheem , ...|
.......
||


# 8.  List all TV shows with more than 5 seasons

### The SQL query:
~~~sql
Select title, SUBSTRING_INDEX(duration,' ',1) AS seasons 
from netflix_titles
where type = 'TV Show' and CAST(SUBSTRING_INDEX(duration,' ',1)AS UNSIGNED) >5;
~~~

### The output table:
| title                     | Seasons |
|--------------------------|----------------|
| 	The Great British Baking Show |	9 |
|	Nailed It	|6|
|	Numberblocks	|6|
|	Saved by the Bell	|9|
|	Lucifer	|6|
|	Grace and Frankie	|7|
|	30 Rock	|7|
|	Hunter X Hunter (2011)	|6|
|	The Flash	|7|
|	The Walking Dead	|10|
|	My Little Pony: Friendship Is Magic |	8|
|	Orange Is the New Black	|7|
|	Terrace House: Opening New Doors|	6|
||


# 9.  Count the number of content items in each genre

### The SQL query:
~~~sql
Select listed_in, count(*) count 
from netflix_titles
group by listed_in
order by count DESC;
~~~

### The output table:
| listed_in                | count          |
|--------------------------|----------------|
| Dramas, International Movies	|362|
|Documentaries	|359|
|Stand-Up Comedy	|334|
|Comedies, Dramas, International Movies	|274|
|Dramas, Independent Movies, International Movies	|252|
|Kids' TV	|220|
|Children & Family Movies	|215|
|Children & Family Movies, Comedies	|201|
|Documentaries, International Movies	|186|
|Dramas, International Movies, Romantic Movies	|180|
||


# 10. Find each year and the average numbers of content release in India on Netflix.      	return top 5 year with highest avg content release!

### The SQL query:
~~~sql
Select 
	year(STR_TO_DATE(date_added, '%M %d, %Y')) as year ,
	count(show_id) as content,
    count(show_id) / (select count(show_id) from netflix_titles where country like '%India%' )*100 as AVG_release
from netflix_titles
where country like '%India%'
group by year
order by content desc limit 5;
~~~

### The output table:
| year                     | Content        | AVG_release |
|--------------------------|----------------|-------------|
| 2017	| 162	|15.4876|
| 2018	| 349   |33.3652|
| 2019	| 218	|20.8413|
| 2020	| 199	|19.0249|
| 2021	| 105	|10.0382|
||


# 11. List all movies that are documentaries

### The SQL query:
~~~sql
Select type, listed_in
from netflix_titles
where type = 'Movie' and listed_in like '%Documentaries%';
~~~

### The output table:
| type                     | listed_in      |
|--------------------------|----------------|
|Movie|	Documentaries|
Movie	|Documentaries, International Movies
Movie	|Documentaries|
Movie	|Documentaries, International Movies, Sports Movies
Movie	|Documentaries, Sports Movies
Movie	|Documentaries, International Movies
Movie	|Documentaries, Music & Musicals
Movie	|Documentaries, Sports Movies
Movie	|Documentaries|
||


# 12. Find all content without a director

### The SQL query:
~~~sql
Select  type,title, director
from netflix_titles
where director is NUll;
~~~

### The output table:
| type                     | NumberElements | Director |
|--------------------------|----------------|----------|
|           TV Show        |	Blood & Water	 | NULL
|          TV Show         |Jailbirds New Orleans|	NULL
|          TV Show         |Kota Factory	     | NULL
|          TV Show         |Vendetta: Truth, Lies and The Mafia| NULL	
|          TV Show         |Crime Stories: India Detectives	| NULL
|          TV Show         |Dear White People	  | NULL
||


# 13.  Find how many movies actor 'Salman Khan' appeared in last 10 years!

### The SQL query:
~~~sql
Select  *
from netflix_titles
where cast like '%Salman Khan%' and release_year > year(curdate())-15;
~~~

### The output table:
| show_id |type | title | director | cast | Country | date_added | release_year | rating| duration| listed_in | description |
| ---- |--- | --- | --- | --- | --- | --- | --- |---| -----|----- | ---------- |	
|s1675|	Movie|	Bodyguard  | Siddique	| Salman Khan, ...	| India |	November 19, 2020	|2012| TV-14 | 130 min|	Action & Adventure, Comedies, International Movies|	Irked by her bodyguard, an heiress invents , ...|
.......
||


# 14. Categorize the content based on the presence of the keywords 'kill' and 'violence’ 	in the description field. Label content containing these keywords as 'Bad' and all 	other content as 'Good'. Count how many items fall into each category.

### The SQL query:
~~~sql
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
~~~

### The output table:
| category                    | Total_content |
|--------------------------|----------------|
| Good_content  |	8465|
|Bad_content	|    342|
||


# 15. Find the oldest movie or TV show on Netflix.

### The SQL query:
~~~sql
Select  *
from netflix_titles
where release_year = (select min(release_year) from netflix_titles);
~~~

### The output table:
| show_id |type | title | director | cast | Country | date_added | release_year | rating| duration| listed_in | description |
| ---- |--- | --- | --- | --- | --- | --- | --- |---| -----|----- | ---------- |	
|s4251|	TV Show| Pioneers: First Women Filmmakers*  | NULL	| NULL	| NULL |	December 30, 2018 | 1925 | TV-14 | 1 season | TV Shows |	This collection restores films , ...|
.......
||


# 16. Find the shortest movie on Netflix.

### The SQL query:
~~~sql
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
~~~

### The output table:
| show_id |type | title | director | cast | Country | date_added | release_year | rating| duration| listed_in | description |
| ---- |--- | --- | --- | --- | --- | --- | --- |---| -----|----- | ---------- |	
|s3778|	Movie | Silent  | Limbert Fabian, Brandon Oldenburg	| NULL	| United States | June 4, 2019 | 2014 | TV-Y | 3 min | Children & Family Movies, Sci-Fi & Fantasy |	Silent" is an animated short film  , ...|
.......
||

# 17. Calculate the total number of seasons for all TV shows combined.

### The SQL query:
~~~sql
SELECT 
	SUM(CAST(SUBSTRING_INDEX(duration,' ',1)AS UNSIGNED)) AS season_count
FROM netflix_titles
WHERE type = 'TV Show';
~~~

### The output table:
| season_count             |
|--------------------------|
| 4723                    | 
||


# 18. Identify the average runtime for movies and TV shows.

### The SQL query:
~~~sql
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
~~~

### The output table:
| type                     | avg_runtime    | avg_season     |
|--------------------------|----------------|----------------| 
| Movie                    | 99.58          | NULL           |
| Tv Show                  | NULL           | 1.76           |
||


# 19. Calculate the ratio of movies to TV shows for each year.

### The SQL query:
~~~sql
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
~~~

### The output table:


# 20. Calculate the average time gap between content additions on Netflix.

### The SQL query:
~~~sql
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
~~~

### The output table:
| avg_gap_diff             |
|--------------------------|
| 0.5703           |
||

