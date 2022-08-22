drop table if exists total_employee_count;
select count(e.emp_no)
into total_employee_count
from employees e
join dept_emp de on e.emp_no = de.emp_no
where de.to_date = '9999-01-01';

drop table if exists young_employee_count;
select count(first_name)
into young_employee_count
from employees e
join dept_emp de on e.emp_no = de.emp_no
where (e.birth_date between '1965-01-01' AND '2020-01-01')
and de.to_date = '9999-01-01';
select * from young_employee_count;

drop table if exists actually_young_employee_count;
select count(first_name)
into actually_young_employee_count
from employees e
join dept_emp de on e.emp_no = de.emp_no
where (e.birth_date between '1966-01-01' AND '2020-01-01')
AND (de.to_date = '9999-01-01');

drop table if exists young_employee_percentage;

select ayec.count AS "Employees Younger Than 50", yec.count AS "Employees Younger Than 55", tec.count AS "Total Employees", 
round((cast(yec.count as decimal)/tec.count)*100,2) AS "% of Employees Younger Than 55"
into young_employee_percentage
from young_employee_count yec
cross join total_employee_count tec
cross join actually_young_employee_count ayec;

select * from young_employee_percentage;