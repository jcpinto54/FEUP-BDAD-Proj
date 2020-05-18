CREATE TRIGGER BuySell
BEFORE INSERT ON Selling
WHEN new.idUser = (
SELECT idUser AS idSeller 
  FROM Publication 
  WHERE id = new.idPublication
)
BEGIN
	SELECT RAISE(IGNORE);
END;