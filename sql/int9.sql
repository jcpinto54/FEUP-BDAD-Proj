.mode columns
.headers on
.nullvalue NULL


-- hard2: qual o idioma mais vendido em cada país e sua percentagem das vendas nesse país?
drop view if exists countryLanguageSales;
create temp view if not exists countryLanguageSales as 
select DISTINCT Country.code CC, Language.code LC, Count(Selling.idpublication) nrSales, Country.name CountryN, Language.name LangN
                  from Selling Join Publication on Selling.idPublication = Publication.id
                      join User on Publication.iduser = User.idperson
                      natural join Locality
                      join Country on Locality.nameCountry = Country.code
                      join Book on Publication.isbn = Book.ISBN
                      natural JOIN BookLanguage
                      jOIN Language on Language.code = BookLanguage.codelanguage   
                      Group by Country.code, Language.name;

select CountryN Country, LangN Language,  (100 * nrSales/totalSales) percentage from
  (select CC, LC, nrSales, CountryN, LangN
  from countryLanguageSales T
  where nrSales = (select max(nrSales) 
                   from countryLanguageSales TT
                   where T.CC = TT.CC))
  NATURAL join
  --vendas totais por pais
  (select DISTINCT Country.name as CountryN, Count(Selling.idpublication) totalSales
  from Selling Join Publication on Selling.idPublication = Publication.id
      join User on Publication.iduser = User.idperson
      natural join Locality
      join Country on Locality.nameCountry = Country.code
  group by Country.code
);
