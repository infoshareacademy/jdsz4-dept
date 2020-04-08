---Analiza pary: Attrition vs. Age

--Liczba wszystkich rekordów:
select count(employeenumber) as total
from "WA_Fn-UseC_-HR-Employee-Attrition";

--Kategorie wiekowe:
select distinct wa.age
from "WA_Fn-UseC_-HR-Employee-Attrition" wa;

select distinct wa.attrition,
    wa.age,
    sum(wa.employeecount) over () as total
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

--Liczba pracowników w poszczególnej parze kategorii:
select wa.age, wa.attrition, count(1)
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
group by 1,2

--Liczba procowników w poszczególntm wieku z Attrition 'Yes':
select wa.age, wa.attrition, count(1)
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.attrition like 'Yes'
group by 1,2

--Liczba pracowników w podziale na zakresy wiekowe z Attrition 'Yes':
select
    sum(case when wa.age between '18' and '20' then wa.employeecount else 0 end) as age_18_20,
    sum(case when wa.age between '21' and '25' then wa.employeecount else 0 end) as age_21_25,
    sum(case when wa.age between '26' and '30' then wa.employeecount else 0 end) as age_26_30,
    sum(case when wa.age between '31' and '35' then wa.employeecount else 0 end) as age_31_35,
    sum(case when wa.age between '36' and '40' then wa.employeecount else 0 end) as age_36_40,
    sum(case when wa.age between '41' and '45' then wa.employeecount else 0 end) as age_41_45,
    sum(case when wa.age between '46' and '50' then wa.employeecount else 0 end) as age_46_50,
    sum(case when wa.age between '51' and '55' then wa.employeecount else 0 end) as age_51_55,
    sum(case when wa.age between '56' and '60' then wa.employeecount else 0 end) as age_56_60
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.attrition like 'Yes';

--Liczba pracowników w największych liczebnie przedziałach wiekowych:
with age_att_y as
    (select wa.age, wa.attrition, count(1)
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.attrition like 'Yes'
group by 1,2)
select * from age_att_y aay
where 1=1
and aay.age between '26' and '30'

with age_att_y as
    (select wa.age, wa.attrition, count(1)
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.attrition like 'Yes'
group by 1,2)
select * from age_att_y aay
where 1=1
and aay.age between '31' and '35';

--Procentowy udział najliczniejszych kategorii wiekowych:
select
    count(wa.employeenumber) as total,
    sum(case when wa.age between '26' and '30' then wa.employeecount else 0 end) as age_26_30,
    sum(case when wa.age between '31' and '35' then wa.employeecount else 0 end) as age_31_35,
    sum(case when wa.age between '26' and '35' then wa.employeecount else 0 end) as age_26_35,
    sum(case when wa.age between '26' and '30' then wa.employeecount else 0 end) / count(wa.employeenumber) ::numeric as prc_26_30,
    sum(case when wa.age between '31' and '35' then wa.employeecount else 0 end) / count(wa.employeenumber) ::numeric as prc_31_35,
    sum(case when wa.age between '26' and '35' then wa.employeecount else 0 end) / count(wa.employeenumber) ::numeric as prc_26_35
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.attrition like 'Yes';
















































