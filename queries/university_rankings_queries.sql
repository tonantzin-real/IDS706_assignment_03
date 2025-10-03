-- 1. Perform Basic Analysis 
-- Write SQL queries to explore the dataset, including basic statistics and summary operations.

SELECT * FROM university_rankings ur LIMIT 10;

-- General information
SELECT COUNT(DISTINCT country) AS n_countries,
	COUNT(DISTINCT institution) AS n_institutions,
	COUNT(DISTINCT year) AS n_years,
	MAX(score) AS max_score,
	MIN(score) AS min_score,
	AVG(score) AS avg_score
FROM university_rankings ur;

-- Information per country
SELECT country,
	COUNT(DISTINCT institution) AS n_institutions,
	MIN(score) AS min_score,
	MAX(score) AS max_score,
	MIN(world_rank) AS min_world_rank,
	MAX(world_rank) AS max_world_rank,
	COUNT(publications) AS n_publications,
	COUNT(citations) AS n_citations,
	COUNT(patents) AS n_patents
FROM university_rankings ur
GROUP BY country
ORDER BY max_score DESC
LIMIT 15;

-- Information about american and english universities
SELECT DISTINCT country, institution,
	MAX(score) OVER (PARTITION BY institution) AS max_score,
	MIN(score) OVER (PARTITION BY institution) AS min_score,
	AVG(world_rank) OVER (PARTITION BY institution) AS avg_world_rank,
	AVG(national_rank) OVER (PARTITION BY institution) AS avg_national_rank,
	AVG(alumni_employment) OVER (PARTITION BY institution) AS avg_alumni_employment,
	AVG(quality_of_faculty) OVER (PARTITION BY institution) AS avg_quality_of_faculty,
	MIN(publications) OVER (PARTITION BY institution) AS min_publications,
	MAX(publications) OVER (PARTITION BY institution) AS max_publications,
	MIN(citations) OVER (PARTITION BY institution) AS min_citations,
	MAX(citations) OVER (PARTITION BY institution) AS max_citations
FROM university_rankings ur
WHERE country IN ('USA', 'United Kingdom') 
ORDER BY score DESC
LIMIT 10;


-- 2. CRUD Operations
-- Perform the CRUD operations below. 

-- CREATE
SELECT * FROM university_rankings ur WHERE institution = 'Duke Tech' AND year = 2014;
INSERT INTO university_rankings (institution, country, world_rank,  score, year) VALUES 
('Duke Tech', 'USA', 350, 60.5, 2014);
SELECT * FROM university_rankings ur WHERE institution = 'Duke Tech' AND year = 2014;

-- READ
--SELECT YEAR, COUNT(*) AS N FROM university_rankings ur group by YEAR
SELECT country,
	COUNT(DISTINCT institution) AS n_institutions
FROM (
	SELECT country, institution
	FROM university_rankings
	WHERE year = 2013
	ORDER BY world_rank DESC
	LIMIT 200
	)
WHERE country = "Japan";

-- UPDATE
SELECT institution, score, year
FROM university_rankings
WHERE institution = 'University of Oxford'
	AND year = 2014;

UPDATE university_rankings
SET score = score + 1.2
WHERE institution = 'University of Oxford'
	AND year = 2014;

SELECT institution, score, year
FROM university_rankings
WHERE institution = 'University of Oxford'
	AND year = 2014;


-- DELETE
SELECT *
FROM university_rankings
WHERE score < 45
	AND year = 2015;

DELETE FROM university_rankings
WHERE score < 45
	AND year = 2015;

SELECT *
FROM university_rankings
WHERE score < 45
	AND year = 2015;
