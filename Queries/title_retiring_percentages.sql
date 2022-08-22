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

drop table if exists total_titles;
select count(de.emp_no), t.title
into total_titles
from dept_emp de
join titles t on de.emp_no=t.emp_no
where t.to_date = '9999-01-01' AND de.to_date = '9999-01-01'
group by t.title;

drop table if exists title_retiring_percentages;
select rt.count AS "Retiree_Count", tt.count AS "Total_Employees",
round(round(cast(rt.count as decimal)/tt.count,3)*100,1) AS "% of Total Employees"
, tt.title
into title_retiring_percentages
from retiring_titles rt
join total_titles tt on rt.title=tt.title
order by "Retiree_Count" desc;

select * from title_retiring_percentages;