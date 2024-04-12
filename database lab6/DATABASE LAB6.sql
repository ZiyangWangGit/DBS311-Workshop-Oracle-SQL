/*Write a store procedure called Get_Fact that gets an integer number n 
and calculates and displays its factorial*/
SET SERVEROUTPUT ON;

CREATE PROCEDURE Get_Fact(p_n IN INT) 
AS 
    v_factorial INT := 1;
BEGIN
    FOR i IN REVERSE 1..p_n LOOP
        v_factorial := v_factorial * i;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Factorial of ' || p_n || ' is: ' || v_factorial);
END;
/

BEGIN
    Get_Fact(5);
END;
/
BEGIN
    Get_Fact(3);
END;
/


/*The company wants to calculate the employees¡¯ annual salary:The first year of 
employment, the amount of salary is his/her base salary (shown undercolumn 
Salary).Every year after that, the salary increases by 5%.
Write a stored procedure named Calculate_Salary which gets an Employee ID and 
for that employee calculates the salary based on the number of years the 
employee has been working in the company. (Use a loop construct to calculate 
the salary).The procedure calculates and prints the Name and Annual Salary*/
CREATE OR REPLACE PROCEDURE Calculate_Salary(p_employee_id INT)
AS
    v_salary employee.salary%TYPE;
    v_years INT;
    v_first_name employee.first_name%TYPE;
    v_last_name employee.last_name%TYPE;
BEGIN 
    SELECT 
        salary, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date),
        first_name, last_name
    INTO 
        v_salary, v_years, v_first_name, v_last_name
    FROM
        employee
    WHERE 
        employee_id = p_employee_id;
    FOR i IN 2..v_years LOOP
        v_salary := v_salary + v_salary * 0.05;
    END LOOP;
    dbms_output.put_line('First Name: ' || v_first_name);
    dbms_output.put_line('Last Name: ' || v_last_name);
    dbms_output.put_line('Annual Salary: $' ||v_salary);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Employee with ID ' || p_employee_id || ' does not exist.');
END;
/
BEGIN 
    Calculate_Salary(124);
END;
/
BEGIN 
    Calculate_Salary(101);
END;
/
ROLLBACK;


/*Write the code for the procedure called Find_Prod_price, that will search 
table Products and for a given Product ID will find its Description and display 
a message (note)regarding its List Price. This note will show Cheap for price 
below $200, Not Expensivefor price between $200 and $500, otherwise will be 
Expensive (for price higher than $500). You need to take care of the wrong input 
(Product ID is invalid) as well.Use one IN parameter and two OUT parameters, 
then use PL/SQL block to show youroutput like (for a given ID of 31):*/
CREATE OR REPLACE PROCEDURE Find_Prod_Price(
    p_product_id IN products.product_id%TYPE,
    v_description OUT products.description%TYPE,
    v_list_price OUT products.list_price%TYPE
)
AS
BEGIN 
    SELECT
        description,list_price
    INTO
        v_description,v_list_price
    FROM
        products
    WHERE
        product_id = p_product_id;
    IF v_list_price < 200 THEN
        dbms_output.put_line(v_description  || 'is Cheap');
    ELSIF v_list_price BETWEEN 200 AND 500 THEN
        dbms_output.put_line(v_description ||'is Not Expensive');
    ELSE
        dbms_output.put_line(v_description || 'is Expensive');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Invalid product');
END;
/
DECLARE
    v_description products.description%TYPE;
    v_list_price products.list_price%TYPE;
BEGIN 
    Find_Prod_Price(31, v_description, v_list_price);
END;
/

DECLARE
    v_description products.description%TYPE;
    v_list_price products.list_price%TYPE;
BEGIN 
    Find_Prod_Price(3, v_description, v_list_price);
END;
/
ROLLBACK;



/*Write a stored procedure named Warehouses_Report to print the warehouse ID, 
warehouse name, and the city where the warehouse is located in the following 
format for ALL warehouses:
Warehouse ID:
Warehouse name:
City:
State:
If the value of state does not exist (null), display ¡°no state¡±.The value of 
warehouse ID ranges from 1 to 9.You can use a loop to find and display the 
information of each warehouse inside the loop.(Use a loop construct to 
answer this question. Do not use cursors.*/
CREATE OR REPLACE PROCEDURE Warehouses_Report
AS
BEGIN
    FOR i IN 1..9 LOOP
        DECLARE
            v_warehouse_id warehouses.warehouse_id%TYPE;
            v_warehouse_name warehouses.warehouse_name%TYPE;
            v_warehouse_city locations.city%TYPE;
            v_warehouse_state locations.state%TYPE;
        BEGIN
            SELECT 
                w.warehouse_id, w.warehouse_name, l.city, l.state
            INTO
                v_warehouse_id, v_warehouse_name, v_warehouse_city, v_warehouse_state
            FROM
                warehouses w
            JOIN
                locations l ON w.location_id = l.location_id
            WHERE
                w.warehouse_id = i;
                
            dbms_output.put_line('Warehouse ID: ' || v_warehouse_id);
            dbms_output.put_line('Warehouse name: ' || v_warehouse_name);
            dbms_output.put_line('City: ' || v_warehouse_city);
            dbms_output.put_line('State: ' || v_warehouse_state);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('Warehouse with ID ' || i || ' does not exist.');
        END;
    END LOOP;
END;
/
BEGIN
    Warehouses_Report;
END;
/






    