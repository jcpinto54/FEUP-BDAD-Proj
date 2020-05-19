Create Trigger deleteUser
Before Delete On User
For Each Row
Begin
Delete from Publication where (
	idUser = Old.idPerson 
	AND
    Publication.id not in (select idPublication from Selling));
End;
