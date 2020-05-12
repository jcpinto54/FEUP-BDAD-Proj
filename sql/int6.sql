.mode columns
.headers on
.nullvalue NULL


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
