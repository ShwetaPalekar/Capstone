-- 

-- Checking the number of paintings that were not displayed at any musesums
SELECT Count(*) as 'Number of paintings not displayed at any museum'
FROM work
WHERE museum_id = 0;

-- Checking the number of paintings that were displayed at any musesums
SELECT  museum_id, Count(*) as 'Number of paintings  displayed at any museum' 
FROM work 
    WHERE museum_id <> 0
group by  museum_id
order by 2 desc   ;

-- Checking the number of museums that did not have any paintings displayed
SELECT Count(*) as 'Number of museums without any paintings'
FROM museum AS m
LEFT JOIN work AS w
    ON m.museum_id = w.museum_id
    WHERE w.museum_id =0;
    
    
-- Checking the number of paintings that have an asking price which more than their regular price?
SELECT
    COUNT(*) AS 'Number of  paintings have an asking price which more than their regular price'
FROM product_size
WHERE sale_price > regular_price;



-- Identify the paintings whose asking price is less than 50% of its regular price
SELECT *
FROM product_size
WHERE sale_price < (0.50 * regular_price) 
order by regular_price desc
limit 15;

-- Checking the top 10 most famous painting subject
SELECT subject,
COUNT(*) AS nr_of_paintings
FROM subject
GROUP BY 1
ORDER BY nr_of_paintings DESC
limit 10;

-- Identify the museums which are open on both Sunday and Saturday.
SELECT mh.museum_id,m.name, m.country
FROM museum_hours mh
JOIN museum m ON mh.museum_id = m.museum_id
WHERE day IN ('Sunday', 'Saturday')
GROUP BY m.name,  m.country, mh.museum_id
HAVING COUNT( day) = 2
ORDER BY mh.museum_id
LIMIT 10;

-- Identify the museums which are open on weekdays.
SELECT mh.museum_id,m.name, m.country
FROM museum_hours mh
JOIN museum m ON mh.museum_id = m.museum_id
WHERE day IN ( 'Monday','Tuesday','Wednesday','Thursday','Friday')
GROUP BY m.name,  m.country, mh.museum_id
HAVING COUNT( day) = 5
ORDER BY mh.museum_id;

--  Identify the museums which are open on all days.
 SELECT mh.museum_id,m.name, m.country
FROM museum_hours mh
JOIN museum m ON mh.museum_id = m.museum_id
WHERE day IN ( 'Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday')
GROUP BY m.name,  m.country, mh.museum_id
HAVING COUNT( day) = 7
ORDER BY mh.museum_id; 

-- Identify the museums with most number of paintings
select m.museum_id, m.name, count(*) as no_of_painting FROM museum m
JOIN work w
ON m.museum_id = w.museum_id
group by m.museum_id, m.name
order by count(*) desc Limit 5;

-- Identify the museums with least number of paintings
select m.museum_id, m.name, count(*) as no_of_painting FROM museum m
JOIN work w
ON m.museum_id = w.museum_id
group by m.museum_id, m.name
order by count(*) Limit 5;

 -- Identify the artists with most number of paintings 
select artist.full_name, artist.nationality, count(*) as number_of_paintings
FROM artist 
JOIN work 
ON artist.artist_id = work.artist_id
group by artist.full_name, artist.nationality
order by count(*) desc
limit 5;  

-- Identify the artists whose paintings are displayed in multiple countries.
select artist.full_name,work.style,museum.country, count(*) as number_of_paintings
from artist
join work
on artist.artist_id=work.artist_id
join museum
on museum.museum_id=work.museum_id
group by artist.full_name, work.style,museum.country
order by count(*) desc
limit 10;

-- Checking the least popular museums based on number of paintings
SELECT 
    w.museum_id,
    COUNT(w.museum_id) AS no_of_painting
FROM work AS w 
where w.museum_id <>0
GROUP BY 1
ORDER BY count(*) asc , museum_id
limit 5  ;

--  Checking the country with most number of museums. 
SELECT 
    m.country,
    COUNT(m.museum_id) AS no_of_museums
From museum AS m
GROUP BY 1
ORDER BY count(*) desc;

-- Identify the artist and the museum where the most expensive and least expensive painting is placed. 
-- Display the artist name, sale_price, painting name, museum name, museum city and canvas label

select artist.full_name, artist.style,product_size.sale_price,museum.name,museum.city,
'Least Expensive ' as remark
from artist 
JOIN work 
 ON artist.artist_id= work.artist_id
JOIN museum 
 ON museum.museum_id = work.museum_id
JOIN product_size 
 ON product_size.work_id= work.work_id
where work.museum_id <> 0
ORDER BY product_size.sale_price asc
limit 5;

select artist.full_name, artist.style,product_size.sale_price,museum.name,museum.city,
'Most Expensive ' as remark
from artist 
JOIN work 
 ON artist.artist_id= work.artist_id
JOIN museum 
 ON museum.museum_id = work.museum_id
JOIN product_size 
 ON product_size.work_id= work.work_id
 JOIN canvas_size
ON canvas_size.size_id = product_size.size_id
where work.museum_id <> 0
ORDER BY product_size.sale_price desc
limit 5;


-- Identify the museum which is open for the longest during a day?
SELECT   distinct museum.name,museum.country, museum_hours.day,(museum_hours.close - museum_hours.open) as "museum_hours_duration"
FROM museum_hours
JOIN museum
ON museum.museum_id=museum_hours.museum_id
 ORDER BY (museum_hours.close-museum_hours.open) desc limit 15;

-- Identify the museum which is open for the shortest during a day?
SELECT   distinct museum.name,museum.country, museum_hours.day,(museum_hours.close - museum_hours.open) as "museum_hours_duration"
FROM museum_hours
JOIN museum
ON museum.museum_id=museum_hours.museum_id
 ORDER BY (museum_hours.close-museum_hours.open) asc limit 15;
 
 
 -- Identify the 5 most popular and 5 least popular painting styles.
 select style ,count(*) as no_of_paintings, 'most_famous_paintings' from work
group by style
order by count(*) desc
limit 5;

select style ,count(*) as no_of_paintings, 'less_famous_paintings' from work
group by style
order by count(*) asc
limit 5;
