with raw_ratings AS (
    SELECT * FROM MOVIELENS.raw.raw_ratings
)

SELECT
userID AS user_id,
movieId AS movie_id,
rating,
TO_TIMESTAMP_LTZ(timestamp) AS rating_timestamp
FROM raw_ratings