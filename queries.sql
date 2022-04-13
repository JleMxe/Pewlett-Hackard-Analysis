select first_name, last_name from employees where birth_date between '1952-01-01' and '1955-12-31';

select first_name, last_name from employees where birth_date between '1952-01-01' and '1952-12-31';

select first_name, last_name from employees where birth_date between '1953-01-01' and '1953-12-31';

select first_name, last_name from employees where birth_date between '1954-01-01' and '1954-12-31';

select first_name, last_name 
from employees 
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

select count(first_name)
from employees 
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

select first_name, last_name
into retirement_info
from employees 
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

select * from retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining departments and dept_manager tables using aliases
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
	FROM retirement_info
	LEFT JOIN dept_emp
	ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables using aliases
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
	FROM retirement_info as ri
	LEFT JOIN dept_emp as de
	ON ri.emp_no = de.emp_no;

-- Adding the where to maker sure the employee is a current employee
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
	INTO current_emp
	FROM retirement_info as ri
	LEFT JOIN dept_emp as de
	ON ri.emp_no = de.emp_no
	WHERE de.to_date = ('9999-01-01');
	
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
Order By de.dept_no;

-- Skill Drill 7.3.4 Employee count by department number into int's own table
SELECT de.dept_no,COUNT(ce.emp_no)
INTO dept_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
Order By de.dept_no;

select * from dept_count;

-- 7.3.5
SELECT * FROM salaries;

SELECT * FROM salaries
ORDER BY to_date DESC;

-- -------------
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');
	 
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

--7.3.6 skill drills
select ri.emp_no, ri.first_name, ri.last_name, d.dept_name
INTO sales_info
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON (de.emp_no = ri.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_name = 'Sales');

select ri.emp_no, ri.first_name, ri.last_name, d.dept_name
INTO sales_dev_info
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON (de.emp_no = ri.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Development','Sales');
--Challenge Mod 7
--Deliverable 1
SELECT ti.emp_no,
ee.first_name,
ee.last_name,
ti.title,
ti.from_date,
ti.to_date
into retirement_titles
from titles as ti
inner join employees as ee
on (ti.emp_no = ee.emp_no)
where (ee.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by emp_no asc;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no asc, to_date desc;
