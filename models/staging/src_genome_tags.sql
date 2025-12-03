with raw_genome_tags AS (
    SELECT * FROM MOVIELENS.raw.raw_genome_tags
)

SELECT
tagID AS tag_id,
tag
FROM raw_genome_tags