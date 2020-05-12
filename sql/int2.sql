.mode columns
.headers on
.nullvalue NULL


-- easy2: qual o preço médio de venda de cada um dos livros?
select avg(q.price), b.name, p.isbn 
from (  select price, isbn 
        from publication) as q, book b, publication p
where q.isbn = b.isbn and p.isbn = b.isbn
group by p.isbn; 
