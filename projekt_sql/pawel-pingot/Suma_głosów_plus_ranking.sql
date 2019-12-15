select hillary_clinton_votes.party, hillary_clinton_votes.state, bernie_sanders_votes.candidate, hillary_clinton_votes.candidate, suma_głosów_hillary, suma_głosów_bernie,
       suma_głosów_bernie + suma_głosów_hillary as Total,
       case when suma_głosów_hillary > suma_głosów_bernie then 1
when suma_głosów_bernie > suma_głosów_hillary then 2 end as ranking
from (select distinct pr.party,
                      pr.state,
                      pr.candidate,
                      sum(pr.votes) over (partition by pr.state) as suma_głosów_hillary
      from primary_results pr
      WHERE pr.candidate = 'Hillary Clinton') as hillary_clinton_votes
         join
     (select distinct pr.party,
                      pr.state,
                      pr.candidate,
                      sum(pr.votes) over (partition by pr.state) as suma_głosów_bernie
      from primary_results pr
      WHERE pr.candidate = 'Bernie Sanders') as bernie_sanders_votes
     on hillary_clinton_votes.state = bernie_sanders_votes.state;

