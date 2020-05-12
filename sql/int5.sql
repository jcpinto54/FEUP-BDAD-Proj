.mode columns
.headers on
.nullvalue NULL


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