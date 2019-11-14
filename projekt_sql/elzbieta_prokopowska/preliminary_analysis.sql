select * from primary_results

select count(1) from primary_results
--where state_abbreviation = 'AL'

select distinct state from primary_results

select distinct candidate, party from primary_results

select distinct p.state, p.candidate from primary_results p

select distinct p.state, p.state_abbreviation, p.candidate, p.party, count(p.votes)
from primary_results p
where p.candidate = 'Hillary Clinton'


select distinct p.state, p.county, p.state_abbreviation, p.candidate, p.party, p.votes
from primary_results p
where p.candidate = 'Hillary Clinton'

select p.state, p.state_abbreviation, p.candidate, p.party, count(p.votes)
from primary_results p
group by 1,3


select distinct p.state, p.county, p.state_abbreviation, p.candidate, p.party, p.votes, first_value(p.votes) over (partition by p.county order by p.state)
from primary_results p
where p.candidate = 'Hillary Clinton'
group by p.state
