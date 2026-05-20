-- Percentage laid off vs total laid off
SELECT 
	company, 
	total_laid_off,
	percentage_laid_off 
FROM silver.layoffs
WHERE total_laid_off IS NOT NULL 
 AND percentage_laid_off IS NOT NULL
ORDER BY percentage_laid_off DESC, total_laid_off DESC;

-- Companies with 100% layoffs
SELECT 
	company,
	percentage_laid_off
FROM silver.layoffs
WHERE percentage_laid_off = 1
ORDER BY company;
