SELECT * FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books` LIMIT 1000;

SELECT count(DISTINCT NAME) FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books` ;
SELECT count(DISTINCT Author) FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books` ;


--What is the average reviews by book name? 
SELECT name , CAST(AVG(Reviews)AS INT64) as AVG_Reviews 
FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books`
GROUP BY name
ORDER BY AVG_Reviews;


--Who are the top 10 authors based on user reviews number, and have a high rating?
SELECT AUTHOR , CAST(AVG(Reviews)AS INT64) as AVG_Reviews 
FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books`
WHERE `User Rating` >= 4.5
GROUP BY AUTHOR
ORDER BY AVG_Reviews DESC
LIMIT 10;


--What author released the latest book with highest rating?
SELECT AUTHOR , name as book_name , max(Year), `User Rating` as rating 
FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books`
group by AUTHOR , book_name ,  rating 
ORDER BY rating DESC
LIMIT 1;


--UPDATE To fix field
UPDATE `crafty-chiller-404311.SQL_Projects.BestSeller_Books` 
SET Author = 'J.K. Rowling' 
WHERE Author like 'J. K. Rowling'

--Average price of books per year
SELECT Year,  ROUND(avg(Price), 3) AS avg_price
FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books` 
GROUP BY Year
ORDER BY Year;

--Authors with the most books
SELECT Author, COUNT(*) AS book_count
FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books` 
GROUP BY Author
ORDER BY book_count DESC
LIMIT 5;

--Authors with more than 1 genre
SELECT Author, COUNT(DISTINCT Genre) AS distinct_genres
FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books` 
GROUP BY Author
HAVING COUNT(DISTINCT Genre) > 1
ORDER BY distinct_genres DESC;


--Books whose prices are above the average price of books within their respective genres:
SELECT b.Name, b.Author, b.Price, b.Genre, avg_genre_price.avg_price AS avg_genre_price
FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books`  as b
JOIN (
    SELECT Genre, ROUND(avg(Price), 3) AS avg_price
    FROM `crafty-chiller-404311.SQL_Projects.BestSeller_Books` 
    GROUP BY Genre
) AS avg_genre_price ON b.Genre = avg_genre_price.Genre
WHERE b.Price > avg_genre_price.avg_price
ORDER BY b.Price DESC;
