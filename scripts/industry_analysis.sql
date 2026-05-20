-- Top industries affected by layoffs
SELECT 
	industry, 
	SUM(total_laid_off) AS total_laid_off 
FROM silver.layoffs
WHERE industry IS NOT NULL
 AND total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY total_laid_off DESC;

-- Top industries within each year
WITH yearly_layoffs_cte AS (
	SELECT 
		industry,
		YEAR([date]) AS year_date, 
		SUM(total_laid_off) AS total_layoffs
	FROM silver.layoffs
	WHERE [date] IS NOT NULL 
	 AND total_laid_off IS NOT NULL
	 AND industry IS NOT NULL
	GROUP BY YEAR([date]), industry
), 
ranking_cte AS (
	SELECT 
		industry, 
		year_date, 
		total_layoffs,
		RANK() OVER(PARTITION BY year_date ORDER BY total_layoffs DESC) AS highest_layoff
	FROM yearly_layoffs_cte
)
SELECT 
	industry, 
	year_date, 
	total_layoffs 
FROM ranking_cte
WHERE highest_layoff = 1
ORDER BY year_date, total_layoffs DESC;


