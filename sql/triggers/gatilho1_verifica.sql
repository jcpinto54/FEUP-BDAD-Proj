SELECT id AS idpublication, idUser AS idSeller FROM Publication;
SELECT idpublication, idUser AS idBuyer FROM Selling;

INSERT INTO Selling VALUES(1, "2020-02-02", 13, 1, NULL);

-- Não foi adicionado
SELECT idpublication, idUser AS idBuyer FROM Selling;

INSERT INTO Selling VALUES(1, "2020-02-02", 7, 1, NULL);

-- Foi adicionado
SELECT idpublication, idUser AS idBuyer FROM Selling;
