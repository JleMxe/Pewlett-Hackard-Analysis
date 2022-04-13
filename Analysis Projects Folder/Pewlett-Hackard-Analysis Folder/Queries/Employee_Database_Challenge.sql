--Challenge Mod 7
--Deliverable 1
--Generate retirement_titles table
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

--Generate unique_titles table
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no asc, to_date desc;

--Generate retiring_titles table
select count(emp_no),title
into retiring_titles
from unique_titles
group by (title)
order by count(emp_no) desc;

--Deliverable 2
select distinct on (ti.emp_no)
ti.emp_no,
ee.first_name,
ee.last_name,
ee.birth_date,
de.from_date,
de.to_date,
ti.title
into mentorship_eligibility
from employees as ee
inner join dept_emp as de
on (de.emp_no = ee.emp_no)
inner join titles as ti
on (ee.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
and (ee.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
order by ti.emp_no asc;
