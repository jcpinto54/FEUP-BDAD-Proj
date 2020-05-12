.mode columns
.headers on
.nullvalue NULL

-- easy1: qual o isbn e a média das classificações dos livros mais bem avaliados pelos habitantes de Portugal?
SELECT isbn, AVG(rate) FROM BookEvaluation NATURAL JOIN (
  SELECT idperson, code FROM User NATURAL JOIN (
    SELECT localitycode, code FROM Locality JOIN Country WHERE namecountry = code
  )
) GROUP BY isbn ORDER BY rate DESC;