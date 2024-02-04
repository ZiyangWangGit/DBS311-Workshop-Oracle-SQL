/*Display the department number and Highest, Lowest and Average pay per 
each department. Name these results High, Low and Avg.Sort the output so 
that department with highest average salary are shown first*/
SELECT 
    department_id,
    MAX(SALARY) AS "High",
    MIN(SALARY) AS "Low",
    AVG(SALARY) AS "Avg"
FROM 
    employee
GROUP BY 
    department_id
ORDER BY 
    "Avg" DESC;


/* Display how many people work the same job in the same department. 
Name theseresults Dept#, Job and HowMany. Include only jobs that involve 
more than oneperson.Sort the output so that jobs with the most people involved 
are shown first*/
SELECT 
   COUNT(*) AS "HowMany",
   department_id AS "Dept#",
   job_id AS "Job"
FROM employee
GROUP BY department_id,job_id
HAVING COUNT(*) > 1
ORDER BY "Job" DESC;


/*For each job title display the job title and total amount paid each month 
for this type ofthe job. Exclude titles AD_PRES and AD_VP and also include only 
jobs that requiremore than $15,000.Sort the output so that top paid jobs are shown 
first*/
SELECT
    job_id,
    SUM(SALARY)
FROM 
    employee
WHERE 
    job_id  NOT IN ('AD_PRES', 'AD_VP')
GROUP BY 
    job_id
HAVING 
    SUM(SALARY) > 15000
ORDER BY 
    SUM(SALARY) DESC;


/* For each manager number display how many persons he / she supervises. 
Exclude managers with numbers 100, 101 and 102 and also include only those 
managers thatsupervise more than 2 persons.Sort the output so that manager 
ids with the most supervised persons are shown first*/
SELECT 
    manager_id,
    COUNT(employee_id) 
FROM
    employee
WHERE 
    manager_id NOT IN('100','101','102')
GROUP BY
    manager_id
HAVING
    COUNT(employee_id)>2
ORDER BY
    COUNT(manager_id) DESC;
    

/*For each department show the latest and earliest hire date, but exclude 
departments 10 and 20 and also exclude those departments where the last person  
was hired in this century (Century started on Jan 01st 2000). Sort the output  
so that most recent latest hire dates are shown first*/
SELECT 
    department_id,
    MAX(hire_date),
    MIN(hire_date)
FROM 
    employee
WHERE
    department_id NOT IN('10','20') 
GROUP BY
    department_id         
HAVING
    MAX(hire_date) < '01-Jan-00'
ORDER BY
    MAX(hire_date) DESC;
    

/*For each department show its name, city and how many people work there, 
excluding departments which name starts on S (do not use LIKE here) and showing 
only those ones that employ at least 3 persons. Sort the output by department 
name ascending.One possible row will look like shown here:
     Executive     Seattle     3*/
SELECT 
    department_name,
    city,
    COUNT(employee_id)
FROM
    department 
LEFT OUTER JOIN 
    employee USING (department_id)
LEFT OUTER JOIN 
    location USING (location_id)
WHERE
    SUBSTR(department_name, 1, 1) != 'S'
GROUP BY
    department_name,city
HAVING 
    COUNT(employee_id) >= 3
ORDER BY
    department_name ASC;
    
    
/*Variation of Q6 where you will show only departments that do not begin on A   
and with less than 3 employees, including also Empty departments. One possible
row will look like shown here:
     Contracting     Seattle     0*/
SELECT 
    department_name,
    city,
    COUNT(employee_id)
FROM
    department 
LEFT OUTER JOIN 
    employee USING (department_id)
LEFT OUTER JOIN 
    location USING (location_id)
WHERE
    SUBSTR(department_name, 1, 1) != 'A'
GROUP BY
    department_name,city
HAVING 
    COUNT(employee_id) < 3


    
    