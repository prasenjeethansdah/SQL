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

/*The top three demanded skills are SQL (88.9%), Python (55.6%), and NoSQL/Tableau (44.4% each). SQL is clearly the most essential skill, while Python is the second most demanded. Other notable skills include Azure, Databricks, Spark, Java, and Power BI, each appearing in about one-third of the jobs, showing the importance of cloud computing, big-data technologies, programming, and data visualization in high-paying data roles.
*/