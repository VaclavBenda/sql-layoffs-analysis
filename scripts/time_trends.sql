-- Total layoffs over time (yearly)
SELECT 
	YEAR([date]) AS year_date, 
	SUM(total_laid_off) AS total_layoffs 
FROM silver.layoffs
WHERE [date] IS NOT NULL 
  AND total_laid_off IS NOT NULL
GROUP BY YEAR([date])
ORDER BY year_date;

-- Total layoffs over time (monthly)
SELECT 
	DATETRUNC(MONTH, [date]) AS month_date, 
	SUM(total_laid_off) AS total_layoffs
FROM silver.layoffs
WHERE [date] IS NOT NULL 
  AND total_laid_off IS NOT NULL
GROUP BY DATETRUNC(MONTH, [date])
ORDER BY month_date;

-- Highest monthly layoffs
SELECT 
	DATETRUNC(MONTH, [date]) AS month_date,
	SUM(total_laid_off) AS total_layoffs,
	MAX(total_laid_off) AS highest_monthly_layoffs
FROM silver.layoffs
WHERE [date] IS NOT NULL 
  AND total_laid_off IS NOT NULL
GROUP BY DATETRUNC(MONTH, [date])
ORDER BY total_layoffs DESC, month_date;

