use company_data;
select * from `malli nandhini - layoffs (1)`;

-- 1.  Find the total number of layoffs per month and identify which month had the highest layoffs.

select
	date_format(date,'%Y-%m') as month,
    SUM(total_laid_off) as total_layoffs
from `malli nandhini - layoffs (1)`
group by month
order by total_layoffs desc;

-- 2.  Which companies had 1 which is basically 100 percent of they company laid off,find them

select 
	company,
    location,
    industry,
    total_laid_off,
    percentage_laid_off
from `malli nandhini - layoffs (1)`
where percentage_laid_off = 1;

-- 3. if we order by funcs_raised_millions we can see how big some of these companies were,find out

select
	company,
    location,
    industry,
    total_laid_off,
    percentage_laid_off,
    funds_raised_millions
from `malli nandhini - layoffs (1)`
where percentage_laid_off = 1
order by funds_raised_millions desc;

-- 4. Companies with the biggest single Layoff

select
	company,
    location,
    industry,
    total_laid_off,
    percentage_laid_off,
    funds_raised_millions,
    country,
    date
from `malli nandhini - layoffs (1)`
order by total_laid_off desc
limit 20;

-- 5. Companies with the most Total Layoffs -- by company

select 
	company,
    sum(total_laid_off) as total_layoffs
from `malli nandhini - layoffs (1)`
group by company 
order by total_laid_off desc
limit 10;

-- 6. Which 5 countries had the highest total layoffs overall?

select 
	country,
    sum(total_laid_off) as total_layoffs
from `malli nandhini - layoffs (1)`
group by country
order by total_layoffs desc
limit 5;

-- 7. Find the average and total layoffs grouped by stage (e.g., Seed, Series A, Series B, etc.).

select
	stage,
    sum(total_laid_off) as total_layoffs,
    avg(total_laid_off) as average_layoffs
from `malli nandhini - layoffs (1)`
group by stage
order by total_layoffs desc;

-- 8. Which locations had more than 5 companies experiencing layoffs, and what was their combined total layoffs? (Concepts: GROUP BY, HAVING, COUNT, SUM)

select
	location,
    count(distinct company) as company_count,
    sum(total_laid_off) as total_layoffs
from `malli nandhini - layoffs (1)`
group by location
having count(distinct company) > 5
order by total_layoffs desc;

-- 9.For each industry, calculate the average funds raised per laid-off employee (funds_raised_millions / total_laid_off).Which industries appear to have the highest ratio?

select
	industry,
    sum(funds_raised_millions) as total_funds_raised,
    sum(total_laid_off) as total_layoffs,
    (sum(funds_raised_millions)/sum(total_laid_off)) as funds_per_laid_off
from `malli nandhini - layoffs (1)`
where total_laid_off > 0
group by industry
order by funds_per_laid_off desc;

-- 10 . For each country and stage, find the total layoffs and the average percentage laid off.Sort by the highest total layoffs.
select
	country,
    stage,
    sum(total_laid_off) as total_layoffs,
    avg(percentage_laid_off) as avg_percentage_laid_off
from `malli nandhini - layoffs (1)`
group by country, stage
order by total_layoffs desc;
