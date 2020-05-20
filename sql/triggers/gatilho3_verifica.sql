
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (189, 934330216, "TEST1@gmail.com",  41278833120087, "rua dos bobos, numero zero", 123, 6449); 
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (190, 934332316, "TEST3@gmail.com",  41378833123087, "rua dos bobos, numero zero", 123, 6449); 
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (188, 934320216, "TEST2@gmail.com",  41278883120087, "rua dos bobos, numero zero", 123, 6449); 
insert into Publication(description, price, idUser, ISBN) VALUES('TEST2', 231.0, 188, 4870295404161);
insert into Selling(idPublication, idUser,idPayment, evaluation) VALUES(31, 189, 1, 5);


select * from User; 

delete from User where idPerson = 189; 

select * from User; 

delete from User where idPerson = 190; 

select * from User; 

delete from User where idPerson = 188; 

select * from User; 


