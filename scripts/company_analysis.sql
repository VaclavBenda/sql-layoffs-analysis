-- Top companies by total layoffs
SELECT 
	company, 
	SUM(total_laid_off) AS total_laid_off 
FROM silver.layoffs
GROUP BY company
ORDER BY total_laid_off DESC;

-- Top companies within each year
WITH yearly_layoffs_cte AS (
	SELECT 
		company, 
		SUM(total_laid_off) AS total_layoffs, 
		YEAR([date]) AS year_date
	FROM silver.layoffs
	WHERE [date] IS NOT NULL AND total_laid_off IS NOT NULL
	GROUP BY YEAR([date]), company
),
ranking_cte AS (
	SELECT 
		company, 
		total_layoffs, 
		year_date,
		RANK() OVER(PARTITION BY year_date ORDER BY total_layoffs DESC) AS highest_layoff 
	FROM yearly_layoffs_cte
)
SELECT 
  company, 
  total_layoffs, 
  year_date 
FROM ranking_cte
WHERE highest_layoff = 1
ORDER BY year_date, total_layoffs DESC;
