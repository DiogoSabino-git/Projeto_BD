DELIMITER $$

CREATE PROCEDURE criar_leilao(
    IN p_data_inicio DATE,
    IN p_local VARCHAR(50)
)
BEGIN
    INSERT INTO leiloes (data_inicio, local)
    VALUES (p_data_inicio, p_local);
END $$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE adicionar_artigo(
	IN p_id_lote INT,
    IN p_preco_inicial NUMERIC(10,2),
    IN p_descricao VARCHAR(250)
)
BEGIN 
	INSERT INTO artigos(id_lote, preco_inicial, descricao)
    VALUES (p_id_lote, p_preco_inicial, p_descricao);
END $$
DELIMITER ;
    