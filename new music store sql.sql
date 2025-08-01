create database new_music_store;
use new_music_store;

-- albums
create table albums( album_id int, title text, artist_id varchar(10)
);

-- artist
create table artist( artist_id int,names varchar(255));

-- customer
create table customer ( customer_id int,first_name varchar(255),last_name varchar(255),company text,address varchar(255),
city varchar(255),state varchar(255),
country varchar(255),postal_code varchar(255),phone varchar(255),fax varchar(255) ,email varchar(255),support_rep_id int);

-- employee
create table employee ( employee_id int,last_name varchar(255),first_name varchar(255),title varchar(255),reports_to varchar(255),
levels varchar(255),birthdate varchar(255),hire_date varchar(255),address varchar(255),city varchar(255),
state varchar(255),country varchar(255),postal_code varchar(255),phone varchar(255),fax varchar(255),email varchar(255)
);

-- genre
create table genre ( genre_id int,name varchar(255));

-- invoice
create table invoice ( invoice_id int,customer_id int,invoice_date datetime,billing_address varchar(255),
billing_city varchar(255),billing_state varchar(255),billing_country varchar(255),billing_postal_code varchar(255),total int);

-- invoice line
create table invoice_line ( invoice_line_id int,invoice_id int,track_id bigint,unit_price float,quantity int);

-- media type
create table media_type ( media_type_id int,name varchar(255));

-- playlist
create table playlist ( playlist_id int,name varchar(255));

-- playlist track
create table playlist_track ( playlist_id bigint,track_id bigint);

-- track
create table track ( track_id int,name varchar(255),album_id int,media_type_id int,genre_id int,
composer varchar(255),milliseconds int,bytes int,unit_price float);



select * from albums;
select * from artist;
select * from customer;
select * from employee;
select * from genre;
select * from invoice;
select * from invoice_line;
select * from media_type;
select * from playlist;
select * from playlist_track;
select * from track;

drop table albums;

select count(*) from track;

select first_name, last_name, (first_name + last_name) as fullname from customer;

-- Task QUESTIONS
-- Q1 1. Who is the senior most employee based on job title? 
select title,levels from employee
order by levels desc
LIMIT 1;

-- Q2 2. Which countries have the most Invoices?
select count(invoice_id), billing_country from invoice
group by billing_country
order by count(invoice_id) desc;

-- Q3 What are the top 3 values of total invoice?
select total from invoice
order by total desc limit 3;

-- Q4  Which city has the best customers? - We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals
select city, count(invoice_id) as count_invoice
from customer c
join invoice i on i.customer_id=c.customer_id
group by city
order by count_invoice desc;

-- Q5 Who is the best customer? - The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money
select first_name,last_name ,count(total) from customer c join
invoice i on
c.customer_id=i.customer_id
group by first_name,last_name
order by count(total) desc;

-- Q6 Write a query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A
select  first_name,last_name, email from customer
where email like "%A";


-- Q7 Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands 
SELECT name, title, COUNT(t.track_id) AS total
FROM artist a
JOIN albums b ON a.artist_id = b.artist_id
JOIN track t ON b.album_id = t.album_id
WHERE lower(b.title) LIKE '%rock%'
GROUP BY name, title
ORDER BY total DESC;

 -- Q8 . Return all the track names that have a song length longer than the average song length. 
 -- Return the Name and Milliseconds for each track. Order by the song length, with the longest songs listed first
select name, milliseconds  from track
where milliseconds> (select avg(milliseconds) from track)
order by milliseconds desc;

-- Q9  Find how much amount is spent by each customer on artists? Write a query to return customer name, artist name and total spent
SELECT 
CONCAT(c.first_name, ' ', c.last_name) customer_name, ar.names, 
SUM(il.unit_price * il.quantity) AS total_spent from customer c
JOIN invoice i on i.customer_id = c.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN albums al ON t.album_id = al.album_id
JOIN artist ar ON al.artist_id = ar.artist_id
group by customer_name, ar.names
order by total_spent desc;


-- Q10  We want to find out the most popular music Genre for each country. 
-- We determine the most popular genre as the genre with the highest amount of purchases. 
-- Write a query that returns each country along with the top Genre. 
-- For countries where the maximum number of purchases is shared, return all Genres
-- Step 1: Count purchases per genre per country
with  genre_sales AS (
    SELECT 
        c.country,
        g.name AS genre,
        COUNT(il.invoice_line_id) AS purchase_count
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name
),
-- Step 2: Get the maximum purchase count per country
max_sales AS (
    SELECT 
        country,
        MAX(purchase_count) AS max_purchase
    FROM genre_sales
    GROUP BY country
)
-- Step 3: Join both to get top genre(s) per country
SELECT 
    gs.country,
    gs.genre,
    gs.purchase_count
FROM genre_sales gs
JOIN max_sales ms
  ON gs.country = ms.country AND gs.purchase_count = ms.max_purchase
ORDER BY gs.country;

-- Q11 Write a query that determines the customer that has spent the most on music for each country. 
-- Write a query that returns the country along with the top customer and how much they spent. -- 
-- For countries where the top amount spent is shared, provide all customers who spent this amount

select * from 
(
select c.first_name, c.country, sum(total) as total_amount_spent, 
rank()  over(partition by c.country order by sum(total) desc ) as rank1 
from customer c
join invoice i on i.customer_id = c.customer_id
group by c.first_name, c.country
) new1
where rank1 = 1;

