-------------------Porównanie Demeokraci vs. Republikanie
--------------ogólna analiza bazy primary_results:
--------stany USA:
--ilość:
select count(distinct state) from primary_results
--nazwy:
select distinct state from primary_results

--------Kandydaci i ich Partie:
--ilosć kandydatów:
select count(distinct candidate) from primary_results

--kandydat i jego partia:
select distinct candidate, party from primary_results

--kandydaci i stany, w ktorych kandydowali:
select distinct p.state, p.candidate from primary_results p

--kandydaci nieoznaczeni(Uncommitted i No Preference) oraz przypisane do nich stany i partia:
select distinct p.candidate, p.state, p.party
from primary_results p
where p.candidate like ' No Preference' or p.candidate like ' Uncommitted'

----ilosć głosów na poszczególna partię oraz % per total:
select sum(p.votes)
from primary_results p

select distinct  p.party, sum(p.votes)over(partition by p.party)  as sum_party_votes, sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party) / sum(p.votes) over () ::numeric as perc_votes
from primary_results p
order by perc_votes desc

--------suma głosów oddanych na poszczególna partię w poszczególnym stanie
select p.state, p.party, sum(p.votes) from primary_results p
group by p.state, p.party
order by sum(p.votes) desc

--suma głosów oddanych na Demokratów w poszczególnych stanach:
select p.state, p.party, sum(p.votes) from primary_results p
where p.party like'Dem%'
group by p.state, p.party
order by sum(p.votes) desc

--suma głosów oddanych na Republikanów w poszczególnych stanach:
select p.state, p.party, sum(p.votes) from primary_results p
where p.party like 'Rep%'
group by p.state, p.party
order by sum(p.votes) desc

--stany, w których nie oddano glosów na Republikanów:
select *
from
     (select p.state, p.party, sum(p.votes) from primary_results p
where p.party like'Dem%'
group by p.state, p.party
order by sum(p.votes) desc) demokraci_stany
FULL OUTER JOIN
         (select p.state, p.party, sum(p.votes) from primary_results p
where p.party like 'Rep%'
group by p.state, p.party
order by sum(p.votes) desc) republikanie_stany
on demokraci_stany.state = republikanie_stany.state
where republikanie_stany.state is null

--zestawienie stanów: Demokraci vs. Republikanie:
select *
from
     (select p.state, p.party, sum(p.votes) as suma_gosow_na_demokratow from primary_results p
where p.party like'Dem%'
group by p.state, p.party
order by sum(p.votes) desc) demokraci_stany
left join
         (select p.state, p.party, sum(p.votes) as suma_glosow_na_republikanow from primary_results p
where p.party like 'Rep%'
group by p.state, p.party
order by sum(p.votes) desc) republikanie_stany
on demokraci_stany.state = republikanie_stany.state

--suma głosów oddanych w stanach, w których głosowano tylko na Demokratów:
select p.party, sum(p.votes) as sum_votes_democrat_states
from primary_results p
where p.state like 'Colorado' or p.state like 'Main%' or p.state like 'North Da%'
group by p.party

---procent glosów oddanych w poszczególnych stanach na poszcególne partie:
select distinct  p.party, p.state,
                sum(p.votes)over(partition by p.party, p.state)  as sum_party_state__votes,
                sum(p.votes)over(partition by p.party)  as sum_party_votes,
                sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party, p.state) / sum(p.votes) over () ::numeric as perc_party_state_votes,
                sum(p.votes)over(partition by p.party) / sum(p.votes) over () ::numeric as perc_votes
from primary_results p
order by perc_party_state_votes desc

--tylko na Demokratów:
select distinct  p.party, p.state,
                sum(p.votes)over(partition by p.party, p.state)  as sum_party_state__votes,
                sum(p.votes)over(partition by p.party)  as sum_party_votes,
                sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party, p.state) / sum(p.votes) over () ::numeric as perc_party_state_votes
from primary_results p
where p.party like 'Demo%'
order by perc_party_state_votes desc

--tylko na Republikanów:
select distinct  p.party, p.state,
                sum(p.votes)over(partition by p.party, p.state)  as sum_party_state__votes,
                sum(p.votes)over(partition by p.party)  as sum_party_votes,
                sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party, p.state) / sum(p.votes) over () ::numeric as perc_party_state_votes
from primary_results p
where p.party like 'Rep%'
order by perc_party_state_votes desc

---zestawienie ilościowe i procentowe glosów oddanych na poszczególne partie w poszczególnych stanach:

/* analiza wstępna: */
select
       percent_democrat.state,
       percent_democrat.sum_democrat_votes,
       percent_democrat.perc_democrat_votes,
       percent_republican.sum_republican_votes,
       percent_republican.perc_republican_votes
from (select distinct  p.party, p.state,
                sum(p.votes)over(partition by p.party, p.state)  as sum_democrat_votes,
                sum(p.votes)over(partition by p.party)  as sum_party_votes,
                sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party, p.state) / sum(p.votes) over () ::numeric as perc_democrat_votes,
                sum(p.votes)over(partition by p.party) / sum(p.votes) over () ::numeric as perc_votes
from primary_results p
where p.party like 'Demo%'
order by perc_democrat_votes desc) percent_democrat
left join
    (select distinct  p.party, p.state,
                sum(p.votes)over(partition by p.party, p.state)  as sum_republican_votes,
                sum(p.votes)over(partition by p.party)  as sum_party_votes,
                sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party, p.state) / sum(p.votes) over () ::numeric as perc_republican_votes,
                sum(p.votes)over(partition by p.party) / sum(p.votes) over () ::numeric as perc_votes
from primary_results p
where p.party like 'Rep%'
order by perc_republican_votes desc) percent_republican
on percent_democrat.state = percent_republican.state
order by percent_democrat.perc_democrat_votes desc

---jaka partia wygrała w jakim stanie:
select distinct p.party, p.state,
                sum(p.votes)over(partition by p.party, p.state)  as sum_party_state__votes,
                sum(p.votes)over(partition by p.party)  as sum_party_votes,
                sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party, p.state) / sum(p.votes) over () ::numeric as perc_party_state_votes,
                sum(p.votes)over(partition by p.party) / sum(p.votes) over () ::numeric as perc_party_votes
from primary_results p
order by perc_party_state_votes desc

--wyznaczenie zwycięzkiej partii w poszczególnym stanie:
with party_state as
(select distinct p.party, p.state,
                sum(p.votes)over(partition by p.party, p.state)  as sum_party_state_votes,
                sum(p.votes)over(partition by p.party)  as sum_party_votes,
                sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party, p.state) / sum(p.votes) over () ::numeric as perc_party_state_votes,
                sum(p.votes)over(partition by p.party) / sum(p.votes) over () ::numeric as perc_party_votes
from primary_results p
    order by sum_party_state_votes desc)
select
       party_state.state,
       party_state.party,
       party_state.sum_party_state_votes ::numeric,
       max (party_state.sum_party_state_votes ::numeric) over (partition by party_state.state) as winner_votes,
       (party_state.sum_party_state_votes ::numeric - max (party_state.sum_party_state_votes ::numeric) over (partition by party_state.state)) as diff_votes
from party_state
order by party_state.state, party_state.party, party_state.sum_party_state_votes ::numeric

--zwycięska partia w poszczególnym stanie:
with winner_party_state as
    (with party_state as
(select distinct p.party, p.state,
                sum(p.votes)over(partition by p.party, p.state)  as sum_party_state_votes,
                sum(p.votes)over(partition by p.party)  as sum_party_votes,
                sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party, p.state) / sum(p.votes) over () ::numeric as perc_party_state_votes,
                sum(p.votes)over(partition by p.party) / sum(p.votes) over () ::numeric as perc_party_votes
from primary_results p
    order by sum_party_state_votes desc)
select
       party_state.state,
       party_state.party,
       party_state.sum_party_state_votes ::numeric,
       max (party_state.sum_party_state_votes ::numeric) over (partition by party_state.state) as winner_votes,
       (party_state.sum_party_state_votes ::numeric - max (party_state.sum_party_state_votes ::numeric) over (partition by party_state.state)) as diff_votes
from party_state
order by party_state.state, party_state.party, party_state.sum_party_state_votes ::numeric)
select *
from winner_party_state
where winner_party_state.diff_votes = 0