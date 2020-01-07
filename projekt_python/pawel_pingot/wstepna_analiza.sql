select employeenumber, attrition, dailyrate, hourlyrate, monthlyrate, monthlyincome
from "WA_Fn-UseC_-HR-Employee-Attrition";
-- procent zwolnień w oparciu o monthlyincome
select *, round(liczba_pracowników / sum(liczba_pracowników) over (partition by zarobki), 2) as procent
from (select distinct (case
                           when monthlyincome < 1000 then '<1000'
                           when monthlyincome <= 3000 then '<=3000'
                           when monthlyincome <= 5000 then '<=5000'
                           when monthlyincome <= 7000 then '<=7000'
                           when monthlyincome <= 9000 then '<=9000'
                           when monthlyincome <= 11000 then '<=11000'
                           when monthlyincome <= 13000 then '<=13000'
                           when monthlyincome <= 15000 then '<=15000'
                           when monthlyincome <= 17000 then '<=17000'
                           when monthlyincome <= 19000 then '<=19000'
                           when monthlyincome <= 21000 then '<=21000' end) as zarobki,
                      attrition,
                      count(1)                                             as liczba_pracowników
      from "WA_Fn-UseC_-HR-Employee-Attrition"
      group by 1, 2
      order by 1) pod;
-- businesstravel->monthlyincome->attrition
select *, round(liczba_pracowników / sum(liczba_pracowników) over (partition by businesstravel, zarobki), 2) as procent
from (select businesstravel,
             (case
                  when monthlyincome < 1000 then '<1000'
                  when monthlyincome <= 3000 then '<=3000'
                  when monthlyincome <= 5000 then '<=5000'
                  when monthlyincome <= 7000 then '<=7000'
                  when monthlyincome <= 9000 then '<=9000'
                  when monthlyincome <= 11000 then '<=11000'
                  when monthlyincome <= 13000 then '<=13000'
                  when monthlyincome <= 15000 then '<=15000'
                  when monthlyincome <= 17000 then '<=17000'
                  when monthlyincome <= 19000 then '<=19000'
                  when monthlyincome <= 21000 then '<=21000' end) as zarobki,
             count(1)                                     as liczba_pracowników,
             attrition
      from "WA_Fn-UseC_-HR-Employee-Attrition"
      group by 1, 2, 4
      order by zarobki, businesstravel) pod
order by zarobki, pod.businesstravel;
-- businestravel->attrition
select *, round(liczba_pracownikow / sum(liczba_pracownikow) over (partition by businesstravel), 2) as procent
from (select businesstravel, attrition, count(1) as liczba_pracownikow
      from "WA_Fn-UseC_-HR-Employee-Attrition"
      group by 1, 2
      order by 1) pod;
-- department->monthlyincome->attrition
select *, round(liczba_pracowników / sum(liczba_pracowników) over (partition by department, zarobki), 2) as procent
from (SELECT department,
             (case
                  when monthlyincome < 1000 then '<1000'
                  when monthlyincome <= 3000 then '<=3000'
                  when monthlyincome <= 5000 then '<=5000'
                  when monthlyincome <= 7000 then '<=7000'
                  when monthlyincome <= 9000 then '<=9000'
                  when monthlyincome <= 11000 then '<=11000'
                  when monthlyincome <= 13000 then '<=13000'
                  when monthlyincome <= 15000 then '<=15000'
                  when monthlyincome <= 17000 then '<=17000'
                  when monthlyincome <= 19000 then '<=19000'
                  when monthlyincome <= 21000 then '<=21000' end) as zarobki,
             count(1)                                     as liczba_pracowników,
             attrition
      from "WA_Fn-UseC_-HR-Employee-Attrition"
      group by 1, 2, 4
      order by 2, 1) pod
order by 2, 1;
--department->attrition
select *, round(liczba_pracownikow / sum(liczba_pracownikow) over (partition by department), 2) as procent
from (select department, attrition, count(1) as liczba_pracownikow
      from "WA_Fn-UseC_-HR-Employee-Attrition"
      group by 1, 2
      order by 1) pod
-- monthlyincome->jobsatisfaction->attrition
select *, round(liczba_pracowników/sum(liczba_pracowników) over (partition by zarobki),2) as procent from (select (case
            when monthlyincome < 1000 then '<1000'
            when monthlyincome <= 3000 then '<=3000'
            when monthlyincome <= 5000 then '<=5000'
            when monthlyincome <= 7000 then '<=7000'
            when monthlyincome <= 9000 then '<=9000'
            when monthlyincome <= 11000 then '<=11000'
            when monthlyincome <= 13000 then '<=13000'
            when monthlyincome <= 15000 then '<=15000'
            when monthlyincome <= 17000 then '<=17000'
            when monthlyincome <= 19000 then '<=19000'
            when monthlyincome <= 21000 then '<=21000' end) as zarobki,
       jobsatisfaction,
       attrition,
       count(1) as liczba_pracowników
from "WA_Fn-UseC_-HR-Employee-Attrition"
group by 2, 1,3
order by 1) pod
order by 1;
-- jobsatisfaction->attrition
select *, round(liczba_pracownikow / sum(liczba_pracownikow) over (partition by jobsatisfaction), 2) as procent
from (select jobsatisfaction, attrition, count(1) as liczba_pracownikow
      from "WA_Fn-UseC_-HR-Employee-Attrition"
      group by 1, 2
      order by 1) pod
order by 1;
-- jobsatisfaction->monthlyincome
select *, round(liczba_pracownikow / sum(liczba_pracownikow) over (partition by zarobki), 2) as procent
from (select jobsatisfaction, (case
            when monthlyincome < 1000 then '<1000'
            when monthlyincome <= 3000 then '<=3000'
            when monthlyincome <= 5000 then '<=5000'
            when monthlyincome <= 7000 then '<=7000'
            when monthlyincome <= 9000 then '<=9000'
            when monthlyincome <= 11000 then '<=11000'
            when monthlyincome <= 13000 then '<=13000'
            when monthlyincome <= 15000 then '<=15000'
            when monthlyincome <= 17000 then '<=17000'
            when monthlyincome <= 19000 then '<=19000'
            when monthlyincome <= 21000 then '<=21000' end) as zarobki, count(1) as liczba_pracownikow
      from "WA_Fn-UseC_-HR-Employee-Attrition"
      group by 1, 2
      order by 1) pod
order by 2;
-- montlhyincome->jobrole->department
select *, round(liczba_pracownikow / sum(liczba_pracownikow) over (partition by department), 3) as procent
from (select jobrole, department, (case
            when monthlyincome < 1000 then '<1000'
            when monthlyincome <= 3000 then '<=3000'
            when monthlyincome <= 5000 then '<=5000'
            when monthlyincome <= 7000 then '<=7000'
            when monthlyincome <= 9000 then '<=9000'
            when monthlyincome <= 11000 then '<=11000'
            when monthlyincome <= 13000 then '<=13000'
            when monthlyincome <= 15000 then '<=15000'
            when monthlyincome <= 17000 then '<=17000'
            when monthlyincome <= 19000 then '<=19000'
            when monthlyincome <= 21000 then '<=21000' end) as zarobki, count(1) as liczba_pracownikow
      from "WA_Fn-UseC_-HR-Employee-Attrition"
group by 1,3,2
order by 2 desc,1) pod
where department like 'Research & Development'
order by 1 desc, 3 desc;

select distinct department, jobrole from "WA_Fn-UseC_-HR-Employee-Attrition"
where department like 'Research & Development';
--Monthlyincome->EducationField->Education
select *, round(liczba_pracownikow / sum(liczba_pracownikow) over (), 2) as procent
from (select Education,jobrole, count(1) as liczba_pracownikow
      from "WA_Fn-UseC_-HR-Employee-Attrition"
group by 1,2
order by 2 desc,1) pod
where jobrole like 'Research Director'
order by 3 desc;

select *, round(liczba_pracownikow / sum(liczba_pracownikow) over (partition by educationfield), 2) as procent
from (select educationfield, (case
            when monthlyincome < 1000 then '<1000'
            when monthlyincome <= 3000 then '<=3000'
            when monthlyincome <= 5000 then '<=5000'
            when monthlyincome <= 7000 then '<=7000'
            when monthlyincome <= 9000 then '<=9000'
            when monthlyincome <= 11000 then '<=11000'
            when monthlyincome <= 13000 then '<=13000'
            when monthlyincome <= 15000 then '<=15000'
            when monthlyincome <= 17000 then '<=17000'
            when monthlyincome <= 19000 then '<=19000'
            when monthlyincome <= 21000 then '<=21000' end) as zarobki, count(1) as liczba_pracownikow
      from "WA_Fn-UseC_-HR-Employee-Attrition"
group by 1,2
order by 2 desc,1) pod
where educationfield like 'Technical Degree'
order by 2 desc, 3 desc;

select *, round(liczba_pracownikow / sum(liczba_pracownikow) over (partition by educationfield), 3) as procent
from (select educationfield, jobrole, count(1) as liczba_pracownikow
      from "WA_Fn-UseC_-HR-Employee-Attrition"
group by 1,2
order by 2 desc,1) pod
where educationfield like 'Technical Degree'
order by 2 desc, 3 desc;

select distinct educationfield from "WA_Fn-UseC_-HR-Employee-Attrition"