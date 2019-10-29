-- Liczba populacji i procentowa zawartość ludzi w danym przedziale wiekowym
select c.fips, c.area_name, c.state_abbreviation, c.pst045214 as populacja,
       c.age135214 as wiek_poniżej_5, c.age295214 as wiek_poniżej_18, c.age775214 as wiek_65_i_powyzej from county_facts c;
-- Liczba populacji w stanie Alabama, z podziałem na county w stosunku do oddanych głosów na Bernie Sanders i Hillary Clinton
select c.fips, c.area_name, c.state_abbreviation, c.pst045214 as populacja, p.votes as glosy, p. candidate from county_facts c
left join primary_results p on c.fips = p.fips
where c.state_abbreviation like 'AL' and candidate like 'Bernie Sanders' or
      c.state_abbreviation like 'AL' and candidate = 'Hillary Clinton'
group by c.fips, p.candidate, c.area_name, c.state_abbreviation, populacja, glosy;

--
(select c.fips, c.area_name, c.state_abbreviation, c.pst045214 as populacja, p.votes as glosy, p. candidate from county_facts c
left join primary_results p on c.fips = p.fips
where c.state_abbreviation like 'AL' and candidate like 'Bernie Sanders' or
      c.state_abbreviation like 'AL' and candidate = 'Hillary Clinton'
group by c.fips, p.candidate, c.area_name, c.state_abbreviation, populacja, glosy) as wynik_glosy
where candidate like 'Bernie Sanders'