# Music-Store-Database-Analysis

## Project Overview
This project involves designing a database for a digital Music Store and running a series of analytical SQL queries to extract meaningful business insights. The dataset represents a fictional music store with information about customers, employees, tracks, invoices, genres, and more.

The goal of the project is to answer real-world business questions using SQL, helping stakeholders make informed decisions such as identifying top customers, understanding buying behavior, and planning promotions.

## Technologies Used
SQL (MySQL syntax)

Database: Structured relational database using tables and foreign key relationships

## Database Schema
The following tables were created and used:

albums

artist

customer

employee

genre

invoice

invoice_line

media_type

playlist

playlist_track

track

Each table stores a specific entity, and they are related via foreign keys to allow normalized and efficient queries.

## Key Learnings
Writing complex queries using JOIN, GROUP BY, ORDER BY, and subqueries.

Using window functions like RANK() for partitioned ranking tasks.

Understanding how to normalize data and utilize relational databases for real-world scenarios.

Applying analytical thinking to answer business questions using SQL.

music-store-sql-analysis ├── 📄 schema.sql # All table creation scripts ├── 📄 queries.sql # All analytical queries └── 📄 README.md # Project documentation (this file)

## Conclusion
This project demonstrates the power of SQL in uncovering valuable business insights from structured data. By designing and querying a comprehensive music store database, we explored real-world use cases such as identifying top customers, analyzing genre popularity across countries, and understanding revenue distribution.

From simple aggregations to advanced window functions and subqueries, this project showcases how SQL can answer critical questions that drive data-informed decisions. Whether it's planning a promotional event or understanding customer preferences, these insights can help businesses in the music industry optimize strategies and improve customer experience.

Overall, this project not only strengthens SQL skills but also highlights how data analysis can directly impact business outcomes in a digital-first world.
