select employeenumber, attrition, dailyrate, hourlyrate, monthlyrate, monthlyincome
from "WA_Fn-UseC_-HR-Employee-Attrition";

select *, round(liczba_pracowników/sum(liczba_pracowników) over (partition by zarobki), 2) as procent from (select distinct (case
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
                     when monthlyincome <= 21000 then '<=21000' end) as zarobki, attrition,
                count(1) as liczba_pracowników
from "WA_Fn-UseC_-HR-Employee-Attrition"
group by 1,2
order by 1) pod