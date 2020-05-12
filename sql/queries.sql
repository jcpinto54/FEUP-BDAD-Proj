-- easy1: qual o isbn e a média das classificações dos livros mais bem avaliados pelos habitantes de Portugal?
SELECT isbn, AVG(rate) FROM BookEvaluation NATURAL JOIN (
  SELECT idperson, code FROM User NATURAL JOIN (
    SELECT localitycode, code FROM Locality JOIN Country WHERE namecountry = code
  )
) GROUP BY isbn ORDER BY rate DESC;

-- easy2: qual o preço médio de venda de cada um dos livros?
select avg(q.price), b.name, p.isbn 
from (  select price, isbn 
        from publication) as q, book b, publication p
where q.isbn = b.isbn and p.isbn = b.isbn
group by p.isbn; 

-- easy3: qual mês tem maior número de promoções?
select strftime('%m', start) month, count(idpromotion) as nrPromotions
from book natural JOIN publication
	join publisher on publisher.id = book.idpublisher
	join PromotionPublication on PromotionPublication.idPublication = Publication.id
    join Promotion on Promotion.id = PromotionPublication.idpromotion
	group by strftime('%m', start)
    having nrPromotions = (Select max(nr) from
			(select count(idpromotion) as nr
				from book natural JOIN publication
              join publisher on publisher.id = book.idpublisher
              join PromotionPublication on PromotionPublication.idPublication = Publication.id
              join Promotion on Promotion.id = PromotionPublication.idpromotion
              group by strftime('%m', start)));

-- medium1: qual o id, o nome e quantidade de livros em promoção da editora que possui menos livros em promoção?
select idpublisher, Publisher.name, count(idpublisher) as C
from book natural JOIN publication
	join publisher on publisher.id = book.idpublisher
	join PromotionPublication on PromotionPublication.idPublication = Publication.id
    join Promotion on Promotion.id = PromotionPublication.idpromotion
group by idpublisher
having C = (Select max(c) from
			(select idpublisher, count(idpublisher) as C
			from book natural JOIN publication
            join publisher on publisher.id = book.idpublisher
            join PromotionPublication on PromotionPublication.idPublication = Publication.id
            join Promotion on Promotion.id = PromotionPublication.idpromotion
            group by idpublisher
     ))   ;

-- medium2: quais as percentagens mais comuns aplicadas em promoções (intervalos de 10 valores) e quantas vezes cada percentagem é utilizada? 
-- Sugestão de aplicação de promoção aos vendedores 
create temp view if not exists promoPubli as 
select idpublication, round(percentage/10)*10 as percentage_10
from promotionpublication pp, publication pub, promotion promo 
where pp.idpublication = pub.id and pp.idpromotion = promo.id;

select percentage_10, count(percentage_10) as frequency
from promoPubli 
group by percentage_10 
order by frequency desc ; 

-- medium3: quais os id's dos utilizadores que possuem publicações de livros com avarage rating maior ou igual a 4 do idioma francês?
-- Porque é relevante: sugestão de compra para usuários
create temp view if not exists bookRating as 
select be.isbn, avg(rate) 
from book b join bookevaluation be on (be.isbn = be.isbn)  
where rate >= 4 
group by be.isbn; 

select p.idUser, p.isbn, l.code 
from publication p, BookLanguage bl, language l
where p.isbn in (select isbn from bookRating) and bl.codeLanguage = l.code and bl.isbn = p.isbn and l.name = 'French'; 

-- medium4: qual o id dos usuários que tiveram todos os seus livros vendidos e quantos livros venderam?
-- Quem vendeu todos os livros 
select distinct(sold.idUser), soldBooks, nPublications
from    (select idUser, count(idPublication) soldBooks from selling group by idUser) as sold, 
        (select idUser, count(id) nPublications from publication group by idUser) as publications 
where sold.idUser = publications.idUser and nPublications = soldBooks and nPublications != 0; 

-- hard1: qual a diferença da nota média das compras entre utilizadores de Portugal e de fora?
SELECT PT.avg - EX.avg FROM (
    SELECT AVG(rate) AS avg FROM SellerEvaluation NATURAL JOIN (
        SELECT evaluation AS id FROM Selling NATURAL JOIN (
            SELECT idperson AS iduser, code FROM User NATURAL JOIN (
                SELECT localitycode, code FROM Locality JOIN Country WHERE namecountry = code
            ) WHERE code = 'PT'
        )
    )
) AS PT,
    (SELECT AVG(rate) AS avg FROM SellerEvaluation NATURAL JOIN (
        SELECT evaluation AS id FROM Selling NATURAL JOIN (
            SELECT idperson AS iduser, code FROM User NATURAL JOIN (
                SELECT localitycode, code FROM Locality JOIN Country WHERE namecountry = code
            ) WHERE code <> 'PT'
        )
    )
) AS EX;

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
