DELIMITER $$
DROP PROCEDURE IF EXISTS criar_leilao $$

CREATE PROCEDURE criar_leilao(
    IN data_inicio DATE,
    IN local VARCHAR(50)
)
BEGIN
    INSERT INTO leiloes (data_inicio, local)
    VALUES (data_inicio, local);
END $$
DELIMITER ;
