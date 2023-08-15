-- Comments in SQL Start with dash-dash --
--Query--
-- ####################################################################
-- # Basic SELECT statement
-- # See https://www.ibm.com/docs/en/db2-for-zos/13?topic=statements-select for complete syntax.
-- ####################################################################
SELECT *
    FROM analytics;

--1. Find the entire record for the app with an ID of `1880`
SELECT * FROM analytics WHERE id = 1880;

--2. Find the ID and app name for all apps that were last updated on August 01, 2018.--
-- ####################################################################
-- # Basic SELECT statement
-- # See https://www.ibm.com/docs/en/db2-for-zos/13?topic=statements-select for complete syntax.
-- ####################################################################
SELECT Id, app_name
    FROM analytics
    WHERE last_updated = '2018-08-01';

--3. Count the number of apps in each category, e.g. “Family | 1972”.--
-- ####################################################################
-- # Basic SELECT statement
-- # See https://www.ibm.com/docs/en/db2-for-zos/13?topic=statements-select for complete syntax.
-- ####################################################################
SELECT category, COUNT(*) FROM analytics
    GROUP BY category;

-- 4. Find the top 5 most-reviewed apps and the number of reviews for each.
SELECT * FROM analytics
    ORDER BY reviews DESC 
    LIMIT 5;

--5. Full record of app that has the most rewiews with a rating greater than or equal to 4.8--
-- ####################################################################
-- # Basic SELECT statement
-- # See https://www.ibm.com/docs/en/db2-for-zos/13?topic=statements-select for complete syntax.
-- ####################################################################
SELECT *
    FROM analytics
    WHERE rating >=4.8
        ORDER BY reviews DESC 
        LIMIT 1;

--6. AVG RATING FOR EACH CATEGORY ORDERED BY THE HIGHST RATED TO LOWEST RATED--
SELECT category, AVG(rating) FROM analytics
    GROUP BY category
    ORDER BY avg DESC;

--7. FIND the name, price, and rating of the most expensive app with a rating that’s less than 3--
SELECT app_name, price, rating FROM analytics
    where rating <3
    order by price desc 
    limit 1;

--8. Find all records with a min install not exceeding 50, that have a rating. 
--      Order your results by highest rated first.
SELECT * FROM analytics
WHERE MIN_INSTALLS <=50
AND rating IS NOT NULL
ORDER BY rating DESC;  

--9. FIND THE NAMES OF ALL APPS THAT ARE RATED LESS THAN 3 WITH AT LEAST 10000 REVIEWS--
SELECT app_name FROM analytics 
WHERE rating < 3 AND reviews >=10000;

--10; Find the top 10 most reviewed apps that cost between 10 cents and a dollar--
SELECT * FROM analytics
    WHERE price BETWEEN 0.1 AND 1
    ORDER BY reviews DESC 
    LIMIT 1;


--11. FIND THE OUT OF DATE APP
SELECT * FROM analytics
ORDER BY last_updated LIMIT 1;

--12. FIND THE MOST EXPENSIVE APP --
SELECT * FROM analytics
ORDER BY price DESC LIMIT 1;

--13. COUNT ALL REVIEWS IN THE PLAY STORE
SELECT SUM (reviews) AS "All reviews" FROM analytics;

--14. ALL CATEGORIES WITH MORE THAN 300 APPS
SELECT category FROM analytics
    GROUP BY  category
    HAVING COUNT (*) > 300;

--15. FIND APP THAT HAS THE HIGHEST PROPORTION OF MIN_INSTALLS TO REVIEWS, AMMONG APPS THAT HAVE BEEN INSTALLED AT LEAST 100000.
-- DISPLAY NAME OF APP ALONG WITH THE NUMBER OF REVIEWS, THE MIN_INSTALLS, AND THE PROPORTION
SELECT app_name, reviews, min_installs, min_installs / reviews AS proportion
    FROM analytics
    WHERE min_installs >= 100000
    ORDER BY proportion DESC 
    LIMIT 1;