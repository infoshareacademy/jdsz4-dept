---Analiza pary: Attrition vs. Businesstravel

--Liczba wszystkich rekordów:
select count(employeenumber) as total
from "WA_Fn-UseC_-HR-Employee-Attrition";

select distinct wa.attrition,
    "left"(wa.businesstravel,6) as travel_non_tr,
    sum(wa.employeecount) over () as total
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

--Liczba pracowników w poszczególnej parze kategorii:
select businesstravel, attrition, count(1)
from "WA_Fn-UseC_-HR-Employee-Attrition"
group by businesstravel, attrition

select attrition, businesstravel, count(1)
from "WA_Fn-UseC_-HR-Employee-Attrition"
group by 1,2

--Liczba pracowników w zawężeniu na Travel i Non-Travel przy udziale Attrition Yes i No:
select attrition, "left"(businesstravel,6) as travel_non_tr, count(1) as amou_travel_non_tr
from "WA_Fn-UseC_-HR-Employee-Attrition"
group by 1,2

--Procentowy rozkład przy zawężeniu na Travel i Non-Travel:
select distinct wa.attrition,
    "left"(wa.businesstravel,6) as travel_non_tr,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as att_y_n,
    sum(wa.employeecount) over (partition by wa.attrition, ("left"(wa.businesstravel,6))) as travel_non_tr,
    sum(wa.employeecount) over (partition by wa.attrition) / sum(wa.employeecount) over ()::numeric as prc_total_y_n,
    sum(wa.employeecount) over (partition by wa.attrition, ("left"(wa.businesstravel,6))) / sum(wa.employeecount) over ()::numeric as prc_total_travel
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

--Procentowy rozkład na wszystkie kategorie Businesstravel:
select distinct wa.attrition,
    wa.businesstravel,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as att_y_n,
    sum(wa.employeecount) over (partition by wa.attrition, WA.businesstravel) as travel_non_tr,
    sum(wa.employeecount) over (partition by wa.attrition) / sum(wa.employeecount) over () :: numeric as prc_total_y_n,
    sum(wa.employeecount) over (partition by wa.attrition, WA.businesstravel) / sum(wa.employeecount) over (partition by wa.attrition) :: numeric as prc_total_non_tr
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

