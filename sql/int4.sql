.mode columns
.headers on
.nullvalue NULL

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
