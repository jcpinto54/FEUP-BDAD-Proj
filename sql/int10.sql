.mode columns
.headers on
.nullvalue NULL
-- Hard 3
-- Quais os utilizadores que compraram um livro em comum e qual o livro? 
-- Pares de usuários na ordem inversa que partilham o mesmo livro não devem aparecer novamente. Nomeadamente o caso abaixo: 
-- user1 | user2 | isbn | 
-- us1   | us2   | 1    | 
-- us2   | us1   | 1    | 
-- Por outro lado, se dois usuarios compraram o mesmo livro mais de uma vez eles irão aparecer repetidamente na lista. 

create view if not exists idUserBook as 
select p.isbn as isbn, s.idUser as user 
from selling s, publication p 
where p.id = s.idPublication; 

select s1.user as user1, s2.user as user2, s1.isbn 
from idUserBook s1, idUserBook s2 
where s1.isbn = s2.isbn and s2.user < s1.user; 