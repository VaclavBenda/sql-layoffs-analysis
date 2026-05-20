-- Rolling total of layoffs over time
WITH monthly_total AS (
	SELECT 
		DATETRUNC(MONTH, [date]) AS month_date,
		SUM(total_laid_off) AS total_layoffs
	FROM silver.layoffs
	WHERE [date] IS NOT NULL 
   AND total_laid_off IS NOT NULL
	GROUP BY DATETRUNC(MONTH, [date])
)
SELECT 
	month_date,
	total_layoffs, 
	SUM(total_layoffs) OVER(ORDER BY month_date) AS monthly_rolling
FROM monthly_total
ORDER BY month_date;
