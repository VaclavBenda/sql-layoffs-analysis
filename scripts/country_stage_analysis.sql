-- Top countries affected by layoffs
SELECT 
	country, 
	SUM(total_laid_off) AS total_laid_off 
FROM silver.layoffs
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_laid_off DESC;

-- Top stages of companies affected by layoffs
SELECT 
	stage, 
	SUM(total_laid_off) AS total_laid_off 
FROM silver.layoffs
WHERE NULLIF(stage, 'NULL') IS NOT NULL
 AND total_laid_off IS NOT NULL
GROUP BY stage
ORDER BY total_laid_off DESC;

-- Layoffs by country and industry
SELECT 
	country, 
	industry,
	SUM(total_laid_off) AS total_laid_off
FROM silver.layoffs
WHERE industry IS NOT NULL 
  AND country IS NOT NULL
  AND total_laid_off IS NOT NULL
GROUP BY country, industry
ORDER BY total_laid_off DESC, country, industry;
