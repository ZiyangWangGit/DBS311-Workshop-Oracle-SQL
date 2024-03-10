/*Write a stored procedure called Even_Odd that gets an integer number as its 
Input parameter and prints The number is even.If a number is divisible by 2.
Otherwise, it prints The number is odd*/

SET SERVEROUTPUT ON;

CREATE PROCEDURE even_odd (intNumber INT) 
AS
BEGIN
  IF MOD(intNumber, 2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE('The number is even'); 
  ELSE
    DBMS_OUTPUT.PUT_LINE('The number is odd');
  END IF;
END even_odd;
/
BEGIN
  even_odd(2);
END;
/
BEGIN
  even_odd(3);
END;
/

/*Create a stored procedure named Find_Employee. This procedure gets an employee 
number and prints the following employee information:
First name
Last name
Email
Phone
Hire date
Job title
The procedure gets a formal value as the p_empid of type NUMBER.See the following 
example for employee# of 107 (actual parameter). Use table EMPLOYEES.
First name: Summer
Last name: Payn
Email: summer.payne@example.com
Phone: 515.123.8181
Hire date: 07-JUN-16
Job title: Public Accountant
The procedure displays a proper error message if any error*/
CREATE PROCEDURE find_employee (p_employeeId NUMBER)
AS
    v_firstName VARCHAR2(255);
    v_lastName VARCHAR2(255);
    v_email VARCHAR2(255);
    v_phone VARCHAR2(50);
    v_hireDate DATE;
    v_jobTitle VARCHAR2(255);
BEGIN
    SELECT
        first_name, last_name, email, phone, hire_date, job_title
    INTO
        v_firstName, v_lastName, v_email, v_phone, v_hireDate, v_jobTitle
    FROM 
        employees
    WHERE
        employee_id = p_employeeId;
    
    dbms_output.put_line('First name: ' || v_firstName);
    dbms_output.put_line('Last name: ' || v_lastName);
    dbms_output.put_line('Email: ' || v_email);
    dbms_output.put_line('Phone: ' || v_phone);
    dbms_output.put_line('Hire Date: ' || v_hireDate);
    dbms_output.put_line('Job Title: ' || v_jobTitle);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('This employee ID does NOT exist.');
END find_employee;
/
BEGIN
    find_employee(107);
END;
/
BEGIN
    find_employee(106);
END;
/


/*Every year, the company increases the price of all products in one category. 
For example, the company wants to increase the price (list_price) of products 
in category 1 by $5. Write a procedure named Update_Price_by_Cat to update the
price of all products in a given category and the given amount to be added to 
the current price if the price is greater than 0. The procedure shows the number 
of updated rows if the update is successful or shows 0 rows updated, if the input 
was an invalid category Id.The procedure gets two parameters: 
p_catid IN products.category_id%TYPE
p_amount IN NUMBER

To define the type of variables that store values of a table¡¯ column, you 
can also write:
variable_name   table_name.column_name%TYPE;

The above statement defines a variable of the same type as the type of the 
table's column.
v_category_id products.category_id%TYPE;

Or you need to see the table definition to find the type of the category_id 
column. Make sure the type of your variable is compatible with the value that 
is stored in your variable.

To show the number of affected rows the update query, declare a variable 
named v_rows_updated of type NUMBER and use the SQL Attribute sql%rowcount 
to set your variable. Then, print its value in your stored procedure.

v_rows_updated := sql%rowcount;

SQL%ROWCOUNT stores the number of rows affected by an INSERT, UPDATE, 
or DELETE*/
CREATE OR REPLACE PROCEDURE Update_Price_by_Cat(
    p_catid IN products.category_id%TYPE,
    p_amount IN NUMBER
)
AS
    v_rows_updated NUMBER;
BEGIN
    UPDATE products
    SET list_price = list_price + p_amount
    WHERE category_id = p_catid
    AND list_price > 0; 
    v_rows_updated := SQL%ROWCOUNT;

    IF v_rows_updated = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No rows updated. Invalid category ID or no products found.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_rows_updated || ' rows updated.');
    END IF;
END Update_Price_by_Cat;
/
BEGIN
    Update_Price_by_Cat(2, 5);
END;
/
BEGIN
    Update_Price_by_Cat(100, 5);
END;
/
ROLLBACK;


/* Every year, the company increases the price of products whose price is less 
than the average price of all products by 1%. (list_price * 1.01). Write a stored 
procedure named Update_Price_Under_Avg. This procedure does not have any 
parameters. You need to find the average price of all products and store it
into a variable of the same type. If the average price is less than or equal to 
$1000, update products¡¯ price by 2% if the price of the product is less than the 
calculated average. If the average price is greater than $1000, update products¡¯ 
price by 1% if the price of the product is less than the calculated average. The
query displays an error message if any error occurs. Otherwise, it displays the 
number of updated rows*/
CREATE OR REPLACE PROCEDURE Update_Price_Under_Avg
AS
    v_avg_price  NUMBER(9,2);
    v_rows_updated NUMBER;
BEGIN
    SELECT AVG(list_price)
    INTO v_avg_price
    FROM products;

    IF v_avg_price <= 1000 THEN
        UPDATE products
        SET list_price = (list_price * 1.02)
        WHERE list_price < v_avg_price;
        v_rows_updated := SQL%ROWCOUNT;
    ELSE
        UPDATE products
        SET list_price = (list_price * 1.01)
        WHERE list_price < v_avg_price;
        v_rows_updated := SQL%ROWCOUNT;
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_rows_updated || ' row(s) updated.');
EXCEPTION
      WHEN no_data_found THEN
        dbms_output.put_line('Can not update any price.');
END Update_Price_Under_Avg;
/

BEGIN
    Update_Price_Under_Avg;
END;
/
ROLLBACK;
    
    
