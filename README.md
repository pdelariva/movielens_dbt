🎬 Overview

This project implements a full end-to-end analytics pipeline for the MovieLens dataset using a modern data stack.
Raw CSV files are ingested into AWS S3, loaded into Snowflake, and transformed using dbt through staging, dimension, fact, and mart layers.
The final models are used to generate analytical SQL insights on movies, ratings, tags, and user behavior.


🏗️ Architecture

CSV files  
    ↓  
AWS S3 (Landing Zone)  
    ↓  
Snowflake (Raw Layer)  
    ↓  
dbt (Staging → Dimensions → Facts → Marts)  
    ↓  
Analytical SQL 


🧰 Technologies Used

AWS S3 – raw file ingestion

Snowflake – cloud data warehouse

dbt Cloud – transformation, modeling, documentation

GitHub – version control & CI/CD

SQL – analytical queries


🗂️ dbt Project Structure

models/
│
├── staging/
│     ├── stg_movies.sql
│     ├── stg_ratings.sql
│     ├── stg_tags.sql
│     └── ...
│
├── dim/
│     ├── dim_movies.sql
│     ├── dim_users.sql
│     └── dim_genome_tags.sql
│
├── fact/
│     ├── fct_ratings.sql
│     └── fct_genome_scores.sql
│
└── marts/
      ├── mart_tag_relevance.sql
      ├──...


Lineage Graph

<img width="1118" height="760" alt="image" src="https://github.com/user-attachments/assets/e93e41da-ef79-44e0-aca2-5324c1c5d05d" />


Example Analytical Query

A)

WITH ratings_summary AS (
    SELECT 
    movie_id,
    AVG(rating) AS average_rating,
    COUNT(*) AS total_ratings
FROM {{ref('fct_ratings')}}
GROUP BY movie_id
HAVING COUNT(*) > 100 -- Only movies with at least 100 ratings
)

SELECT
m.movie_title,
rs.average_rating,
rs.total_ratings
FROM ratings_summary rs
JOIN {{ ref('dim_movies')}} m ON m.movie_id = rs.movie_id
ORDER BY rs.average_rating DESC


b) 

SELECT
    t.tag_name,
    AVG(gs.relevance_score) AS avg_relevance,
    COUNT(DISTINCT gs.movie_id) AS movies_tagged
FROM {{ ref('fct_genome_scores') }} gs
JOIN {{ ref('dim_genome_tags') }} t ON gs.tag_id = t.tag_id
GROUP BY 1
ORDER BY avg_relevance DESC
LIMIT 20;


📈 Key Insights

Built clean staging, dimension, fact, and mart layers using dbt.

Generated analytical views for exploring movie popularity, tag relevance, and user activity.

Fully version-controlled with GitHub and documented via dbt Cloud


🧾 Dataset

This project uses the MovieLens public dataset (GroupLens Research).
https://grouplens.org/datasets/movielens/

📬 Author

Pablo De la Riva
Senior Data & Insights Analyst
LinkedIn: https://www.linkedin.com/in/pablo-d-0a1837127/


