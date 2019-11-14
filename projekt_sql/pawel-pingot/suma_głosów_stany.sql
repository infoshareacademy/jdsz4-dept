-- Jak Hillary wygrała w Alabamie i innych stanach
select * from
(select distinct pr.party, pr.state, pr.candidate,
                sum(pr.votes) over (partition by pr.state) as suma_głosów_hillary
from primary_results pr
WHERE pr.candidate = 'Hillary Clinton') as hillary_clinton_votes
join
(select distinct pr.party, pr.state, pr.candidate,
                sum(pr.votes) over (partition by pr.state) as suma_głosów_bernie
from primary_results pr
WHERE pr.candidate = 'Bernie Sanders') as bernie_sanders_votes
on hillary_clinton_votes.state = bernie_sanders_votes.state;
-- Sprawdzenie poprawności działania powyższego kodu
select distinct  p.party, sum(p.votes)over(partition by p.party)  as sum_party_votes, sum(p.votes) over () sum_total,
                sum(p.votes)over(partition by p.party) / sum(p.votes) over () ::numeric as perc_votes
from primary_results p
where p.state like 'Alabama' and p.candidate like 'Ber%'
order by perc_votes desc;