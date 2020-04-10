---Analiza kategorii: JobRole vs. EducationField and Education and JobSatisfaction

--Liczba wszystkich rekordów:
select count(employeenumber) as total
from "WA_Fn-UseC_-HR-Employee-Attrition";

--Kategorie JobRole, liczba rekordów i procent:
select distinct wa.jobrole,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole) as am_jobrole,
    sum(wa.employeecount) over (partition by wa.jobrole) / sum(wa.employeecount) over () ::numeric as prc_jobrole
from "WA_Fn-UseC_-HR-Employee-Attrition" wa;

--Kategorie EducationField, liczba rekordów i procent:
select distinct wa.educationfield,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.educationfield) as am_edufield,
    sum(wa.employeecount) over (partition by wa.educationfield) / sum(wa.employeecount) over () ::numeric as prc_edufield
from "WA_Fn-UseC_-HR-Employee-Attrition" wa;

--Kategorie Education, liczba rekordów i procent:
select distinct wa.education,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.education) as am_educ,
    sum(wa.employeecount) over (partition by wa.education) / sum(wa.employeecount) over () ::numeric as prc_educ
from "WA_Fn-UseC_-HR-Employee-Attrition" wa;

--Kategorie Jobsatifaction, liczba rekordów i procent:
select distinct wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) as am_job,
    sum(wa.employeecount) over (partition by wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_job
from "WA_Fn-UseC_-HR-Employee-Attrition" wa;

---Procentowy rozkład ze względu na JobRole i Jobsatisfaction:

select distinct wa.jobrole,
    wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction) as jobrole_satisfaction,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_jobrole_satisfaction
from "WA_Fn-UseC_-HR-Employee-Attrition" wa;

select distinct wa.jobrole,
                wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole) as jobrole_satisfaction,
    sum(wa.employeecount) over (partition by wa.jobrole) / sum(wa.employeecount) over () ::numeric as prc_jobrole_satisfaction
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 4;

select distinct wa.jobrole,
                wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole) as jobrole_satisfaction,
    sum(wa.employeecount) over (partition by wa.jobrole) / sum(wa.employeecount) over () ::numeric as prc_jobrole_satisfaction
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 3;

select distinct wa.jobrole,
                wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole) as jobrole_satisfaction,
    sum(wa.employeecount) over (partition by wa.jobrole) / sum(wa.employeecount) over () ::numeric as prc_jobrole_satisfaction
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 2;

select distinct wa.jobrole,
                wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole) as jobrole_satisfaction,
    sum(wa.employeecount) over (partition by wa.jobrole) / sum(wa.employeecount) over () ::numeric as prc_jobrole_satisfaction
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobsatisfaction = 1;

select distinct wa.jobrole,
                wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction) as jobrole_satisfaction,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_jobrole_satisfaction
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobrole like 'Research S%';

select distinct wa.jobrole,
                wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction) as jobrole_satisfaction,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_jobrole_satisfaction
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobrole like 'Laboratory T%';

select distinct wa.jobrole,
                wa.jobsatisfaction,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction) as jobrole_satisfaction,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction) / sum(wa.employeecount) over () ::numeric as prc_jobrole_satisfaction
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobrole like 'Sales E%';

--Jak wyglada rozkład JobRole, JobSatisfaction i Education:
select distinct wa.jobrole,
                wa.jobsatisfaction,
                wa. education,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction, wa.education) as jobrole_satisfaction,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction, wa.education) / sum(wa.employeecount) over () ::numeric as prc_jobrole_satisfaction
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobrole like 'Research S%'
and wa.jobsatisfaction = 4;

--Jak wyglada rozkład JobRole, JobSatisfaction i Education i EducationField:
select distinct wa.jobrole,
                wa.jobsatisfaction,
                wa. education,
                wa.educationfield,
    sum(wa.employeecount) over () as total,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction, wa.education, wa.educationfield) as jobrole_satisfaction,
    sum(wa.employeecount) over (partition by wa.jobrole, wa.jobsatisfaction, wa.education, wa.educationfield) / sum(wa.employeecount) over () ::numeric as prc_jobrole_satisfaction
from "WA_Fn-UseC_-HR-Employee-Attrition" wa
where wa.jobrole like 'Research S%'
and wa.jobsatisfaction = 4;
