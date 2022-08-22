-- DELIVERABLE 1: RETIREMENT ELIGIBILITY (ALL DEPTS)

-- drop table each time we want to rerun the code
drop table if exists retirement_titles;

-- select requisite columns from employees+titles tables
Select e.emp_no, e.first_name, e.last_name,
t.title, t.from_date, t.to_date
-- create new db called 'retirement_titles'
into retirement_titles
from employees e
join titles t on e.emp_no=t.emp_no
-- limit to employees aged 65+ at time of assignment
where e.birth_date between '1952-01-01' AND '1955-12-31'
order by e.emp_no;

-- check results
Select *
from retirement_titles;



-- drop table each time we want to rerun the code
drop table if exists unique_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
-- create unique_titles table from columns in previous emp_title_db
INTO unique_titles
FROM retirement_titles
-- limit to active employees
where to_date = '9999-01-01'
-- order by emp_no and grab bottom (most recent) title
ORDER BY emp_no, title DESC;

-- check results
Select * from unique_titles;


-- drop table to allow code to run each time
drop table if exists retiring_titles;

-- find count of distinct titles in unique_titles table
-- select that count + its corresponding title value
Select count(title), title
into retiring_titles
from unique_titles
-- group distinct title values together so it counts all Managers, etc. together
group by title
-- order largest -> smallest based on count value
order by count desc;

-- verify results
select * from retiring_titles;




-- DELIVERABLE 2: MENTORSHIP PROGRAM ELIGIBILITY (ALL DEPTS)

-- drop table at start of code so it will run every new time
Drop Table if exists mentorship_eligibility;

-- select columns for new table from employees, dept_emp, and titles
-- distinct on emp_no so no duplicates
Select distinct on (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date
, de.from_date, de.to_date, t.title
into mentorship_eligibility
from employees e
join dept_emp de on e.emp_no=de.emp_no
join titles t on e.emp_no=t.emp_no
-- limit to current employees
where (de.to_date = '9999-01-01')
-- limit to those born in 1965
AND (birth_date between '1965-01-01' AND '1965-12-31')
-- order by emp_no
order by e.emp_no;

-- verify results
select * from mentorship_eligibility;