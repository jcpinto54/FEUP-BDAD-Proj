drop trigger if exists gatilho3 ; 

--in order to preserve the original data, we are going to delete the data added from gatilho3_verifica.sql 
delete from User 
where idPerson = 187 or idPerson = 186 or idPerson = 185 ; 

delete from User 
where idPerson = 184 or idPerson = 183 or idPerson = 182 ;

delete from User 
where idPerson = 188 or idPerson = 189 or idPerson = 190;

delete from publication 
where id= 38 or id = 39 or id = 40; 

delete from selling 
where idPublication = 38 or idPublication = 40 or idPublication = 39; 