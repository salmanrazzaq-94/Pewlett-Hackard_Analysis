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