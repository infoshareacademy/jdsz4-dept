select count (*)
from hr_employee;

select *
from hr_employee;
--order by 1;

select count(*) from information_schema.columns
                  where table_name='hr_employee';

select id,
       age,
       distancefromhome,
       education,
       monthlyincome,
       jobsatisfaction
from hr_employee
group by education, age, distancefromhome, id, monthlyincome, jobsatisfaction
order by 6 desc , 4;

select age, education, avg(jobsatisfaction)
from hr_employee
group by age, education
order by 3 desc;

select id,
       age,
       jobsatisfaction,
       maritalstatus,
       avg(jobsatisfaction) over (partition by maritalstatus)
from hr_employee;

select age,
       avg(jobsatisfaction) over (partition by maritalstatus)
from hr_employee
group by age, jobsatisfaction,maritalstatus
order by age;

-- średnia job satisfaction dla unikalnego wieku

select distinct age,
       avg(jobsatisfaction) over (partition by age)
from hr_employee
order by age;

-------------------------------------------------------------------

--jobsatisfaction a marital status

select id,
       jobsatisfaction,
       maritalstatus
from hr_employee;

select distinct maritalstatus,
                avg(jobsatisfaction) over (partition by maritalstatus)
from hr_employee;

--jobsatisfaction a sex

select id,
       jobsatisfaction,
       gender
from hr_employee;

select distinct gender,
                avg(jobsatisfaction) over (partition by gender)
from hr_employee;




