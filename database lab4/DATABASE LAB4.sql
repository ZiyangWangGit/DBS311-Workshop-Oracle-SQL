/*The HR department needs a list of Department IDs for departments that do not 
contain the job ID of ST_CLERK. Exclude NULL departments from your result. Use 
a SET operator to create this list.*/
SELECT  
    department_id
FROM 
    employee
WHERE 
    department_id IS NOT NULL
MINUS
SELECT 
    department_ID
FROM 
    employee
WHERE 
    job_id = 'ST_CLERK'
AND 
    department_id IS NOT NULL;
    
    
/*Display list with employee¡¯s Id, Job Id and Salary that will include the 
current job and salary and all previous Jobs , if they have them (here you will 
display salary of -1).Use a SET operator for this report*/
SELECT
    employee_id,
    job_id,
    salary
FROM
    employee
UNION ALL
SELECT
    employee_id,
    job_id,
    -1
FROM
    job_history;
    

/*Display cities that no warehouse is located in them. Use SET operator to 
answer this question*/
SELECT 
    city
FROM
    locations
WHERE 
    location_id in (SELECT location_id 
                    FROM locations 
                    MINUS 
                    SELECT location_id 
                    FROM warehouses) ;

    
    
/*We need a single report to display all warehouses and the city and state that 
they are located in, also all states regardless of whether they have warehouses 
in them or not.If state value is blank, display No State.(You are not allowed to 
use JOIN for this question.). Here is a partial output:*/
SELECT
    location_id AS "#loc",
    city,
    state,
    to_char(null) AS "Warehouse"
FROM
    locations
UNION ALL
SELECT
    location_id,
    to_char(null),
    to_char(null),
    warehouse_name
FROM
    warehouses;
    
    
  