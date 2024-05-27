-------------------------------
--Data Modeling
-------------------------------

--Inspect the CSV files, and then sketch an Entity Relationship Diagram of the tables. To create the sketch, feel free to use a tool like QuickDBDLinks to an external site..

-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/DMDXiX
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

CREATE TABLE "Departments" (
    "dept_no" vachar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

SELECT * FROM public.departments;


CREATE TABLE "Deparmet_Employees" (
    "emp_no" int   NOT NULL,
    "dept_no" Varchar   NOT NULL,
    CONSTRAINT "pk_Deparmet_Employees" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

SELECT * From public.dept_emp;


CREATE TABLE "Deptarment_Manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" varchar   NOT NULL,
    CONSTRAINT "pk_Deptarment_Manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

SELECT * FROM public.dept_manager;
	
CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "title_id" varhar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" varchar   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no","title_id"
     )
);

SELECT * FROM public.employees;

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

SELECT * FROM public.salaries;


CREATE TABLE "Titles" (
    "title_id" varhar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

SELECT * FROM public.titles

--------------------------------
--Data Engineering
---------------------------------

---Use the provided information to create a table schema for each of the six CSV files. Be sure to do the following:

---Remember to specify the data types, primary keys, foreign keys, and other constraints.

--For the primary keys, verify that the column is unique. Otherwise, create a composite keyLinks to an external site.,
--which takes two primary keys to uniquely identify a row.

--Be sure to create the tables in the correct order to handle the foreign keys.

---Import each CSV file into its corresponding SQL table.










------------------------------------------------------------------------------
-- Data Analysis
------------------------------------
-- Table: public.departments

-- DROP TABLE IF EXISTS public.departments;

CREATE TABLE IF NOT EXISTS public.departments
(
    dept_no character varying(20) COLLATE pg_catalog."default",
    dept_name character varying(30) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.departments
    OWNER to postgres;
-- Table: public.salaries

-- DROP TABLE IF EXISTS public.salaries;

CREATE TABLE IF NOT EXISTS public.salaries (
    emp_no integer,
    salary integer
) TABLESPACE pg_default;

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.salaries
    OWNER to postgres;

-----------------------------------------------------------

SELECT * FROM public.departments;
SELECT * From public.dept_emp;
SELECT * FROM public.dept_manager;
SELECT * FROM public.employees;
SELECT * FROM public.salaries;
SELECT * FROM public.titles;



-- 1  List the employee number, last name, first name, sex, and salary of each employee.
--DONE

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

-- 2    List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31';

-- 3 List the manager of each department along with their department number, department name, employee number, last name, and first name.
-- workin on

SELECT dm.dept_no AS department_number, 
       d.dept_name AS department_name, 
       dm.emp_no AS employee_number, 
       e.last_name AS last_name, 
       e.first_name AS first_name
FROM dept_Manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

-- 4  List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT dm.dept_no AS department_number,
       dm.emp_no AS employee_number,
       e.last_name AS last_name,
       e.first_name AS first_name,
       d.dept_name AS department_name
FROM dept_Manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

-- 5 List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6 List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no AS employee_number, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- 7 List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no AS employee_number, e.last_name, e.first_name, d.dept_name AS department_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- 8 List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
