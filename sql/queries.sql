-- easy1: quais os livros mais bem avaliados pelos habitantes de Portugal?
SELECT isbn, AVG(rate) FROM BookEvaluation NATURAL JOIN (
  SELECT idperson, code FROM User NATURAL JOIN (
    SELECT localitycode, code FROM Locality JOIN Country WHERE namecountry = code
  )
) GROUP BY isbn ORDER BY rate DESC;

-- medium1: qual o livro vendido em mais países?
SELECT isbn, max(countries) FROM (
	SELECT isbn, code, COUNT(DISTINCT code) AS countries FROM Publication JOIN (
		SELECT idperson, code FROM User NATURAL JOIN (
			SELECT localitycode, code FROM Locality JOIN Country WHERE namecountry = code
		)
	) WHERE idUser = idperson GROUP BY isbn
);

-- avg for the easy question 3 
select avg(q.price), b.name, p.isbn 
from (  select price, isbn 
        from publication) as q, book b, publication p
where q.isbn = b.isbn and p.isbn = b.isbn
group by p.isbn; 

--medium4: quais os id's dos utilizadores que possuem publicações de livros com avarage rating maior ou igual a 4 do idioma francês?
-- Porque é relevante: sugestão de compra para usuários
create temp view if not exists bookRating as 
select be.isbn, avg(rate) 
from book b join bookevaluation be on (be.isbn = be.isbn)  
where rate >= 4 
group by be.isbn; 

select p.idUser, p.isbn, l.code 
from publication p, BookLanguage bl, language l
where p.isbn in (select isbn from bookRating) and bl.codeLanguage = l.code and bl.isbn = p.isbn and l.name = 'French'; 

-- medium3: quais as percentagens mais comuns aplicadas em promoções (intervalos de 10 valores)? 
-- Sugestão de aplicação de promoção aos vendedores 

create temp view if not exists promoPubli as 
select idpublication, round(percentage/10)*10 as percentage_10
from promotionpublication pp, publication pub, promotion promo 
where pp.idpublication = pub.id and pp.idpromotion = promo.id;

select percentage_10, count(percentage_10) as frequency
from promoPubli 
group by percentage_10 
order by frequency desc ; 

-- hard3: qual o id dos usuários que tiveram todos os seus livros vendidos?

--Quantidade de publicações de cada utilizador
select idUser, count(id)
from publication 
group by idUser; 

-- Quantas vendas foram feitas por uma pessoa 
select idUser, count(idPublication) sold 
from selling
group by idUser; 

--Quem vendeu todos os livros 

select distinct(sold.idUser), soldBooks, nPublications
from    (select idUser, count(idPublication) soldBooks from selling group by idUser) as sold, 
        (select idUser, count(id) nPublications from publication group by idUser) as publications 
where sold.idUser = publications.idUser and nPublications = soldBooks and nPublications != 0; 
