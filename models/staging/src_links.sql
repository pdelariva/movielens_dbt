with raw_links AS (
    SELECT * FROM MOVIELENS.raw.raw_links
)

SELECT
movieId AS movie_id,
imdbID AS idmb_id,
tmdbId as tmdb_id
FROM raw_links