.mode columns
.headers on
.nullvalue NULL

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
