-- Highly funded companies with major layoffs
SELECT 
	company, 
	SUM(total_laid_off) AS total_layoffs, 
	MAX(funds_raised_millions) AS highest_fundings 
FROM silver.layoffs
WHERE [date] IS NOT NULL 
 AND total_laid_off IS NOT NULL 
 AND funds_raised_millions IS NOT NULL
GROUP BY company
ORDER BY highest_fundings DESC, total_layoffs DESC;

-- Top 10 companies by layoffs
WITH company_cte AS (
	SELECT 
		company,
		SUM(total_laid_off) AS total_layoffs
	FROM silver.layoffs
	WHERE total_laid_off IS NOT NULL
	 AND company IS NOT NULL
	GROUP BY company
),
ranking_cte AS (
	SELECT 
		company, 
		total_layoffs, 
		RANK() OVER(ORDER BY total_layoffs DESC) AS total_ranking
	FROM company_cte
)
SELECT 
	company, 
	total_layoffs
FROM ranking_cte
WHERE total_ranking <= 10
ORDER BY total_layoffs DESC, company;

-- Top 10 industries by layoffs
WITH industry_cte AS (
	SELECT 
		industry, 
		SUM(total_laid_off) AS total_layoffs 
	FROM silver.layoffs
	WHERE total_laid_off IS NOT NULL
	 AND industry IS NOT NULL
	GROUP BY industry
),
ranking_cte AS (
	SELECT 
		industry, 
		total_layoffs, 
		RANK() OVER(ORDER BY total_layoffs DESC) AS total_ranking 
	FROM industry_cte
	)
SELECT 
	industry, 
	total_layoffs 
FROM ranking_cte
WHERE total_ranking <= 10
ORDER BY total_layoffs DESC, industry;

-- Top 10 countries by layoffs
WITH country_cte AS (
	SELECT 
		country, 
		SUM(total_laid_off) AS total_layoffs 
	FROM silver.layoffs
	WHERE total_laid_off IS NOT NULL
	 AND country IS NOT NULL
	GROUP BY country
),
ranking_cte AS (
	SELECT
		country,
		total_layoffs,
		RANK() OVER(ORDER BY total_layoffs DESC) AS total_ranking
	FROM country_cte
)
SELECT
	country,
	total_layoffs
FROM ranking_cte
WHERE total_ranking <= 10
ORDER BY total_layoffs DESC, country;
