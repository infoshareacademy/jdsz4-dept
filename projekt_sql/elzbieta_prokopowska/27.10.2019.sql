---PROJEKT:
--odpowiedź na pytanie: Dlaczego Hillary Clinton zmieżdżyła Berniego Sandersa (oboje demokraci) Alabamie (77,8%) a Berni Sanders zgniótł Hillary Clinton w Utah (79,3%).
--Jakie cechy demograficzne weźniemy pod uwagę.

-------------------Porównanie dwóch kandydatów B.sanders vs. H.Clinton
--------------ogólna analiza bazy primary_results:
--------stany USA:
select count(distinct state) from primary_results

select distinct state from primary_results

--------kandydaci i ich partie:
select count(distinct candidate) from primary_results

select distinct candidate, party from primary_results

---------kandydaci i stany USA:
select distinct p.state, p.candidate from primary_results p

--ilosc głosów oddana na każdego kandydata w poszczególnym stanie USA:
select sum(p.votes) as sum_votes
from primary_results p

select p.candidate, sum(p.votes)
from primary_results p
group by 1
order by 2 desc

----ilosc glosów na poszczególnego kandydata i % głosów z totalu głosów:
select distinct  p.candidate, sum(p.votes)over(partition by p.candidate)  as sum_votes, sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.candidate)  / sum(p.votes) over () ::numeric as perc_votes
from primary_results p
order by perc_votes desc

----ilosć głosów na poszczególna partię oraz % per total:
select distinct  p.party, sum(p.votes)over(partition by p.party)  as sum_party_votes, sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party) / sum(p.votes) over () ::numeric as perc_votes
from primary_results p
order by perc_votes desc



--------dalsza częśś analizy jeszcze --- w trakcie:



select p.state, p.county, p.candidate, p.party, p.votes
from primary_results p

select p.state, p.candidate, p.party, sum(p.votes) as sum_votes
from primary_results p
group by 1,2,3
order by sum_votes desc


--- ilosc głosów na Hillary Clinton oddnana w każdym country:
select distinct p.state, p.county, p.state_abbreviation, p.candidate, p.party, p.votes
from primary_results p
where p.candidate = 'Hillary Clinton'


---wypisanie kandydatek w stanach, w którym obie wystąpiły:
select p.state, p.candidate, p.party, p.votes, p.fraction_votes
from primary_results p
where p.state like 'Io%' or p.state like 'New H%'
group by 1,2,3,4,5
having p.candidate like 'Carl%' or p.candidate like 'Hil%'
order by p.state DESC


--------analiza country_facts - łączenie tabel country_facts i country_facts_dictionary:
select cf.area_name, cf.PST045214 as Population_2014_estimate
from county_facts cf

---wypisanie sumy głosów na dwóch kandydatów: Berniego i Hilary:
select p.state, p.candidate, p.party, sum(p.votes)
from primary_results p
where p.state like 'Alab%' or p.state like 'Ut%'
group by 1,2,3
having p.candidate like 'Ber%' or p.candidate like 'Hil%'
order by p.state DESC

---suma głosów na poszczególnych kandydatów w Alabamie i Utah:
select p.state, p.candidate, p.party, sum(p.votes)
from primary_results p
where p.state like 'Ut%' or p.state like 'Ala%'
group by 1,2,3

--suma głosów na poszczególnych kandydatów w stanie Utah:
select candidate, party, sum(votes) from primary_results where state = 'Utah'
group by candidate, party

select candidate, party, sum(votes) from primary_results where state = '%Alab%'
group by candidate, party









