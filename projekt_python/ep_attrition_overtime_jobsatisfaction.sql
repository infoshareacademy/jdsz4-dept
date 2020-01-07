---Analiza kategorii: Attrition vs. OverTime and JobSatisfaction

--Liczba wszystkich rekordów:
select count(employeenumber) as total
from "WA_Fn-UseC_-HR-Employee-Attrition";

--Kategorie Overtime, liczba rekordów i procent:
select distinct wa.overtime,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.overtime) as am_over,
    sum(wa.employeecount) over (partition by wa.overtime) / sum(wa.employeecount) over () ::numeric as prc_over
from "WA_Fn-UseC_-HR-Employee-Attrition" wa;

--Kategorie Jobsatifaction, liczba rekordów i procent:
select distinct wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) as am_job,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_job
from "WA_Fn-UseC_-HR-Employee-Attrition" wa;

select distinct wa.attrition,
    wa.overtime,
    sum(wa.employeecount) over () as total
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

--Procentowy rozkład ze względu na Attrition i Overtime:
select distinct wa.attrition,
    wa.overtime,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.overtime) as am_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime) as att_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime) / sum(wa.employeecount) over () ::numeric as prc_att_overt
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

---Procentowy rozkład ze względu na Attrition i Overtime i Jobsatisfaction:

select distinct wa.attrition,
    wa.overtime,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime, wa.jobsatisfaction) as att_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime, wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_at_ov_js
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

--1 'Low'
select distinct wa.attrition,
    wa.overtime,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.overtime) as am_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime) as att_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime) / sum(wa.employeecount) over () ::numeric as prc_att_overt
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 1

--2 'Medium'
select distinct wa.attrition,
    wa.overtime,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.overtime) as am_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime) as att_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime) / sum(wa.employeecount) over () ::numeric as prc_att_overt
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 2

--3 'High'
select distinct wa.attrition,
    wa.overtime,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.overtime) as am_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime) as att_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime) / sum(wa.employeecount) over () ::numeric as prc_att_overt
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 3

--4 'Very High'
select distinct wa.attrition,
    wa.overtime,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.overtime) as am_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime) as att_overt,
    sum(wa.employeecount) over (partition by wa.attrition, wa.overtime) / sum(wa.employeecount) over () ::numeric as prc_att_overt
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 4
