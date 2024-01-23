/*Write a query to display the After-tomorrow¡¯s date in the following format:September 28th of 
year 2016Your result will depend on the day when you create this query.Label the column After Tomorrow*/
SELECT TO_CHAR(SYSDATE + 2, 'FMMonth DD"th" "of year" YYYY') AS "After Tomorrow" FROM dual;

/*For each employee in departments 50 and 60 display last name, first name,salary, 
and salary increased by 7% and expressed as a whole number.Label the column Good S
alary.Also add a column that subtracts the old salary from the new salary and multipliesby 12. 
Label the column Annual Pay Increase
*/
SELECT 
    last_name,
    first_name,
    salary,
    ROUND(salary * 1.07) AS "Good Salary",
    (ROUND(salary * 1.07) - salary) * 12 AS "Annual Pay Increase"
FROM employee
WHERE department_id IN (50, 60);


/*Write a query that displays the employee¡¯s Full Name and Job 
Title in thefollowing format:DAVIES, CURTIES is Stock Clerkfor a
ll employees whose last name ends with S and first name starts with C or K.
Give this column an appropriate label like Person and JobSort the result by the employees¡¯ last names.*/
SELECT
 UPPER(first_name) || ', ' || UPPER(last_name)||' is ' || job_id AS "Person and Job"
FROM employee
WHERE 
    UPPER(SUBSTR (last_name, -1)) = 'S' AND (UPPER(first_name) LIKE 'C%' OR UPPER(first_name) LIKE 'K%')
ORDER BY 
    last_name;
    
/*For each employee hired before 1992 who is earning more than $10000, displaythe employee¡¯s 
last name, salary, hire date and calculate the number of YEARSbetween TODAY and the date the 
employee was hired. Round the number of yearsup to the closest whole number. Label the column 
Years Worked.Order your results by the highest paid people first, then by years worked*/
SELECT 
    last_name,
    salary,
    hire_date,
    ROUND((sysdate-hire_date)/365) AS "Years Worked"
FROM employee
WHERE EXTRACT(YEAR FROM hire_date) < 1992 AND salary>10000
ORDER BY
    salary DESC, "Years Worked" DESC;


/*Create a query that displays the city names, country codes and state p
rovincenames, but only for those cities that start on S and have at least 
8 characters in theirname. If city does not have province name assigned, then put Unknown Province.*/
SELECT
    city,
    country_id,
    state_province,
    COALESCE(state_province, 'Unknown Province')
FROM location
WHERE city LIKE 'S%' AND LENGTH(city) >= 8;

/*Display each employee¡¯s last name, hire date, and salary review date, 
which isthe first Tuesday after a year of service, but only for those hired 
after 1997.Label the column REVIEW DAY. Format the dates to appear in the format 
similarto: TUESDAY, August the Thirty-First of year 1998*/
SELECT 
    last_name,
    hire_date,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 12), 'TUESDAY'), 'DAY,MONTH "the" fmDdspth "of year" YYYY') AS "REVIEW DAY"
FROM 
    employee
WHERE 
    EXTRACT(YEAR FROM hire_date) > 1997;
