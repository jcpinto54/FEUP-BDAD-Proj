--Case that the user didn't performed any publication neither purchase 
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (190, 934330216, "aividinha@gmail.com", 44268836171088, "199, Rua dos bobos, Narnia", 000, 1000); 
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (189, 934330217, "aividamon@gmail.com", 44268836171089, "200, Rua dos bobos, Narnia", 001, 1001);
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (188, 934330215, "aividamonamia@gmail.com", 44268836171090, "201, Rua dos bobos, Narnia", 002, 1002);
--Users that did a purchase 
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (187, 934330213, "aividinho@gmail.com", 44268836174087, "129, Rua dos bobos, Narnia", 003, 1004); 
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (186, 934330214, "aividamoo@gmail.com", 44268836171086, "220, Rua dos bobos, Narnia", 004, 1005);
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (185, 934330212, "aividamonamio@gmail.com", 44268836171099, "221, Rua dos bobos, Narnia", 005, 1006);
--Users that did a publication 
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (184, 934333213, "aividinhr@gmail.com", 44268826171087, "229, Rua dos bobos, Narnia", 006, 1007); 
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (183, 934330814, "aividamor@gmail.com", 44268826171086, "420, Rua dos bobos, Narnia", 007, 1008);
insert into User(idPerson, contact, email, account, address, streetCode, localityCode) values (182, 934300212, "aividamonamir@gmail.com", 44368836171099, "321, Rua dos bobos, Narnia", 008, 1306);


insert into publication(description, price , idUser,ISBN) values ("Livro em bom estado, com pouco uso! Enredo muito interessante. Obra-prima!", 300, 184, 4870295404161);  --idPublication = 38 
insert into publication(description, price, idUser,ISBN) values  ("Livro em bom estado, com pouco uso! Enredo muito interessante. Obra-prima!", 300, 183, 4870295404161);  --idPublication = 39 
insert into publication(description, price , idUser,ISBN) values ("Livro em bom estado, com pouco uso! Enredo muito interessante. Obra-prima!", 300, 182, 4870295404161);  --idPublication = 40 

insert into selling(idPublication, idUser, idPayment, evaluation) values (38, 187, 1, 3); 
insert into selling(idPublication, idUser, idPayment, evaluation) values (39, 186, 1, 3);  
insert into selling(idPublication, idUser, idPayment, evaluation) values (40, 185, 1, 3);  


--Try to delete users that do not have neither a publication nor purchase   -- SUCCESS EXPECTED 
delete from User 
where idPerson = 188 or idPerson = 189 or idPerson = 190; 
-- Try to delete users that did a selling                                   -- FAIL EXPECTED 
delete from User 
where idPerson = 187 or idPerson = 186 or idPerson = 185; 
-- Try to delete useras that did a publication                              --FAIL EXPECTED 
delete from User 
where idPerson = 184 or idPerson = 183 or idPerson = 182 ; 


--ATENTION: do not try again without executing gatilho3_remove.sql
