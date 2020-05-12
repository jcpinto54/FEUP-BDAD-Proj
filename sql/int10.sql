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

CREATE TABLE IF NOT EXISTS pairUser (user1, user2, isbn); 
CREATE TABLE IF NOT EXISTS auxiliar (user1, user2, isbn); 

CREATE TRIGGER IF NOT EXISTS t
AFTER INSERT ON pairUser
FOR EACH ROW  
WHEN NOT EXISTS (SELECT * FROM pairuser WHERE (user1 = new.user2 AND user2 = new.user1 AND isbn = new.isbn) ) 
BEGIN
INSERT INTO auxiliar(user1, user2, isbn) VALUES(new.user1, new.user2, new.isbn);  
END; 

INSERT INTO pairUser (user1, user2, isbn) 
SELECT s1.user AS user1, s2.user AS user2, s1.isbn
FROM idUserBook s1, idUserBook s2
WHERE s1.isbn = s2.isbn AND s2.user <> s1.user; 

SELECT * FROM auxiliar; 

DROP TABLE pairuser; 
DROP TABLE auxiliar; 
