.mode columns
.headers on
.nullvalue NULL


-- hard1: qual a diferença da nota média das compras entre utilizadores de Portugal e de fora?
SELECT PT.avg - EX.avg FROM (
    SELECT AVG(rate) AS avg FROM SellerEvaluation NATURAL JOIN (
        SELECT evaluation AS id FROM Selling NATURAL JOIN (
            SELECT idperson AS iduser, code FROM User NATURAL JOIN (
                SELECT localitycode, code FROM Locality JOIN Country WHERE namecountry = code
            ) WHERE code = 'PT'
        )
    )
) AS PT,
    (SELECT AVG(rate) AS avg FROM SellerEvaluation NATURAL JOIN (
        SELECT evaluation AS id FROM Selling NATURAL JOIN (
            SELECT idperson AS iduser, code FROM User NATURAL JOIN (
                SELECT localitycode, code FROM Locality JOIN Country WHERE namecountry = code
            ) WHERE code <> 'PT'
        )
    )
) AS EX;
