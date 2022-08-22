drop table if exists total_retirees_percentage;
select sum("Retiree_Count") AS "Retirees_Total", sum("Total_Employees") AS "Employees_Total",
round((cast(sum("Retiree_Count") as decimal)/sum("Total_Employees"))*100,2) AS "Total_Retirees_Percentage"
into total_retirees_percentage
from title_retiring_percentages;

drop table if exists mentorship_count;
select count(me.emp_no)
into mentorship_count
from mentorship_eligibility me;

select trp."Retirees_Total" AS "Upcoming_Vacant_Positions", 
mc.count AS "Replacements_to_fill_Positions",
100-round((cast(mc.count as decimal)/trp."Retirees_Total")*100,2) AS "% of Retirees Left Vacant"
into upcoming_vacant_positions
from total_retirees_percentage trp
cross join mentorship_count mc;