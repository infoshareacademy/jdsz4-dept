---Analiza kategorii: Attrition vs. Department and JobSatisfaction

--Liczba wszystkich rekordów:
select count(employeenumber) as total
from "WA_Fn-UseC_-HR-Employee-Attrition";

--Kategorie Department, liczba rekordów i procent:
select distinct wa.department,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.department) / sum(wa.employeecount) over () ::numeric as prc_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa;

--Kategorie Jobsatifaction, liczba rekordów i procent:
select distinct wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) as am_job,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_job
from "WA_Fn-UseC_-HR-Employee-Attrition" wa;

select distinct wa.attrition,
    wa.department,
    sum(wa.employeecount) over () as total
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

--Procentowy rozkład ze względu na Attrition i Department:
select distinct wa.attrition,
    wa.department,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) as att_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

select distinct wa.attrition,
    wa.department,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) as att_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.department like 'Res%'

select distinct wa.attrition,
    wa.department,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) as att_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.department like 'Sa%'

select distinct wa.attrition,
    wa.department,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) as att_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.department like 'Hu%'

---Procentowy rozkład ze względu na Attrition i Department i Jobsatisfaction:

select distinct wa.attrition,
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department, wa.jobsatisfaction) as att_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department, wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_at_dp_js
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

--1 'Low':
select distinct
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 1

select distinct wa.attrition,
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) as att_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 1

--2 'Medium':
select distinct
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 2

select distinct wa.attrition,
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) as att_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 2

--3 'High':
select distinct
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 3

select distinct wa.attrition,
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) as att_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 3

--4 'Very High':
select distinct
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 4

select distinct wa.attrition,
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.attrition) as am_att,
    sum(wa.employeecount) over (partition by wa.department) as am_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) as att_dep,
    sum(wa.employeecount) over (partition by wa.attrition, wa.department) / sum(wa.employeecount) over () ::numeric as prc_att_dep
from "WA_Fn-UseC_-HR-Employee-Attrition" wa

-- Zestawienie JobSatisfaction per Departament:

select distinct
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) as am_js,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_dep_js
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.department like 'Re%'

select distinct
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) as am_js,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_dep_js
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.department like 'Sa%'

select distinct
    wa.department,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) as am_js,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_dep_js
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.department like 'Hu%'