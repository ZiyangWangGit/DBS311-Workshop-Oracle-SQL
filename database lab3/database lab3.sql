/*Display last name and job title for all employees who perform the same job 
as Davies.Exclude Davies from this query.*/
SELECT 
    job_id,
    last_name
FROM
    employee
WHERE
    job_id = (SELECT job_id
              FROM employee
              WHERE last_name = 'Davies')
AND 
    last_name <> 'Davies';


/*Display last name, job title and hire date for all employees hired after 
Grant.Sort the output by the most recent hire date.*/
SELECT
    last_name,
    job_id,
    hire_date
FROM
    employee
WHERE
    hire_date > (SELECT hire_date
                 FROM employee
                 WHERE last_name = 'Grant')
ORDER BY hire_date DESC;
                 

/*Display city, province name, postal code and country code for all cities 
located in countries with NAMES (not Country Codes) starting on letter I 
(meaning Italy, Israeland India).
If the province is blank, show message Unknown.
Heading sample should be like:City, Province, Prov_Code, Cnt_Code*/
SELECT
    city AS "City",
    COALESCE(state_province, 'Unknown') AS "Province",
    postal_code AS "Prov_Code",
    country_id AS "Cnt_Code"
FROM
    location
WHERE
    UPPER(country_id) LIKE 'I%';
    

/* Display last name, job title and salary for all employees who earn less 
than the Average salary in the Sales department. Do NOT use Join method.Sort 
the output by top salaries first and then by job title*/
SELECT 
    last_name,
    job_id,
    salary
FROM
    employee
WHERE
    salary < (SELECT AVG(salary)
              FROM employee
              WHERE UPPER(job_id) LIKE 'SA%')
AND 
    UPPER(job_id) NOT LIKE 'SA%'
ORDER BY
    salary DESC,job_id;


/*Display last name, job title and salary for all employees whose salary 
matches any of the salaries from the IT Department. Do NOT use Join method.
Sort the output by salary ascending first and then by last_name*/
SELECT
    last_name,
    job_id,
    salary
FROM 
    employee
WHERE
    salary = ANY (SELECT salary
                  FROM employee
                  WHERE SUBSTR(job_id,1,2) = 'IT')
ORDER BY 
    salary ASC,last_name ASC;


/*Display last name and salary for all employees who earn less than the Lowest 
salary in ANY department.Sort the output by top salaries first and then by 
last name*/
SELECT
    last_name,
    salary
FROM 
    employee
WHERE
    salary < ANY(SELECT MIN(salary)
                 FROM employee
                 GROUP BY department_id)
ORDER BY
    salary DESC,last_name;


/*Show job title, last name and salary for each person earning the highest
amount for that job. Exclude all managers from this query. Sort the output by 
jobs ascending. (it is a Multiple Column SubQuery)*/
SELECT
    job_id,
    last_name,
    salary
FROM
    employee
WHERE
    (job_id,salary) IN (SELECT job_id, 
                               MAX(salary)
                               FROM employee
                               GROUP BY job_id)
AND 
    job_id NOT LIKE '%MGR'
ORDER BY
    job_id ASC;
    