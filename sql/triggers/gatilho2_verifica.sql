INSERT INTO Person(name, birth) VALUES('Crisitano Reinaldo', '1961-7-21');
INSERT INTO User(idPerson, contact, email, account, address, streetCode, localityCode) VALUES(192, 910809237, 'olaole@gmail.com', 41278833120087, '56, Av. Boavista, Porto PT', 123, 6323);

INSERT INTO Publication(description, price, idUser, ISBN) VALUES('TEST1', 231.0, 192, 4870295404161);
INSERT INTO Publication(description, price, idUser, ISBN) VALUES('TEST2', 231.0, 192, 4870295404161);
INSERT INTO Publication(description, price, idUser, ISBN) VALUES('TEST3', 231.0, 192, 4870295404161);

INSERT INTO Selling(idPublication, idUser,idPayment, evaluation) VALUES(33, 192, 1, 5);

select * from Publication order by iduser;

DELETE FROM User where User.idPerson = 192;

select * from Publication order by iduser;

delete from Selling where selling.idPublication = 33;
DELETE FROM Publication where Publication.id = 33;
delete from Person where id = 192;
