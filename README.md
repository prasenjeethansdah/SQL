# Introduction
📊 Diving into the Data job market in India, focusing on Data Engineer roles, this project explores top-paying jobs, in-demand skills, and where demand meets high salary in data engineer in India.
Check the sql queries here: [project folder](/Project/)
# 📊 SQL Data Engineering Job Market Analysis

## Introduction

This project dives into the Data Engineering job market in India using SQL, uncovering the skills, salaries, and opportunities shaping the field. Through data-driven analysis, it explores which skills are most in demand, which are linked to higher-paying roles, and which offer the best balance between demand and earning potential—providing practical insights for anyone looking to build a career in Data Engineering.

## Background

With the growing demand for data-driven decision-making, Data Engineering has become an important career path in the technology industry. However, the skills required for Data Engineering roles vary across companies and positions.
Data hails from [SQL Course](https://lukebarousse.com/sql).

The project explores the Data Engineering job market in India through SQL-based analysis, examining salary trends, skill requirements, and employer demand. By connecting job postings with their associated skills and salaries, the analysis uncovers patterns in the market and highlights the skills that stand out in terms of demand, earning potential, and overall career value.

## Tools I Used

- **SQL** – Used to explore the job-market dataset, connect job and skill information, calculate salary averages, and identify the most demanded and highest-paying skills.
- **PostgreSQL** – Used to store and query the dataset, allowing me to efficiently perform joins, filtering, grouping, and aggregations for the analysis.
- **VS Code** – my main workspace to write, organize, test, and refine the SQL queries used throughout the project.
- **Git & GitHub** – Used to track my progress, organize the SQL project, and publish my queries and findings so the analysis can be easily reviewed and reproduced.

## The Analysis

The project consists of five SQL analyses:

### 1. Top-Paying Data Engineer Jobs

The analysis identifies the highest-paying Data Engineer roles in India by filtering relevant positions, excluding missing salary data, connecting job postings with company information, and ranking them by annual salary.
```sql
SELECT
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Engineer' AND
    job_location = 'India' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;
```
### 2. Skills Required for Top-Paying Jobs

The highest-paying positions are examined alongside their associated skills to identify the technical expertise commonly required for premium Data Engineering roles.
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Engineer' AND
        job_location = 'India' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT
        10
)
SELECT 
    top_paying_jobs.*,
    skills 
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
### 3. Most Demanded Skills

Skill occurrences across Data Engineer job postings are counted and ranked to reveal the top 5 skills most frequently requested by employers.
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS skill_demand
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    job_location = 'India' 
GROUP BY
    skills
ORDER BY
    skill_demand DESC
LIMIT 5
```
### 4. Top-Paying Skills

The average salary associated with each skill is calculated to highlight skills linked with higher-paying Data Engineering positions, including DAX, T-SQL, NumPy, MicroStrategy, R, SAP, and SSIS.

Note: A high average salary for a skill does not necessarily mean the skill directly leads to higher pay, as some skills may occur in only a small number of highly paid positions.
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'India' 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 20;
```
### 5. Optimal Skills

The final analysis identifies skills that provide a strong combination of high demand and high salary.

Skills are grouped and ranked based on:
- Number of job postings requiring the skill
- Average salary associated with the skill
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'India'
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 5
ORDER BY
    demand_count DESC,
    avg_salary DESC;
```
This helps identify skills that may provide better career opportunities than looking at salary or demand alone.


## 📚 What I Learned

Through this project, I developed practical experience in applying SQL to a real-world job market dataset:

- **Complex Query Building:** Worked with multiple tables using JOINs and CTEs to connect job postings, companies, and skills and extract relevant results.

- **Data Aggregation:** Used GROUP BY, COUNT(), and AVG() to measure skill demand and compare average salaries across different skills and roles.

- **Data Filtering & Ranking:** Applied WHERE, HAVING, ORDER BY, and LIMIT to filter the dataset and identify top-paying jobs, most demanded skills, and higher-paying skills.

- **Analytical Problem-Solving:** Converted questions about Data Engineering jobs, salaries, and skills into SQL queries and used the results to draw insights.

- **Real-World SQL Application:** Combined different SQL concepts to explore patterns in the Data Engineering job market in India.

- **Working with Related Data:** Worked with job, company, salary, and skill information to understand how different data points can be combined for analysis.

I also learned how SQL can be used not only to retrieve data but also to answer practical career and business questions.

## Conclusions

### Insights

1. **Top paying Data Engineer in India:** The highest paying jobs in data engineering role in India offers a wide range of salaries highes being $156,500

2. **Skills for Top paying jobs:** The highest-paying Data Engineer roles most consistently require SQL, Python, and NoSQL, highlighting their importance across well-paid positions.

3. **Most In-Demand Skills:** SQL (1,155), Python (1,073), and Spark (671) are the three most demanded skills in the Data Engineer job market, highlighting the importance of strong database, programming, and big-data processing capabilities.

4. **Skills with Higher Salaries:** DAX ($156,500), T-SQL ($156,500), and NumPy ($156,000) are associated with the highest average salaries in the dataset, highlighting the value of specialized analytics, database, and data-processing skills.

5. **Optimal Skills for Job Market Value:** SQL, Python, and NoSQL stand out by combining strong employer demand with competitive average salaries, making them valuable skills for building a career in Data Engineering.

### Closing Thoughts
This project strengthened my SQL skills and provided valuable insights into the Data Engineering job market in India. The analysis can serve as a practical guide for prioritizing skills to develop and identifying suitable job opportunities. For aspiring Data Engineers, focusing on high-demand and well-paying skills can help build a stronger foundation for entering the field. Overall, this exploration of the data job market highlights the importance of continuous learning and adapting to emerging trends in Data Engineering.