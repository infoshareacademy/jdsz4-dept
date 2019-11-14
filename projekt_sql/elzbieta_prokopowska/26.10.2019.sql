select * from primary_results

select count(1) from primary_results
--where state_abbreviation = 'AL'

--stany USA:
select distinct state from primary_results

--kandydaci i ich partie:
select distinct candidate, party from primary_results

--kandydaci i stany USA:
select distinct p.state, p.candidate from primary_results p

--H.Clinton i ilość głosów łącznie - tu coś jest nie tak z tym zapytaniem????:
select p.state, p.candidate, p.party, count(p.votes)
from primary_results p
where p.candidate = 'Hillary Clinton'

--- ilosc głosów na Hillary Clinton oddnana w każdym country:
select distinct p.state, p.county, p.state_abbreviation, p.candidate, p.party, p.votes
from primary_results p
where p.candidate = 'Hillary Clinton'

--ilosc głosów oddana na każdego kandydata w poszczególnym stanie USA:
select p.state, p.candidate, p.party, p.votes, p.fraction_votes
from primary_results p
group by 1,2
order by p.fraction_votes desc

select p.state, p.candidate, p.party, p.votes, p.fraction_votes
from primary_results p
where candidate like 'Ber%' or candidate like 'Hil%'
group by 1,2
order by p.fraction_votes DESC

select p.state, p.candidate, p.party, p.votes, p.fraction_votes
from primary_results p
where candidate like 'Carl%' or candidate like 'Hil%'
group by 1,2
order by p.fraction_votes DESC

---wypisanie kandydatek w stanach, w którym obie wystąpiły:
select p.state, p.candidate, p.party, p.votes, p.fraction_votes
from primary_results p
where p.state like 'Io%' or p.state like 'New H%'
group by 1,2
having p.candidate like 'Carl%' or p.candidate like 'Hil%'
order by p.state DESC

select p.state, p.candidate, p.party, p.votes, p.fraction_votes,
       case(when p.state like '%Hamp%' or p.state like 'Io%' then 1 end)
from primary_results p
where candidate like 'Carl%' or candidate like 'Hil%'
group by 1,2
order by p.fraction_votes DESC

----????
select p.state, p.state_abbreviation, p.candidate, p.party, count(p.votes)
from primary_results p
group by 1,3

---???/
select distinct p.state, p.county, p.state_abbreviation, p.candidate, p.party, p.votes, first_value(p.votes) over (partition by p.county order by p.state)
from primary_results p
where p.candidate = 'Hillary Clinton'
group by p.state


---analiza country_facts - łączenie tabel country_facts i country_facts_dictionary:
select cf.area_name, cf.PST045214 as 'Population, 2014 estimate'
from county_facts cf

---PROJEKT:
--odpowiedź na pytanie: Dlaczego Hillary Clinton zmieżdżyła Berniego Sandersa (oboje demokraci) Alabamie (77,8%) a Berni Sanders zgniótł Hillary Clinton w Utah (79,3%).
--Jakie cechy demograficzne weźniemy pod uwagę.

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
group by 1,2;

--suma głosów na poszczególnych kandydatów w stanie Utah:
select candidate, party, sum(votes) from primary_results where state = 'Utah'
group by candidate, party;

