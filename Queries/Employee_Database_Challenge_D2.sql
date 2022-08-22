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


drop table if exists mentorship_eligibility_titles;
select title AS "Mentorship Roles", count(title) AS "# of Candidates"
into mentorship_eligibility_titles
from mentorship_eligibility
group by title;

select *
from retiring_titles;

select * from mentorship_eligibility_titles;

drop table if exists available_replacements_percentages;
select rt.title, rt.count as "# of Retirees", met."# of Candidates", round((cast(met."# of Candidates" AS decimal)/rt.count*100),1) AS "% Replacements Available"
into available_replacements_percentages
from mentorship_eligibility_titles met
right join retiring_titles rt on met."Mentorship Roles"=rt.title
order by "% Replacements Available" desc;

select * from available_replacements_percentages;



select * from actually_young_employee_count ayec