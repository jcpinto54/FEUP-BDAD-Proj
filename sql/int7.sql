.mode columns
.headers on
.nullvalue NULL

-- medium4: qual o id dos usuários que tiveram todos os seus livros vendidos e quantos livros venderam?
-- Quem vendeu todos os livros 
select distinct(sold.idUser), soldBooks, nPublications
from    (select idUser, count(idPublication) soldBooks from selling group by idUser) as sold, 
        (select idUser, count(id) nPublications from publication group by idUser) as publications 
where sold.idUser = publications.idUser and nPublications = soldBooks and nPublications != 0; 
