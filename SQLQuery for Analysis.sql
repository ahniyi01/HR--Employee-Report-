--REQUIREMENTS

-- 1. What is the gender breakdown of employees in the company?	
SELECT gender, COUNT (*) AS count
FROM [Tutorial].[dbo].[Human_Resources]
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, COUNT (*) AS count
FROM [Tutorial].[dbo].[Human_Resources]
WHERE age >= 18 AND termdate IS NULL
GROUP BY race

-- 3. What is the age distribution of employees in the company?
SELECT 
MIN(age) AS youngest,
MAX(age) AS oldest 
FROM [Tutorial].[dbo].[Human_Resources]
WHERE age >= 18 AND termdate IS NULL

-- To get the age distribution
SELECT
    CASE
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS count
FROM [Tutorial].[dbo].[Human_Resources]
WHERE age >= 18 AND termdate is NULL
GROUP BY
    CASE
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END;

-- To get the age distribution by Department 
SELECT
    CASE
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS age_group, gender, 
    COUNT(*) AS count
FROM [Tutorial].[dbo].[Human_Resources]
WHERE age >= 18 AND termdate is NULL
GROUP BY
    CASE
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END, gender
	ORDER BY age_group;


-- 4. How many employees work at headquarters versus remote locations?
SELECT location, COUNT(*) AS count
FROM [Tutorial].[dbo].[Human_Resources]
WHERE age >= 18 AND termdate IS NULL
GROUP BY location


-- 5. What is the average length of employment for employees who have been terminated? 
SELECT ROUND(AVG(DATEDIFF(DAY, termdate, hire_date) / 365.0), 0) AS avg_length_employment
FROM [Tutorial].[dbo].[Human_Resources]
WHERE termdate <= GETDATE() AND termdate IS NOT NULL AND age >= 18;


-- 6. How does the gender distribution vary across departments and job titles?
SELECT department, gender, COUNT (*) AS count
FROM [Tutorial].[dbo].[Human_Resources]
WHERE age >= 18 AND termdate IS NULL
GROUP BY department, gender
ORDER BY department

-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, COUNT (*) AS count
FROM [Tutorial].[dbo].[Human_Resources]
WHERE age >= 18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY COUNT;

--8. Which department has the highest turnover rate?
WITH subquery AS (
    SELECT department,
        COUNT(*) AS total_count,
        SUM(CASE WHEN termdate <= GETDATE() AND termdate IS NOT NULL THEN 1 ELSE 0 END) AS terminated_count
    FROM [Tutorial].[dbo].[Human_Resources]
    WHERE age >= 18
    GROUP BY department
)
SELECT department,
    total_count,
    terminated_count,
    CAST(terminated_count AS FLOAT) / total_count AS termination_rate
FROM subquery
ORDER BY termination_rate;

-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state, COUNT(*) AS count
FROM [Tutorial].[dbo].[Human_Resources]
WHERE age >= 18
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT 
    [year],
    hires,
    terminations,
    hires - terminations AS net_change,
    ROUND((hires - terminations) * 100.0 / NULLIF(hires, 0), 2) AS net_change_percent
FROM (
    SELECT
        YEAR(hire_date) AS [year],
        COUNT(*) AS hires,
        SUM(CASE WHEN termdate <= GETDATE() AND termdate IS NOT NULL  THEN 1 ELSE 0 END) AS terminations
    FROM [Tutorial].[dbo].[Human_Resources]
    WHERE age >= 18
    GROUP BY YEAR(hire_date)
) AS subquery
ORDER BY [year] ASC;


-- 11. What is the tenure distribution for each department?
SELECT round(avg(datediff(DAY, termdate, hire_date)/365),0) AS avg_tenure
FROM [Tutorial].[dbo].[Human_Resources]
WHERE termdate <= GETDATE() AND termdate IS NOT NULL AND age >= 18
GROUP BY department;

