--Bernie Sanders w Alabamie dla wszystkich countie's

select *
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      pr.candidate = 'Bernie Sanders'
order by pr.votes;

-- Hillary Clinton w Alabamie dla wszystkich countie's

select *
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      pr.candidate = 'Hillary Clinton'
order by pr.votes;

--Bernie dla Jefferson

select *
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      pr.candidate = 'Bernie Sanders' and
      pr.county = 'Jefferson'
order by pr.votes;

-- Hillary dla Jefferson

select *
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      pr.candidate = 'Hillary Clinton' and
      pr.county = 'Jefferson'
order by pr.votes;

-- Hillary i Sanders dla Jefferson County

select *
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      pr.candidate = 'Bernie Sanders' and
      pr.county = 'Jefferson'
union
select *
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      pr.candidate = 'Hillary Clinton' and
      pr.county = 'Jefferson'
order by pr.votes;

select * --wersja skrócona tego powyżej
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      (pr.candidate = 'Hillary Clinton' or
      pr.candidate = 'Bernie Sanders') and
      pr.county = 'Jefferson'
order by pr.votes;
--

select * --wersja skrócona tego powyżej dla Cleburne County
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      (pr.candidate = 'Hillary Clinton' or
      pr.candidate = 'Bernie Sanders') and
pr.county = 'Cleburne'
order by pr.votes;

select * from primary_results pr
where pr.state = 'Alabama';

--- Vote fraction dla Clinton i Sandersa dla pojedynczego county w Alabamie

select *
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      (pr.candidate = 'Hillary Clinton' or pr.candidate = 'Bernie Sanders')
order by pr.state;

select pr.state,pr.county, pr.candidate, pr.fraction_votes
from primary_results pr,
    (
    select pr.fraction_votes
from primary_results pr
where pr.candidate is 'Bernie Sanders' and county is 'Autauga'
        ) as sanders,
     (select pr.fraction_votes
from primary_results pr
where pr.candidate is 'Hillary Clinton' and county is 'Autauga') as clinton;

--- proba policzenia, roznica miedzy fraction votes miedzy Sanders i Clinton
select (
    select pr.fraction_votes
from primary_results pr
where pr.candidate is 'Bernie Sanders' and county is 'Autauga'
        ) -
     (select pr.fraction_votes
from primary_results pr
where pr.candidate is 'Hillary Clinton' and county is 'Autauga') as sanders_clinton

-- to samo tylko prosciej...

select pr.state,pr.county, pr.candidate, pr.fraction_votes
from primary_results pr
where pr.candidate is 'Bernie Sanders' or pr.candidate is 'Hillary Clinton';

-- County w Alabamie, gdzie Sanders mial proporcjonalnie najwiecej glosow

select max(fraction_votes),
pr.state,pr.county, pr.candidate, pr.votes
from primary_results pr
where pr.candidate is 'Bernie Sanders' and
      state is 'Alabama';

-- County w Alabamie, gdzie Clinton miala proporcjonalnie najwiecej glosow

select max(fraction_votes),
pr.state,pr.county, pr.candidate, pr.votes
from primary_results pr
where pr.candidate is 'Hillary Clinton' and
      state is 'Alabama';

--- Clinton najwiece w Clarke
--- Sanders najwiecej w Blount


--- In progress porownanie charakterystyk...

select * --wersja skrócona tego powyżej
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      (pr.candidate = 'Hillary Clinton' or
      pr.candidate = 'Bernie Sanders') and
      pr.county = 'Clarke'
union
select *
from primary_results pr
left join county_facts cf on pr.fips = cf.fips
where pr.state_abbreviation = 'AL' and
      (pr.candidate = 'Hillary Clinton' or
      pr.candidate = 'Bernie Sanders') and
      pr.county = 'Blount'
group by pr.candidate, pr.county
order by pr.votes;