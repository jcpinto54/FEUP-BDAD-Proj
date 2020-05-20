create trigger gatilho3 
before delete on User 
for each row 
when ( exists (
    select idUser 
    from publication, User
    where publication.idUser = User.idPerson and old.idPerson = User.idPerson and 
    exists (select * from selling where selling.idPublication = publication.id))
    OR
    --person has purchased something
    exists( 
        select idUser 
        from selling, user
        where selling.idUser = user.idPerson and old.idPerson = User.idPerson) )
    
begin 
    select raise(ignore);
end; 
